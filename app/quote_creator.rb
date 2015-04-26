class QuoteCreator

  EDITABLE_ATTRS = %w(title address email phone_number product_name product_quantity quotation_type)

  def initialize(quotation = Quotation.new)
    if quotation.new_record?
      quotation.save(validate: false)
      puts "Starting with new quotation #{quotation.id}"
    else
      puts "Continuing with #{quotation.id}"
    end
    @quotation = quotation
  end

  def create_or_continue
    @quotation.edit!

    editable_attributes.each { |attribute| update(attribute) }
    @quotation.complete!

    puts "Great job! Listing #{@quotation.id} is complete!"
  end

  private

  def editable_attributes
    EDITABLE_ATTRS.reject do |attr|
      @quotation.send(attr).present?
    end
  end

  def update(attribute)
    print "#{attribute.humanize}: "
    #@quotation.update_attribute(attribute, user_input)
    @quotation.update_attribute(attribute, user_input)

    raise if @quotation.invalid?(attribute)
  rescue
    @quotation.update_attribute(attribute, nil)
    puts "Error: #{@quotation.attribute_error(attribute)}"
    user_input and abort
  end

  def user_input
    $stdin.gets.chomp
  end
end
