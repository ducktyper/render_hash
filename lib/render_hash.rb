require 'render_hash/version'

module RenderHash

  # Usage
  # User.include RenderHash
  # user.render(
  #   :name, :age,
  #   {username: :name, hobby: "fishing"},
  #   [:name, :upcase],
  #   {name_with_age: -> (user) {"#{user.name}(#{user.age})"}},
  #   [jobs:          [:title]]
  # )
  # => {
  #   name:          "bob",
  #   age:           20,
  #   username:      "bob",
  #   hobby:         "finishig",
  #   name:          {upcase: "BOB"},
  #   name_with_age: "bob(20)",
  #   jobs:          [{title: "doctor"}]
  # }
  def render(*args)
    RenderHash.render(self, *args)
  end

  # Usage
  # RenderHash.render(user, :name, :age)
  def self.render(obj, *args)
    return obj.map {|x| render(x, *args)} if obj.is_a? Array

    args.inject({}) do |result, task|
      result.merge(
        case task
        when Symbol
          {task => obj.send(task)}
        when Hash
          task.inject({}) do |h, (k, v)|
            h.merge(k =>
              case v
              when Symbol then obj.send(v)
              when Proc   then v.call(obj)
              else             v
              end
            )
          end
        when Array
          val = obj.send(task[0])
          if val.respond_to? :map
            {task[0] => val.map {|x| render(x, *task[1])}}
          else
            {task[0] => render(val, *task[1])}
          end
        end
      )
    end
  end
end
