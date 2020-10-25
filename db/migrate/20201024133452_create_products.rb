class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.float :price
      t.string :status

      t.timestamps
    end
  end
end
