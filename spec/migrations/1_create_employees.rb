class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.belongs_to :leader
      t.integer :monthly_pay
      t.timestamps
    end
  end
end
