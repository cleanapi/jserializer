require 'spec_helper'

describe JSerializer::CollectionSerializer do
  build :leader, :employee, :employee_serializer_class

  it "serializes an array" do
    EmployeeSerializer.class_eval do
      def serialize
        attributes :name
      end
    end

    serializer = described_class.new([leader, employee])
    expect(json_of(serializer)).to eq([{name: 'Leader'}, {name: 'Employee'}])
  end

  it "passes options to child serializers" do
    EmployeeSerializer.class_eval do
      def serialize
        attributes :name => "#{@options[:prefix]} #{model.name}"
      end
    end

    serializer = described_class.new([leader, employee], prefix: "Mr.")
    expect(json_of(serializer)).to eq([{name: 'Mr. Leader'}, {name: 'Mr. Employee'}])
  end
end
