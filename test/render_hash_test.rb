$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'minitest/autorun'
require 'render_hash'

describe RenderHash do

  class User
    include RenderHash
    attr_reader :name, :age, :jobs
    def initialize(name, age, jobs)
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

  let(:bob) {User.new('bob', 20, [Job.new('doctor'), Job.new('driver')])}

  it "add render method on include" do
    assert_equal({}, bob.render)
  end

  it "render method name and return value" do
    assert_equal({name: 'bob', age: 20}, bob.render(:name, :age))
  end

  it "raise if method is not found" do
    assert_raises(NoMethodError) {bob.render(:method_not_exist)}
  end

  it "rename method" do
    assert_equal({username: 'bob'}, bob.render({username: :name}))
  end

  it "render custom string" do
    assert_equal({name: 'tom'}, bob.render({name: 'tom'}))
  end

  it "render custom object" do
    hobby = 'fishing'
    assert_equal({hobby: 'fishing'}, bob.render({hobby: hobby}))
  end

  it "render custom with object" do
    assert_equal(
      {name_with_age: 'bob(20)'},
      bob.render({name_with_age: ->(user){"#{user.name}(#{user.age})"}})
    )
  end

  it "hash can be ..." do
    assert_equal({username: 'bob', hobby: 'fishing'}, bob.render({username: :name, hobby: "fishing"}))
  end

  it "render method in array" do
    assert_equal(
      {jobs: [{title: 'doctor'}, {title: 'driver'}]},
      bob.render([:jobs, [:title]])
    )
  end

  it "render method of method" do
    assert_equal({:age=>20, :name=>{:upcase=>"BOB"}},
                 bob.render(:age, [:name, :upcase]))
  end

  it "render from self" do
    assert_equal({name: 'bob'}, RenderHash.render(bob, :name))
  end

  it "render with array" do
    assert_equal([{name: 'bob'}], RenderHash.render([bob], :name))
  end

end
