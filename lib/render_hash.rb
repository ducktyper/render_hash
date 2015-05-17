VERSION = "0.0.1"

module RenderHash

  # Usage
  # User.include RenderHash
  # user.render(
  #   :name,
  #   {username:      :name},
  #   {hobby:         "fishing"},
  #   {name_with_age: ->(user){"#{user.name}(#{user.age})"}},
  #   [jobs:          [:title]]
  # )
  # => {
  #   name:          "bob",
  #   username:      "bob",
  #   hobby:         "finishig",
  #   name_with_age: "bob(20)",
  #   jobs:          [{title: "doctor"}]
  # }
  def render(*args)
    RenderHash.render(self, *args)
  end

  # Usage
  # RenderHash.render(user, :name, :age)
  def self.render(obj, *args)
    args.inject({}) do |h, v|
      case v
      when Symbol
        h.merge(v => obj.send(v))
      when Hash
        if v.first.last.is_a? Symbol
          h.merge(v.first.first => obj.send(v.first.last))
        elsif v.first.last.is_a? Proc
          h.merge(v.first.first => v.first.last.call(obj))
        else
          h.merge(v.first.first => v.first.last)
        end
      when Array
        h.merge(v[0] => obj.send(v[0]).map {|x| render(x, *v[1])})
      end
    end
  end
end
