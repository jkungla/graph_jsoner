class Payment < ActiveRecord::Base
  has_one :claim
end