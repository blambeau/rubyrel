require 'rubyrel'
describe ::Rubyrel::Typing do
  
  it "should have the builtin types acting correctly" do
    (::Rubyrel::Typing::Domain === String).should be_true
    String.respond_to?(:__rubyrel_belongs?).should be_true
  end
  
  it "should support creating subdomains" do
    Names = ::Rubyrel::Typing::constrained(String){|s| /[a-z]+/ =~ s}
    Names.__rubyrel_belongs?("hello").should be_true
    Names.__rubyrel_belongs?("123").should be_false
    (Names === "hello").should be_true
    (Names === "123").should be_false
  end
  
end