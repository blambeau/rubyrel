require 'rubyrel'
describe ::Rubyrel::Typing::TupleGenerator do
  extend ::Rubyrel::Typing; include ::Rubyrel::Typing
  
  People = tuple_type(:name => String, :age => Integer)
  Hobby = tuple_type(:kind => String)
  
  it "should support type generation" do
    (Class === People).should be_true
    People.heading.should == heading(:name => String, :age => Integer)
    tuple = People[:name => "blambeau", :age => 29]
    (tuple.is_a? People).should be_true
  end
  
  it "should provide tuple value with correct type" do
    people = People[:name => "blambeau", :age => 12]
    people.class.should == People
    people.class.heading.should == heading(:name => String, :age => Integer)
  end
  
  it "should provide tuple value with correct value" do
    people = People[:name => "blambeau", :age => 12]
    people.name.should == "blambeau"
    people.age.should == 12
    
    hobby = Hobby[:kind => "computers"]
    hobby.kind.should == "computers"
    hobby.respond_to?(:name).should be_false
  end
  
  it "should detect invalid values" do
    lambda { People[:name => "blambeau"] }.should raise_error(Rubyrel::TypeError) 
    lambda { People[:name => "blambeau", :age => "12"] }.should raise_error(Rubyrel::TypeError) 
    lambda { People[:name => :blambeau, :age => 12] }.should raise_error(Rubyrel::TypeError) 
  end
  
end