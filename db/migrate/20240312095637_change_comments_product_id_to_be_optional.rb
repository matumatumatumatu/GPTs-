class ChangeCommentsProductIdToBeOptional < ActiveRecord::Migration[6.1]
  def change
    change_column_null :comments, :product_id, true
  end
end
