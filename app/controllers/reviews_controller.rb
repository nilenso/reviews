class ReviewsController < ApplicationController

  def index
  end

  def create
    current_year = Time.now.year.to_s
    review_year = ReviewYear.find_or_create_by :name => current_year
    review = Review.new(review_params)
    review.review_year = review_year
    review.save
    render json: {status: :ok}
  end

  def destroy
    Review.where(review_params).first!.destroy
    render json: {status: :ok}
  end

  private

  def review_params
    params.permit(:reviewer_id, :reviewee_id)
  end
end
