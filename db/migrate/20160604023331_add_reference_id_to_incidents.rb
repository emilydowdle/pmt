class AddReferenceIdToIncidents < ActiveRecord::Migration
  def change
    add_column :incidents, :reference_id, :string, :index => true, :null => false
  end
end
