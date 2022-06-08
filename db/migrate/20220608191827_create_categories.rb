class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    # validate uniqueness scope, ensures that category name is unique within the scope of user_id
    add_index :categories, %i[name user_id], unique: true
  end
end
