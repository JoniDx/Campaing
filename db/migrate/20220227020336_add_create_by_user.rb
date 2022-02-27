class AddCreateByUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :create_by, :string
  end
end
