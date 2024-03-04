class AddProductIdToPosts < ActiveRecord::Migration[6.1]
  def change
    add_reference :posts, :product, null: false, foreign_key: true
  end
end
