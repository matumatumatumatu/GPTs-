class AddMemberIdToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :member_id, :integer
    add_index :posts, :member_id
  end
end
