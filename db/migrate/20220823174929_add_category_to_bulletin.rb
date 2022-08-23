class AddCategoryToBulletin < ActiveRecord::Migration[6.1]
  def change
    add_reference :bulletins, :category, null: false, foreign_key: true, index: true
  end
end
