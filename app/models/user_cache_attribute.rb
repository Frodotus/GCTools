class UserCacheAttribute < ActiveRecord::Base
  attr_accessible :code, :user_id
end
