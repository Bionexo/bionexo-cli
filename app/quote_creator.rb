class QuoteCreator
  include ClientInputOutput

  EDITABLE_ATTRS = %w(title address email phone_number product_name product_quantity quotation_type)

  def initialize(quotation = Quotation.new)
    check_and_save(quotation)
    @quotation = quotation
  end

  def create_or_continue
    @quotation.edit!

    editable_attributes.each { |attribute| update(attribute) }
    @quotation.complete!

    tell "Great job! Listing #{@quotation.id} is complete!"
  end

  private

  def check_and_save(quotation)
    if quotation.new_record?
      quotation.save(validate: false)
      tell  "Starting with new quotation #{quotation.id}"
    else
      tell "Continuing with #{quotation.id}"
    end
  end

  def editable_attributes
    EDITABLE_ATTRS.reject do |attr|
      @quotation.send(attr).present?
    end
  end

  def update(attribute)
    ask "#{attribute.humanize}: " do
      @quotation.update_attribute(attribute, user_input)
    end

    raise if @quotation.invalid?(attribute)
  rescue
    @quotation.update_attribute(attribute, nil)
    exit_application(@quotation.attribute_error(attribute))
  end
end
