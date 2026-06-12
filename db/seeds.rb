
WishlistItem.delete_all
Favorite.delete_all
Review.delete_all
Cartitem.delete_all
Order.delete_all
Cart.delete_all
Product.delete_all
c_book = Product.create!(name: "The C Programming Language",
    description:
    %{
        Book Descriptions
    },
    image: "cp.png",
    price: 49.95)

ruby_book = Product.create!(name: "The Ruby Programming Language",
    description:
    %{
        Book Descriptions
    },
    image: "ruby.png",
    price: 49.95)

ruby19_book = Product.create!(name: "Programming Ruby 1.9",
    description:
    %{
        Book Descriptions
    },
    image: "ruby1.9.png",
    price: 49.95)

# Users
User.delete_all
admin = User.create!(username: "admin", password: "password", password_confirmation: "password", admin: true)
Hannah = User.create!(username: "Hannah", password: "password", password_confirmation: "password", admin: false)
Yuan = User.create!(username: "Yuan", password: "password", password_confirmation: "password", admin: false)

# Reviews
Review.create!(user: Yuan, product: c_book, rating: 5,
    comment: "What a useful book! I used this to teach my students C programming.")
Review.create!(user: Hannah, product: c_book, rating: 4,
    comment: "Wow, this book is sooo helpful. Very long but useful to learn C.")
Review.create!(user: admin, product: ruby_book, rating: 5,
    comment: "Great book, this is my holy grail for Ruby books.")
Review.create!(user: Hannah, product: ruby19_book, rating: 3,
    comment: "This is great, I feel like it goes over the basics, but it could be better")

# Favorites
Favorite.create!(user: Hannah, product: ruby_book)
Favorite.create!(user: Hannah, product: c_book)
Favorite.create!(user: Yuan, product: ruby_book)

# Sample order (for order history demo)
sample_order = Order.create!(user: Hannah, name: "Hannah",
    email: "user@example.com", pay_type: "Credit card")
sample_order.cartitems.create!(product: c_book, quantity: 1)
sample_order.cartitems.create!(product: ruby19_book, quantity: 2)

# Wishlist (saved for later)
WishlistItem.create!(user: Hannah, product: ruby_book, quantity: 1)
