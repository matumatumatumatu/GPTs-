class AddSignInCountToSiteAdmins < ActiveRecord::Migration[6.1]
  def change
    add_column :site_admins, :sign_in_count, :integer
  end
end
