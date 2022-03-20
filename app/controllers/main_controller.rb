class MainController < ApplicationController
  before_action :authenticate_user!
  def home
    if current_user.rol != "lider"
      redirect_to campaigns_path  
    elsif current_user.rol == "lider"
      redirect_to "/campaigns/#{current_user.campaign.first.id}"  
    end
  end
end
