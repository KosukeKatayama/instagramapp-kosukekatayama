class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @useername = current_user.username
  end
end