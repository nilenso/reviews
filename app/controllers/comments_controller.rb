class CommentsController < ApplicationController
  def new
    @commentable = commentable_class.find(params[:commentable_id]).decorate
    @comment = Comment.build_from(@commentable, current_user.id, nil).decorate
    @comment.parent_id = params[:parent_id]
  end

  def create
    @commentable = commentable_class.find(params[:commentable_id]).decorate
    @comment = Comment.build_from(@commentable, current_user.id, comment_params[:body]).decorate
    if @comment.save
      @comment.move_to_child_of(Comment.find(params[:comment][:parent_id])) if params[:comment][:parent_id].present?
      redirect_to commentable_path, notice: "Comment saved!"
    else
      render :new
      flash[:error] = "Comment didn't save!" + @comment.errors.to_a.join
    end
  end

  def edit
    @commentable = commentable_class.find(params[:commentable_id]).decorate
    @comment = Comment.find(params[:id]).decorate
  end

  def update
    @commentable = commentable_class.find(params[:commentable_id]).decorate
    @comment = Comment.find(params[:id]).decorate
    if @comment.update_attributes(comment_params)
      redirect_to commentable_path, notice: "Comment saved!"
    else
      render :edit
    end
  end

  def destroy
    @commentable = commentable_class.find(params[:commentable_id]).decorate
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to commentable_path, notice: "Deleted!"
  end

  private

  def commentable_class
    if params[:commentable_type] == 'review'
      Review
    elsif params[:commentable_type] == 'user'
      User
    end
  end

  def commentable_path
    if params[:commentable_type] == 'review'
      user_review_path(current_user, @commentable)
    elsif params[:commentable_type] == 'user'
      user_path(@commentable)
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
