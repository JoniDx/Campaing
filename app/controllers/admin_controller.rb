class AdminController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: [:edit]

    def index
        if current_user.rol = 'superusuario'            
            @admins_email = User.where(rol:'administrador')
                                .ransack(email_cont: params[:q])
                                .result(distinct: true)
                                .order(created_at: :desc)                       
                                .paginate(page: params[:page], per_page: 6)

            @admins_name = User.where(rol:'administrador')
                                .ransack(name_cont: params[:q])
                                .result(distinct: true)
                                .order(created_at: :desc)                       
                                .paginate(page: params[:page], per_page: 6)                                
        end
    end

    def create
        
    end

    def edit
        
    end

    private
    def set_user
        @user = User.find(params['id'])
    end
end
