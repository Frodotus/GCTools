class AddColumnsToGeocaches < ActiveRecord::Migration
  def change
    add_column :geocaches, :type_id,            :integer
    add_column :geocaches, :country_id,         :integer
    add_column :geocaches, :log_id,             :integer
    add_column :geocaches, :difficulty,         :decimal, :precision => 2, :scale => 1
    add_column :geocaches, :terrain,            :decimal, :precision => 2, :scale => 1
    add_column :geocaches, :ftf,                :boolean
    add_column :geocaches, :lon,                :decimal, :precision => 16, :scale => 13
    add_column :geocaches, :lat,                :decimal, :precision => 16, :scale => 13
    add_column :geocaches, :placed_by,          :string
    add_column :geocaches, :owner_id,           :integer
    add_column :geocaches, :container_type_id,  :integer
  end
end

  