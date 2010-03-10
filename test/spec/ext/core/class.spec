require 'rubyrel'
describe "Class rubyrel extensions" do
  
  @now = Time.now
  @arr = [12, 13]
  
  def physical_encode(clazz, value)
    clazz.__rubyrel_to_physical_value(value)
  end
  
  def physical_decode(clazz, value)
    clazz.__rubyrel_from_physical_value(value)
  end
  
  def encode_decode(clazz, value)
    encoded = physical_encode(clazz, value)
    decoded = physical_decode(clazz, encoded)
    decoded
  end
  
  it "should support encoding to physical values on already mapped domains" do
    physical_encode(Integer, 12).should == 12
    physical_encode(Symbol, :method_name).should == "method_name"
    physical_encode(String, "hello").should == "hello"
    physical_encode(Boolean, true).should == true
    physical_encode(Boolean, false).should == false
    physical_encode(Time, @now).should == @now
    physical_encode(Array, @arr).should_not be_nil
  end

  it "should support decoding from physical values" do
    encode_decode(Integer, 12).should == 12
    encode_decode(String, "hello").should == "hello"
    encode_decode(Symbol, :method_name).should == :method_name
    encode_decode(Boolean, true).should == true
    encode_decode(Boolean, false).should == false
    encode_decode(Time, @now).should == @now
    encode_decode(Array, @arr).should == @arr
  end
  
end