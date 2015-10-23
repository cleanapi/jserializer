class AddLastNameToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :last_name, :string
  end
end
