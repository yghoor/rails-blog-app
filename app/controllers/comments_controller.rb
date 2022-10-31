class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
  end

  def create
    comment = current_user.comments.new(comment_params)
    @post = Post.find(params[:post_id])
    comment.post = @post

    if comment.save
      flash[:success] = 'Comment saved successfully'
      redirect_to user_post_path(current_user, @post)
    else
      flash.now[:error] = 'Error: Comment could not be saved'
      render :new, locals: { comment: }
    end
  end

  def destroy
    Comment.find(params[:id]).delete
    redirect_to user_post_path(current_user, params[:post_id])
  end

  private

  def comment_params
    params.require(user_post_comments_url).permit(:text)
  end
end
