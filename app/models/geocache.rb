class Geocache < ActiveRecord::Base
  attr_accessible :code, :name, :type_id, :country_id, :log_id, :difficulty, :terrain, :ftf, :lon, :lat, :placed_by, :owner_id, :container_type_id
end
