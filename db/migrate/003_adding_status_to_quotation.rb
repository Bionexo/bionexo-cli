class AddingStatusToQuotation < ActiveRecord::Migration
  def change
    add_column :quotations, :status, :string, default: :initialized
  end
end
