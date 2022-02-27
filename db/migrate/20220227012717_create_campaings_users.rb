class CreateCampaingsUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :campaings_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :campaign, null: false, foreign_key: true
      t.text :rol
      t.timestamps
    end
  end
end
