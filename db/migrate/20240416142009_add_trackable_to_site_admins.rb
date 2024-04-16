class AddTrackableToSiteAdmins < ActiveRecord::Migration[6.1]
  def change
    add_column :site_admins, :current_sign_in_at, :datetime
    add_column :site_admins, :last_sign_in_at, :datetime
    add_column :site_admins, :current_sign_in_ip, :string
    add_column :site_admins, :last_sign_in_ip, :string
  end
end
