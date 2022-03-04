class LiderController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: [:edit]

    def index
        if current_user.rol = 'superusuario'            
            @lideres = User.where(rol:'lider')
                        .ransack(email_cont: params[:q])
                        .result(distinct: true)
                        .order(created_at: :desc)                       
                        .paginate(page: params[:page], per_page: 6)

        elsif current_user.rol = 'administrador'     
            @lideres = User.where(rol:'lider', create_by:current_user.id)
                            .ransack(email_cont: params[:q])
                            .result(distinct: true)
                            .ransack(name_cont: params[:q])
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
