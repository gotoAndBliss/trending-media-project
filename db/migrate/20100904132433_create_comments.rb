class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text      :text
      t.integer   :commentable_id
      t.string    :commentable_type
      t.string    :post_parent_id

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
