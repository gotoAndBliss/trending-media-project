class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username,                   :null => false
      t.string :email,                      :null => false
      t.string :crypted_password,           :null => false
      t.string :password_salt,              :null => false
      t.string :persistence_token,          :null => false
      t.string :single_access_token,        :null => false
      t.string :perishable_token,           :null => false
      
      t.integer :login_count,               :null => false, :default => 0
      t.integer :failed_login_count,        :null => false, :default => 0
      t.datetime :last_login_at

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
