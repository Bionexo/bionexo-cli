require 'thor'

class Bionexo < Thor

  desc 'new', 'creates a new quotation'
  def new
    QuoteCreator.new.create_or_continue
  end

  desc 'continue', 'continue quotation creation'
  def continue(quotation_id)
    quotation = Quotation.find quotation_id
    QuoteCreator.new(quotation).create_or_continue
  end

  desc 'list', 'lists quotations'
  def list(status = :completed)
    quotations = Quotation.where(status: status)
    return puts 'No quotations found' if quotations.empty?

    puts "Found #{quotations.size} #{pluralize(quotations.size, 'offer')}"
    puts quotations
  end

  private

  def pluralize(count, string)
    string.pluralize(count)
  end
end

