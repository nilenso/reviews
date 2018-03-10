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
    updated_review_params = update_if_level_only_review(update_status(review_params))

    @review = Review.find(params[:id])
    @review.assign_attributes(updated_review_params)

    if @review.save
      redirect_to :root, notice: 'Review saved successfully!'
    else
      render :edit
    end
  end

  private

  def update_if_level_only_review(review_params)
    if review_params[:text].strip.blank? && !review_params[:suggested_level].blank?
      review_params.merge!(is_level_only: true)
    end

    review_params
  end

  def update_status(review_params)
    if params.key?(:pending)
      review_params.merge!(status: 'pending')
    elsif params.key?(:done)
      review_params.merge!(status: 'done')
    end

    review_params
  end

  def review_params
    params.require(:review).permit(:text, :suggested_level, :is_level_only)
  end
end
