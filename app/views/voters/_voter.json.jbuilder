json.extract! voter, :id, :name, :seccion, :clave_elector, :created_at, :updated_at
json.url voter_url(voter, format: :json)
