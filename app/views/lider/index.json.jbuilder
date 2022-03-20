if params[:c]
    case params[:c]
    when "name"
        json.array! @lideres_name, partial: "lider/lider", as: :lider
    when "email"                      
        json.array! @lideres_email, partial: "lider/lider", as: :lider
    end                                
  else
    json.array! @lideres_name, partial: "lider/lider", as: :lider
end
