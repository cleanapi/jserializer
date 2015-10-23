factory(Employee) do
  blueprint :leader, name: 'Leader', last_name: 'Snow'
  blueprint :employee, name: 'Employee', leader: leader
  blueprint :employee2, name: 'Employee 2', leader: leader
end

factory(Task) do
  blueprint :task, title: 'do stuff', employee: leader
  blueprint :do_laundry, title: 'do laundry'
end

blueprint :employee_serializer_class do
  stub_const("EmployeeSerializer", Class.new(JSerializer::Serializer))
end

blueprint :task_serializer_class do
  stub_const("TaskSerializer", Class.new(JSerializer::Serializer))
end

depends_on(:employee_serializer_class, :leader).blueprint :leader_serializer do
  employee_serializer_class.new(leader)
end
