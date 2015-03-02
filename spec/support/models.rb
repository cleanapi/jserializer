class Employee < ActiveRecord::Base
  belongs_to :leader, class_name: 'Employee'
  has_many :employees, foreign_key: 'leader_id'
  has_one :task

  validates :name, presence: true
end

class Task < ActiveRecord::Base
  belongs_to :employee
end
