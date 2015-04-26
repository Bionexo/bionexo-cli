class AddingTypeToQuotation < ActiveRecord::Migration
  def change
    add_column :quotations, :type, :string, default: :standard
  end
end
