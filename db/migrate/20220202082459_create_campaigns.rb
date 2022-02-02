class CreateCampaigns < ActiveRecord::Migration[6.1]
  def change
    create_table :campaigns do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.date :start_date
      t.date :end_date
      
      t.timestamps
    end
  end
end
