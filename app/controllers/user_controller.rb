class UserController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: [:update, :show, :delete, :destroy, :restore]


    def create
        @user = User.new(user_params)

        respond_to do |format|
            if @user.rol == 'lider' && (current_user.rol == 'administrador' || current_user.rol == 'superusuario')
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
            elsif current_user.rol == 'superusuario'


                case params[:membership]
                when "month"
                    membership = DateTime.now + 1.month
                when "year"
                    membership = DateTime.now + 1.year
                else
                    format.html { redirect_to admin_index_path, notice: 'Seleccione un plaso valido' }
                end

                @user.membership = membership

                if @user.save
                    format.html { redirect_to admin_index_path, notice: 'Administrador Creado' }
                    format.json { render :show, status: :created, location: @user }
                else
                    format.html { redirect_to admin_index_path, notice: 'Error al crear' }
                    format.json { render json: @user.errors, status: :unprocessable_entity }        
                end
            end
        end

    end

    def update
        respond_to do |format|
            if @user.update(user_params)
                if params[:campaign]
                    @user.campaings_user[0].update(campaign_id: params[:campaign])
                end
                if @user.rol == "lider"
                    path = "lider"
                else
                    path = "admin"
                end
                
                format.html { redirect_to "/#{path}/index", notice: 'Actualizado' }
                format.json { render :show, status: :created, location: @user }
            else
                format.html { render "/#{path}/index" }
                format.json { render json: @product.errors, status: :unprocessable_entity }
            end
        end
    end
    
    def show
        
    end

    def delete
        
    end
    
    def destroy
        @user.update(is_active: false)
        if @user.rol == "lider"
            path = "lider"
        else
            path = "admin"
        end
        respond_to do |format|
            format.html { redirect_to "/#{path}/index", notice: 'Actualizado' }
            format.json { head :no_content }
        end

      end
    
      def restore
        @user.update(is_active: true)
        if @user.rol == "lider"
            path = "lider"
        else
            path = "admin"
        end
        respond_to do |format|
            format.html { redirect_to "/#{path}/index", notice: 'Actualizado' }
            format.json { head :no_content }
        end
      end
    

    private
    def set_user
        @user = User.find(params['id'])
    end

    def user_params
        if params[:user][:password].blank?
            params.require(:user).permit(:name, :email)
        else
            params.require(:user).permit(:name, :email, :password, :rol, :create_by)
        end
    end

end
