class UsersController < ApplicationController

  def profile
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



  private

  def profile_params
    params.require(:profile).permit(:content)
  end

end
