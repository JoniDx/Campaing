class DashboradController < ApplicationController
    before_action :authenticate_user!

    def index

        if current_user.rol == 'administrador'
            redirect_to '/dashboard/'
        elsif current_user.rol == 'administrador_campaing'
            redirect_to "/dashboard/"
        elsif current_user.rol == 'lider'
            redirect_to "/dashboard/"
        else
            redirect_to '/dashboard/'
        end

    end

    def users
        @rol = params[:rol]
        @title = @rol.capitalize
        render '/dashboard/users_partials/users'
    end
end
