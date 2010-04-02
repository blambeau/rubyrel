require 'rubyrel'
describe ::Rubyrel::Typing::ConstrainedDomain do
  extend ::Rubyrel::Typing; include Rubyrel::Typing
  
  names = constrained(String){|s| /[a-z]+/ =~ s}
  positive_integers = constrained(Integer){|i| i>=0}

  it "should allow valid selection" do
    name = names["hello"]
    #name.class.should == names
    (String === name).should be_true
    (names === name).should be_true
    
    i = positive_integers[10]
    #i.class.should == positive_integers
    (positive_integers === i).should be_true
  end
  
  it "should raise a TypeError on invalid selections" do
    lambda { names["123"] }.should raise_error(::Rubyrel::TypeError)
    lambda { names[12] }.should raise_error(::Rubyrel::TypeError)
    lambda { positive_integers["12"] }.should raise_error(::Rubyrel::TypeError)
    lambda { positive_integers[-1] }.should raise_error(::Rubyrel::TypeError)
  end
  
  # it "should allow building tuple constrained domains" do
  #   people = tuple_domain(:name => String, :age => Integer)
  #   blambeau = people[:name => "blambeau", :age => 29]
  #   c_people = constrained(people){|t| t.age >= 1 and t.age <= 99}
  #   c_blambeau = c_people[:name => "blambeau", :age => 29]
  #   lambda { c_people[:name => "blambeau", :age => -1] }.should raise_error(::Rubyrel::TypeError)
  # end 
  
end