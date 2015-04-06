class Users::ReviewsController < ApplicationController
  def index
    @users = current_user.all_but_me.decorate
  end

  def edit
    @review = Review.find(params[:id]).decorate
  end

  def show
    @review = Review.find(params[:id]).decorate
  end

  def update
    @review = Review.find(params[:id])
    @review.assign_attributes(review_params)
    if @review.save
      redirect_to :root, notice: "Review saved successfully!"
    else
      render :edit
    end
  end

  private

  def review_params
    params.require(:review).permit(:text, :status, :suggested_level)
  end
end
