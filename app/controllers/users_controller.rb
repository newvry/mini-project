class UsersController < ApplicationController

  def profile
    @topics = current_user.topics
    @comments = current_user.comments

    if params[:id]
      @comment = Comment.find(params[:id])
    else
      @comment = Comment.new
    end

    if current_user.profile.present?
      @profile = current_user.profile
    else
      @profile = Profile.new
    end
  end

  def edit_profile
    @profile = current_user.build_profile(profile_params)
    @profile.save
    redirect_to profile_users_path
  end

  def edit_my_comment
    @comment = Comment.find(params[:id])
      @comment.update(my_comment_params)
    if @comment.save
      redirect_to profile_users_path
    end
  end

  def del_my_comment
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to profile_users_path
  end

  private

  def profile_params
    params.require(:profile).permit(:content)
  end

  def my_comment_params
    params.require(:comment).permit(:content)
  end

end
