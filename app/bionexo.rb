require 'thor'

class Bionexo < Thor

  desc 'new', 'creates a new quotation'
  def new
    Quotation.create
  end

  desc 'continue', 'continue quotation creation'
  def continue(quotation_id)
    puts Quotation.find quotation_id
  end

  desc 'list', 'lists quotations'
  def list
    unless Quotation.initialized.exists?
      puts 'No quotations found'
      return
    end

    quotations = Quotation.initialized
    quotations_count = quotations.size

    puts "Found #{quotations_count} #{pluralize(quotations_count, 'offer')}"
    puts quotations
  end

  private

  def pluralize(count, string)
    string.pluralize(count)
  end
end

