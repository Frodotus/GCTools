class CreateUserCacheAttributes < ActiveRecord::Migration
  def change
    create_table :user_cache_attributes do |t|
      t.integer :user_id
      t.string  :code
      t.integer :count
      t.timestamps
    end
  end
end
