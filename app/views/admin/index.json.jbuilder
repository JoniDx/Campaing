if params[:c]
    case params[:c]
    when "name"
        json.array! @admins_name, partial: "admin/admin", as: :admin
    when "email"                      
        json.array! @admins_email, partial: "admin/admin", as: :admin
    end                                
  else
    json.array! @admins_name, partial: "admin/admin", as: :admin
end
