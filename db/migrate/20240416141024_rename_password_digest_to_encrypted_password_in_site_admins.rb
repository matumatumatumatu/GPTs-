class RenamePasswordDigestToEncryptedPasswordInSiteAdmins < ActiveRecord::Migration[6.1]
  def change
    rename_column :site_admins, :password_digest, :encrypted_password
  end
end
