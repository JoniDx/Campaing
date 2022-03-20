if params[:s]
    case params[:s]
    when "name"
        json.array! @voters_name, partial: "voters/voter", as: :voter
    when "seccion"                      
        json.array! @voters_seccion, partial: "voters/voter", as: :voter
    when "clave_elector"
        json.array! @voters_clave_elector, partial: "voters/voter", as: :voter

    end                                
  else
    json.array! @voters_name, partial: "voters/voter", as: :voter
end
