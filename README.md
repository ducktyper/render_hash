# RenderHash

render_hash is an alternative to .as_json in rails providing simple syntax to
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

render method

    user.render(:name, :age) #=> {name: "bob", age: 20}

render method with custom key

    user.render({username: :name}, :age) #=> {username: "bob", age: 20}

render custom key and value

    user.render({hobby: "fishing"}) #=> {hobby: "fishing"}

hash expressions can be grouped together
    user.render({username: :name}, {hobby: "fishing"}) ==
    user.render({username: :name, hobby: "fishing"})

render custom key and value with lambda

    user.render({name_with_age: ->(user){"#{user.name}(#{user.age})"}})
    #=> {name_with_age: "bob(20)"}

render nested hash through array

    user.render([jobs: [:title]]) #=> {jobs: [{title: "doctor"}]}

## Contributing

1. Fork it ( https://github.com/[my-github-username]/render_hash/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
