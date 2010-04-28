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
  
  it "should return inserted tuples on insert" do
    db = defaults_sqlite_db
    db.base.examples = []
    inserted = (db.base.examples << {})
    (Hash === inserted).should be_true
    inserted[:autonum].should == 1

    db.base.examples.restrict(:autonum => 1).update(:explicit => 10)
    tuple = db.base.examples.restrict(:autonum => 1).tuple_extract
    tuple.explicit.should == 10
  end
  
  it "should support relative autonumbers" do
    db = defaults_sqlite_db
    db.base.examples = []
    (db.base.examples << {:explicit => 1})[:relative].should == 1
    (db.base.examples << {:explicit => 1})[:relative].should == 2
    (db.base.examples << {:explicit => 1})[:relative].should == 3
    (db.base.examples << {:explicit => 2})[:relative].should == 1
    (db.base.examples << {:explicit => 2})[:relative].should == 2
  end
  
end
