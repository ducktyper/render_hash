# RenderHash

RenderHash is an alternative to .as_json in rails providing simple syntax to
generate nested hash from any ruby object

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'render_hash'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install render_hash

## Usage
RenderHash module can be included to a class

    user.render(:name, :age) #=> {name: "bob", age: 20}

or render directly

    RenderHash.render(user, :name, :age) #=> {name: "bob", age: 20}

## Syntax

render from methods

    user.render(:name, :age) #=> {name: "bob", age: 20}

render from methods with a custom key

    user.render({username: :name}, :age) #=> {username: "bob", age: 20}

render a custom key and value

    user.render({hobby: "fishing"}) #=> {hobby: "fishing"}

hash expressions can be grouped together

    user.render({username: :name}, {hobby: "fishing"}) ==
    user.render({username: :name, hobby: "fishing"})

render a custom key and value with lambda

    name_with_age = ->(user){"#{user.name}(#{user.age})"}
    user.render({name_with_age: name_with_age}) #=> {name_with_age: "bob(20)"}

render nested hash from a method returns an array

    user.render([jobs: [:title]])
    #=> {jobs: [{title: "doctor"}, {title: "driver"}]}

render with an array

    RenderHash.render([user1, user2], :name) #=> [{name: "bob"}, {name: "tom"}]

## Contributing

1. Fork it ( https://github.com/[my-github-username]/render_hash/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
