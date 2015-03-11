module JSerializer::Renderer
  class_eval <<-RUBY
    def #{ActionController::Renderers._render_with_renderer_method_name(:json)}(resource, options)
      serializer = JSerializer.for(resource, **options.merge(controller: self))

      if serializer
        super(serializer, options)
      else
        super
      end
    end
  RUBY
end
