class User < ActiveRecord::Base
  has_many :bikes, foreign_key: 'owner_id'
end