class Apps::ProfilesController < Apps::ApplicationController
  def show; end

  def update
    @profile = current_user.prepare_profile
    @profile.assign_attributes(profile_params)
    if @profile.save
      redirect_to profile_path, notice: 'プロフィールが更新されました'
    else
      flash.now[:error] = 'プロフィールが更新できませんでした'
      redirect_to profile_path
    end
  end

  private

  def profile_params
    params.permit(:avatar)
  end
end
