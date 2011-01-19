class CreateLastLogins < ActiveRecord::Migration
  def self.up
    create_table :last_logins do |t|
      t.integer :category_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :last_logins
  end
end
