class AddFkeyInVoter < ActiveRecord::Migration[6.1]
  def change
    add_reference :voters, :user, null: false, foreign_key: true, index:true
    add_reference :voters, :campaign, null: false, foreign_key: true, index:true
  end
end
