class Bionexo
  class << self
    include ClientInputOutput

    def new
      QuoteCreator.new.create_or_continue
    end

    def continue(quotation_id)
      quotation = Quotation.find quotation_id
      QuoteCreator.new(quotation).create_or_continue
    end

    def list(status = :completed)
      quotations = Quotation.where(status: status)
      return tell 'No quotations found' if quotations.empty?

      tell "Found #{quotations.size} #{'offer'.pluralize(quotations.size)}"
      tell quotations
    end
  end
end

