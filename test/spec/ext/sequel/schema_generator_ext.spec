require 'rubyrel'
describe ::Sequel::Schema::Generator do
  
  it "should respond to a rubyrel_add_constraint method" do
    ::Sequel::Schema::Generator.new(nil).respond_to?(:rubyrel_add_constraint).should == true
  end
  
end