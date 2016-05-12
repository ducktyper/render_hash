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

  it "should add render method on include" do
    assert_equal({}, bob.render)
  end

  it "should render the method" do
    assert_equal({name: 'bob', age: 20}, bob.render(:name, :age))
  end

  it "should raise if the method not found" do
    assert_raises(NoMethodError) {bob.render(:method_not_exist)}
  end

  it "should render the method with the custom name" do
    assert_equal({username: 'bob'}, bob.render({username: :name}))
  end

  it "should render the custom value" do
    assert_equal({name: 'tom'}, bob.render({name: 'tom'}))
  end

  it "should render the custom function" do
    assert_equal(
      {name_with_age: 'bob(20)'},
      bob.render({name_with_age: ->(user){"#{user.name}(#{user.age})"}})
    )
  end

  it "should render nested methods" do
    assert_equal({:age=>20, :name=>{:upcase=>"BOB"}},
                 bob.render(:age, [:name, :upcase]))
  end


  it "should be able to merge multiple hashes" do
    assert_equal({username: 'bob', hobby: 'fishing'}, bob.render({username: :name, hobby: "fishing"}))
    assert_equal(bob.render({username: :name}, {hobby: "fishing"}),
                 bob.render({username: :name, hobby: "fishing"}))
  end

  it "should render methods from the array" do
    assert_equal(
      {jobs: [{title: 'doctor'}, {title: 'driver'}]},
      bob.render([:jobs, [:title]])
    )
  end

  it "should render directly from the module" do
    assert_equal({name: 'bob'}, RenderHash.render(bob, :name))
  end

  it "should render from arrays using the module" do
    assert_equal([{name: 'bob'}], RenderHash.render([bob], :name))
  end

end
