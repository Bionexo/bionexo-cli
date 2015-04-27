class RenamingTypeToQuotationType < ActiveRecord::Migration
  def change
    rename_column :quotations, :type, :quotation_type
  end
end
