#any product object is an instance of Product model
class Product < ApplicationRecord
    validates( :name, :description, :image, :price, presence: true)
    validates( :price, numericality: { greater_than_or_equal_to: 0.01 })
    validates(:image, format: {with: %r(\.(gif|jpg|png)\Z)i,  
            message: "must be a URL for GIF, JPG or PNG image."})
    validates(:name, uniqueness: true)

    has_many :cartitems, dependent: :destroy
    has_many :reviews, dependent: :destroy
    has_many :favorites, dependent: :destroy

    scope :search, ->(query) {
        where("name LIKE :q OR description LIKE :q", q: "%#{query}%") if query.present?
    }

    SORTS = {
        "name"       => { name: :asc },
        "price_low"  => { price: :asc },
        "price_high" => { price: :desc }
    }.freeze

    def self.sorted_by(key)
        order(SORTS.fetch(key, SORTS["name"]))
    end

    def average_rating
        reviews.average(:rating)&.round(1)&.to_f
    end

    before_destroy :make_sure_no_cart_items_under_this_product

    # no cart items under this product
    def make_sure_no_cart_items_under_this_product
        if self.cartitems.empty?
            return true
        else
            return false
        end
    end

end
