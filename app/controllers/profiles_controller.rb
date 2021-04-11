class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @useername = current_user.username
  end

  private
    def profile_params
      params.require(:profile).permit(:avatar, :nickname)
    end
end
