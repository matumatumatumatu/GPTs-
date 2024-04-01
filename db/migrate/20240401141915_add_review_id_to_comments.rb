class AddReviewIdToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :review_id, :integer
    add_index :comments, :review_id
  end
end
