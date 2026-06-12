class ReviewsController < ApplicationController
  # require login to create a review, only let users edit and delete their own reviews
  before_action :require_login
  before_action :set_own_review, only: %i[ edit update destroy ]

  # create a new review
  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.build(review_params)
    @review.user = current_user
  
    # save the review
    if @review.save
      redirect_to @product, notice: "Review added."
    else
      redirect_to @product, alert: @review.errors.full_messages.to_sentence
    end
  end

  def edit
  end

  def update
    # update and redirect to the product page
    if @review.update(review_params)
      redirect_to @review.product, notice: "Review updated."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    product = @review.product
    @review.destroy!
    redirect_to product, notice: "Review deleted.", status: :see_other
  end

  private

  # let users only manage their own reviews
  def set_own_review
    @review = current_user.reviews.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "You can only manage your own reviews."
  end

  def review_params
    params.expect(review: [ :rating, :comment ])
  end
end
