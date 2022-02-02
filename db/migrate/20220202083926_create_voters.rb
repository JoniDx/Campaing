class CreateVoters < ActiveRecord::Migration[6.1]
  def change
    create_table :voters do |t|
      t.string :name
      t.string :last_name_f
      t.string :last_name_m
      t.date :date_born
      t.text :domicilio
      t.string :clave_elector
      t.string :estado
      t.string :municipio
      t.string :seccion
      t.string :localidad
      t.timestamps
    end
  end
end
