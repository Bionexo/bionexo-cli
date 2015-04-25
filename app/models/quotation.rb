class Quotation < ActiveRecord::Base
  has_one :product

  scope :completed, -> { where(status: :completed) }

end
