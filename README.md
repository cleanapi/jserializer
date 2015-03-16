# JSerializer

Fast and flexible JSON serializer.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jserializer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jserializer

## Usage

```ruby
class ItemSerializer < JSerializer::Serializer
  def serialize
    attributes :name, :price
    attributes type: model.class.name.underscore
  end
end

render json: Item.find(params[:id]) # => '{"name":"my item","price":55",type:"item"}'
respond_with Item.find(params[:id]) # Or use with Rails responders
```

Each serializer has to implement `#serialize` method which gets called when model needs to be serialized. You can use
`#attributes` method to help you construct your json.

## Associations

JSerializer provides 2 types of associations: embeds_one and embeds_many:

```ruby
class ItemSerializer < JSerializer::Serializer
  def serialize
    embeds_one :shop
    embeds_many :descriptions
    embeds_many :line_items, model.line_items.where(user_id: controller.current_user)
  end
end
```

Note #1: you can access controller in your serializers using `controller` method.
Note #2: in third example we pass a custom collection to only serialize line_items of current user.

## Options

You can pass options to serializer if needed:

```ruby
class PersonSerializer < JSerializer::Serializer
  def serialize
    attributes name: "#{@options[:person_prefix]} #{model.name}"
  end
end

respond_with @person, person_prefix: "Mr." # => '{"name":"Mr. John"}'
```

Note that options are passed to embedded serializers too. This can be a great tool to customize how your embedded
serializers output JSON, however it also means that you need to make sure that you name your options in a unique way:
`:person_prefix` is a good name while `:prefix` is not because it's too general.
