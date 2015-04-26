class Quotation < ActiveRecord::Base
  has_one :product, autosave: true

  QUOTATION_TYPES = %w(emergencial standard private)

  scope :completed, -> { where(status: :completed) }

  delegate :name, :name=, :quantity, :quantity=, to: :product, prefix: true

  validates :title, :address, :email, :phone_number, presence: true
  validates :quotation_type, inclusion: { in: QUOTATION_TYPES, message: "Enter any of the next: #{QUOTATION_TYPES}" }

  before_save :initialize_product

  def complete!
    update!(status: :completed)
  end

  def edit!
    update_attribute(:status, :editing)
  end

  def invalid?(attribute)
    !valid? && ( errors[attribute].present? || invalid_product?(attribute) )
  end

  def attribute_error(attribute)
    if attribute =~ /\Aproduct_/
      product_attribute_error(attribute)
    else
      errors.messages[attribute.to_sym]
    end.first
  end

  def to_s
    "#{id}: #{title}"
  end

  private

  def invalid_product?(attribute)
    product.invalid?(product_attribute(attribute))
  end

  def product_attribute_error(attribute)
    product.attribute_error(product_attribute(attribute))
  end

  def initialize_product
    self.update_attribute(:product,  Product.new) unless product
  end

  def product_attribute(attr)
    attr.gsub('product_', '')
  end
end
