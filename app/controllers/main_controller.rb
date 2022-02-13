class MainController < ApplicationController
  before_action :authenticate_user!
  def home
    redirect_to campaigns_path

  end
end
