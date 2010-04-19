require 'rubyrel'
describe ::Rubyrel::Defaults do
  include ::Rubyrel::Fixtures
  
  it "should correctly generate default values" do
    db = defaults_sqlite_db
    
    10.times { db.base.examples << {} }
    tuples = db.base.examples.collect{|t| t.to_h}
    tuples.sort!{|h1,h2| h1[:autonum] <=> h2[:autonum]}
    tuples.each_with_index do |tuple,i|
      tuple[:explicit].should == 0
      tuple[:autonum].should == i+1
      tuple[:timenow].should_not be_nil
    end
  end
  
end
