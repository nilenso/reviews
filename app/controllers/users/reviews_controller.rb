class Users::ReviewsController < ApplicationController
  def index
    @users = User.all.decorate
  end

  def edit
    @review = Review.find(params[:id]).decorate
  end

  def show
    @review = Review.find(params[:id]).decorate
    @comment = Comment.build_from(@review, current_user.id, nil)
  end

  def update
    if params.key?(:pending)
      params[:review].merge!(status: 'pending')
    elsif params.key?(:done)
      params[:review].merge!(status: 'done')
    end

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
