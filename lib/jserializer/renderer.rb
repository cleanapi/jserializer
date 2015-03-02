module JSerializer::Renderer
  def _render_option_json(resource, options)
    serializer = JSerializer.for(resource, **options.merge(controller: self))

    if serializer
      super(serializer, options)
    else
      super
    end
  end
end
