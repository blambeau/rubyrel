require 'rubyrel'
describe Rubyrel::Typing::Attribute do 
  
  def attribute(name, domain, options = {})
    Rubyrel::Typing::Attribute.new(name, domain, options)
  end
  
  it "should support ==" do
    (attribute(:name, String) == attribute(:name, String)).should be_true
    (attribute(:name, String) == attribute(:name, Integer)).should be_false
    (attribute(:age, Integer) == attribute(:name, Integer)).should be_false
  end
  
  it "should support consistent hash code" do
    attribute(:name, String).hash.should == attribute(:name, String).hash
    attribute(:age, Integer).hash.should == attribute(:age, Integer).hash
  end
  
end