class AddUserToBulletin < ActiveRecord::Migration[6.1]
  def change
    add_reference :bulletins, :user, null: false, foreign_key: true, unique: true
  end
end
