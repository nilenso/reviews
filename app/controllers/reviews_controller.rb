class ReviewsController < ApplicationController


  def index
  end

  def create
    Review.create(review_params)
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
