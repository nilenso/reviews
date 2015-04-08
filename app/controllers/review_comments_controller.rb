class ReviewCommentsController < ApplicationController
  def new
    @review = Review.find(params[:review_id]).decorate
    @comment = Comment.build_from(@review, current_user.id, nil).decorate
    @comment.parent_id = params[:parent_id]
  end

  def create
    puts params
    @review = Review.find(params[:review_id]).decorate
    @comment = Comment.build_from(@review, current_user.id, comment_params[:body]).decorate
    if @comment.save
      @comment.move_to_child_of(Comment.find(params[:comment][:parent_id])) if params[:comment][:parent_id].present?
      redirect_to user_review_path(current_user, @review), notice: "Comment saved!"
    else
      render :new
      flash[:error] = "Comment didn't save!" + @comment.errors.to_a.join
    end
  end

  def edit
    @review = Review.find(params[:review_id]).decorate
    @comment = Comment.find(params[:id]).decorate
  end

  def update
    @review = Review.find(params[:review_id]).decorate
    @comment = Comment.find(params[:id]).decorate
    if @comment.update_attributes(comment_params)
      redirect_to user_review_path(current_user, @review), notice: "Comment saved!"
    else
      render :edit
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
