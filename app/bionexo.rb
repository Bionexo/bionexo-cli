class Bionexo
  class << self
    def new
      QuoteCreator.new.create_or_continue
    end

    def continue(quotation_id)
      quotation = Quotation.find quotation_id
      QuoteCreator.new(quotation).create_or_continue
    end

    def list(status = :completed)
      quotations = Quotation.where(status: status)
      return puts 'No quotations found' if quotations.empty?

      puts "Found #{quotations.size} #{'offer'.pluralize(quotations.size)}"
      puts quotations
    end
  end
end

