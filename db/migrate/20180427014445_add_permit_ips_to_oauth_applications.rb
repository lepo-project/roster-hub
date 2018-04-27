class AddPermitIpsToOauthApplications < ActiveRecord::Migration[5.1]
  def change
    add_column :oauth_applications, :permit_ips, :string
  end
end
