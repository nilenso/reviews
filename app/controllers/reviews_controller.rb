class ReviewsController < ApplicationController

  def index
  end

  def create
    updated_review_params = update_params_with_review_year(review_params)
    Review.find_or_create_by updated_review_params
    render json: {status: :ok}
  end

  def update_params_with_review_year(review_params)
    current_year = Time.now.year.to_s
    review_params.merge!(review_year: ReviewYear.find_or_create_by(name: current_year))
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
