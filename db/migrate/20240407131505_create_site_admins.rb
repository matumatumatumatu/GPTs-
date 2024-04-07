class CreateSiteAdmins < ActiveRecord::Migration[6.1]
  def change
    create_table :site_admins do |t|
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
