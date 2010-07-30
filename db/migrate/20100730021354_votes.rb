class Votes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.integer :user_id
      t.integer :votable_id
      t.string :votable_type
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :value,       :default => 0
    end
  end

  def self.down
    drop_table :votes
  end
end
