class AddLastCheckedMailToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :last_checked_mail, :datetime
  end

  def self.down
    remove_column :users, :last_checked_mail
  end
end
