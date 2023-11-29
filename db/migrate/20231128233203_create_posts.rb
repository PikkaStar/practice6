class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title,null: false
      t.string :body,null: false
      t.integer :customer_id

      t.timestamps
    end
  end
end
