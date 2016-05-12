# RenderHash

RenderHash is an alternative to .as_json in rails providing simple syntax to
generate nested hash from any ruby object.

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

* Include the module into a class

```ruby
class User
  include RenderHash
  attr_reader :name, :age
  def initialize(name, age)
    @name = name
    @age = age
  end
end
user = User.new("bob", 20)
user.render(:name) #=> {name: "bob", age: 20}
```

* Use the module directly
```ruby
class User
  attr_reader :name, :age
  def initialize(name, age)
    @name = name
    @age = age
  end
end
user = User.new("bob", 20)
RenderHash.render(user, :name, :age) #=> {name: "bob", age: 20}
```

## Syntax

Classes used in the examples
```ruby
  class User
    include RenderHash
    attr_reader :name, :age, :jobs
    def initialize(name, age = nil, jobs = [])
      @name = name
      @age  = age
      @jobs = jobs
    end
  end
  class Job
    attr_reader :title
    def initialize(title)
      @title = title
    end
  end
```

Render the method
```ruby
user = User.new("bob")
user.render(:name) #=> {name: "bob"}
```

Render the method with the custom name
```ruby
user = User.new("bob")
user.render({username: :name}) #=> {username: "bob"}
```

Render the custom value
```ruby
user = User.new("bob")
user.render({hobby: "fishing"}) #=> {hobby: "fishing"}
```

Render the custom function
```ruby
user = User.new("bob", 20)
name_with_age = ->(user){"#{user.name}(#{user.age})"}
user.render({name_with_age: name_with_age}) #=> {name_with_age: "bob(20)"}
```

Render nested methods
```ruby
user = User.new("bob")
user.render([:name, :upcase]) #=> {name: {upcase: "BOB"}}
```

Render the method from the array
```ruby
jobs = [Job.new(title: "doctor"), Job.new(title: "driver")]
user = User.new("bob", 20, jobs)
user.render([jobs: [:title]]) #=> {jobs: [{title: "doctor"}, {title: "driver"}]}
```

You can merge multiple hashes
```ruby
user = User.new("bob")
user.render({username: :name}, {hobby: "fishing"}) ==
user.render({username: :name, hobby: "fishing"})
```

Render from arrays using the module
```ruby
users = [User.new("bob"), User.new("tom")]
RenderHash.render(users, :name) #=> [{name: "bob"}, {name: "tom"}]
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/render_hash/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
