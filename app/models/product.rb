class Product < ActiveRecord::Base
  belongs_to :quotation

  validates_numericality_of :quantity, message: 'must be a number'
  validates :name, presence: true

  def invalid?(attribute)
    !valid? && attribute_error(attribute).present?
  end

  def attribute_error(attribute)
    errors.messages[attribute.to_sym]
  end
end
