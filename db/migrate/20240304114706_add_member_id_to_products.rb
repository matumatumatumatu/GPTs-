class AddMemberIdToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :member_id, :integer
  end
end
