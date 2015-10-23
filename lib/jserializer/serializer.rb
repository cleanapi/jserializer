class JSerializer::Serializer < JSerializer::Base
  def model
    @object
  end

  def attributes(*names, **attrs)
    names.each { |name| @json[name] = @object.send(name) }
    @json.merge!(attrs)
  end

  def camelized_attributes(*names, **attrs)
    names.each { |name| @json[name.to_s.camelize(:lower)] = @object.send(name) }
    @json.merge!(attrs)
  end

  def embeds_many(*args)
    assign_association(*args) do |associated|
      JSerializer::CollectionSerializer.new(associated, **@options).as_json
    end
  end

  def embeds_one(*args)
    assign_association(*args) do |associated|
      child_json(associated)
    end
  end

  def serialize
  end

  def as_json
    @json = {}
    serialize
    @json
  end

  private

  def assign_association(name, associated = nil)
    @json[name] = yield(associated || @object.send(name))
  end
end
