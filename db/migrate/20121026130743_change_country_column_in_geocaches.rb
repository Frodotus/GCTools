class ChangeCountryColumnInGeocaches < ActiveRecord::Migration
  def up
    remove_column :geocaches, :country_id
    add_column    :geocaches, :country_id, :string
  end

  def down
    remove_column :geocaches, :country_id
    add_column    :geocaches, :country_id, :integer
  end
end
