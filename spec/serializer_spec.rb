require 'spec_helper'

describe JSerializer::Serializer do
  build :leader_serializer

  it "serializes attributes of object" do
    EmployeeSerializer.class_eval do
      def serialize(**_)
        attributes :name
      end
    end

    expect(json_of(leader_serializer)).to eq(name: 'Leader')
  end

  it "allows custom attributes" do
    EmployeeSerializer.class_eval do
      def serialize(**_)
        attributes name: "Mr. #{model.name}"
      end
    end

    expect(json_of(leader_serializer)).to eq(name: 'Mr. Leader')
  end

  it "allows embeds many association" do
    EmployeeSerializer.class_eval do
      def serialize(**_)
        attributes :name
        embeds_many :employees
      end
    end

    build :employee
    expect(json_of(leader_serializer)).to eq(name: 'Leader', employees: [{name: 'Employee', employees: []}])
  end

  it "allows renaming embeds many association" do
    EmployeeSerializer.class_eval do
      def serialize(**_)
        attributes :name
        embeds_many :workforce, model.employees
      end
    end

    build :employee
    expect(json_of(leader_serializer)).to eq(name: 'Leader', workforce: [{name: 'Employee', workforce: []}])
  end

  it "allows embeds one association" do
    build :task_serializer_class
    EmployeeSerializer.class_eval do
      def serialize(**_)
        embeds_one :task
      end
    end
    TaskSerializer.class_eval do
      def serialize(**_)
        attributes :title
      end
    end

    build :task
    expect(json_of(leader_serializer)).to eq(task: {title: 'do stuff'})
  end

  it "allows renaming embeds one association" do
    build :task_serializer_class
    EmployeeSerializer.class_eval do
      def serialize(**_)
        embeds_one :job, model.task
      end
    end
    TaskSerializer.class_eval do
      def serialize(**_)
        attributes :title
      end
    end

    build :task
    expect(json_of(leader_serializer)).to eq(job: {title: 'do stuff'})
  end

  it "returns null if embeds one associated object is nil" do
    build :task_serializer_class
    EmployeeSerializer.class_eval do
      def serialize(**_)
        embeds_one :task
      end
    end

    expect(json_of(leader_serializer)).to eq(task: nil)
  end

  context "options" do
    it "allows accessing options" do
      EmployeeSerializer.class_eval do
        def serialize
          attributes **@options
        end
      end

      leader_serializer = EmployeeSerializer.new(leader, hello: 'world')
      expect(json_of(leader_serializer)).to eq(hello: 'world')
    end

    it "passes options to embedded associations" do
      EmployeeSerializer.class_eval do
        def serialize
          attributes :name => "#{@options[:prefix]} #{model.name}"
          embeds_many :employees
        end
      end

      build :employee
      leader_serializer = EmployeeSerializer.new(leader, prefix: 'Mr.')
      expect(json_of(leader_serializer)).to eq(name: 'Mr. Leader', employees: [{name: 'Mr. Employee', employees: []}])
    end
  end

  describe ".camelized_attributes" do
    it "converts object's attributes to camel case" do
      EmployeeSerializer.class_eval do
        def serialize
          camelized_attributes :last_name
        end
      end
      expect(json_of(leader_serializer)).to eq(lastName: 'Snow')
    end

    it "won't convert custom attributes" do
      EmployeeSerializer.class_eval do
        def serialize(**_)
          camelized_attributes last_name: "Mr. Snow"
        end
      end

      expect(json_of(leader_serializer)).to eq(last_name: 'Mr. Snow')
    end
  end
end
