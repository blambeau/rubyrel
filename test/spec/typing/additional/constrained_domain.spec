require 'rubyrel'
describe ::Rubyrel::Typing::ConstrainedDomain do
  extend ::Rubyrel::Typing
  
  names = constrained(String){|s| /[a-z]+/ =~ s}
  positive_integers = constrained(Integer){|i| i>=0}

  it "should allow valid selection" do
    name = names["hello"]
    name.class.should == names
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
  
end