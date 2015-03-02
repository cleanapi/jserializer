class JSerializer::Base
  attr_reader :object, :options

  def initialize(object, **options)
    @object = object
    @options = options
  end

  def controller
    @options[:controller]
  end

  def to_json(**options)
    Oj.dump(as_json, **options.merge(mode: :compat))
  end

  private

  def child_json(child)
    JSerializer.for(child, **@options).as_json if child
  end
end
