class JSerializer::CollectionSerializer < JSerializer::Base
  def collection
    @object
  end

  def serialize
    @object.each { |child| @json.push child_json(child) }
  end

  def as_json
    @json = []
    serialize
    @json
  end
end
