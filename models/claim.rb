class Claim < ActiveRecord::Base
  has_one :user
  has_many :payments, dependent: :destroy, foreign_key: "noue_id"
end