require 'spec_helper'

describe JSerializer do
  describe ".for" do
    it "returns CollectionSerializer for an array" do
      serializer = JSerializer.for([], yes: true)
      expect(serializer).to be_a(JSerializer::CollectionSerializer)
      expect(serializer.collection).to eq([])
      expect(serializer.options).to eq(yes: true)
    end

    it "returns EmployeeSerializer for Employee" do
      build :employee_serializer_class, :leader
      serializer = JSerializer.for(leader, prefix: 'Mr.')
      expect(serializer).to be_a(EmployeeSerializer)
      expect(serializer.model).to eq(leader)
      expect(serializer.options).to eq(prefix: 'Mr.')
    end

    it "returns nil if serializer class can't be found" do
      serializer = JSerializer.for({}, prefix: 'Mr.')
      expect(serializer).to be_nil
    end
  end
end
