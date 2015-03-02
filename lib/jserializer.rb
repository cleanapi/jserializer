require 'oj'
require 'active_record'
require "jserializer/version"

module JSerializer
  autoload :Base, 'jserializer/base'
  autoload :Serializer, 'jserializer/serializer'
  autoload :CollectionSerializer, 'jserializer/collection_serializer'
  autoload :Renderer, 'jserializer/renderer'

  def self.for(resource, **options)
    if resource.respond_to?(:to_ary)
      JSerializer::CollectionSerializer.new(resource, **options)
    else
      serializer_class = "#{resource.class.name}Serializer".safe_constantize
      serializer_class.new(resource, **options) if serializer_class
    end
  end
end

ActiveSupport.on_load(:after_initialize) do
  ActionController::Base.send(:include, ::JSerializer::Renderer)
end
