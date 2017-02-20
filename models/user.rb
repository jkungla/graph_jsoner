class User < ActiveRecord::Base
  has_many :claims, dependent: :destroy, foreign_key: "tegeleja_id"

  def laekumiste_summa
    sum = 0
    claims.each do |claim|
      claim.payments.each do |pay|
        sum = sum + pay.summa
      end
    end
    sum
  end
end