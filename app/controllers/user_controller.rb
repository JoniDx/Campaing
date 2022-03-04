class UserController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: [:update, :show, :delete]


    def create
        @user = User.new(user_params)
        if @user.rol == 'lider' && (current_user.rol == 'administrador' || current_user.rol == 'superusuario')
            respond_to do |format|
                if @user.save
                    @user_campaing = CampaingsUser.new(user_id: @user.id, campaign_id: params['campaign'], rol: @user.rol) 
                    if @user_campaing.save
                        format.html { redirect_to lider_index_path, notice: 'Lider Creado' }
                        format.json { render :show, status: :created, location: @user }
                    else
                        format.html { render lider_index_path }
                        format.json { render json: @user.errors, status: :unprocessable_entity }
                    end
                else
                    format.html { render lider_index_path }
                    format.json { render json: @user.errors, status: :unprocessable_entity }
                end
            end
        elsif current_user.rol == 'superusuario'
            respond_to do |format|
                if @user.save
                    format.html { redirect_to admin_index_path, notice: 'Administrador Creado' }
                    format.json { render :show, status: :created, location: @user }
                else
                    format.html { render lider_index_path }
                    format.json { render json: @user.errors, status: :unprocessable_entity }        
                end
            end
        end
    
    end

    def update
        respond_to do |format|
            if @user.update(user_params)

                @user.campaings_user[0].update(campaign_id: params[:campaign])
                
                format.html { redirect_to lider_index_path, notice: 'Actualizado' }
                format.json { render :show, status: :created, location: @product }
            else
                format.html { render lider_index_path }
                format.json { render json: @product.errors, status: :unprocessable_entity }
            end
        end
    end
    
    def show
        
    end

    def delete
        
    end
    
    

    private
    def set_user
        @user = User.find(params['id'])
    end

    def user_params
        if params[:user][:password].blank?
            params.require(:user).permit(:email)
        else
            params.require(:user).permit(:email, :password, :rol, :create_by)
        end
    end

end
