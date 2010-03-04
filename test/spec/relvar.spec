require 'rubyrel'
describe ::Rubyrel::Relvar do
  include ::Rubyrel::Fixtures
  
  before(:each) do
    @db = suppliers_and_parts_sqlite_db
    @suppliers = @db.base.suppliers
    @db.base.suppliers = [
      {:snumber => 1, :sname => "Jones"},
      {:snumber => 2, :sname => "Smith"}
    ]
  end
  
  it "correctly implements empty!" do
    @suppliers.empty!
    @suppliers.should == []
  end
  
  it "correctly implements contains?" do
    @suppliers.contains?(:snumber => 1).should be_false
    @suppliers.contains?(:sname => "Jones").should be_false
    @suppliers.contains?(:snumber => 2, :sname => "Jones").should be_false
    @suppliers.contains?(:snumber => 1, :sname => "Jones", :scity => "London").should be_false
    @suppliers.contains?(:snumber => 1, :sname => "Jones").should be_true
  end
  
  it "correctly implements == " do
    @suppliers.should == [
      {:snumber => 1, :sname => "Jones"},
      {:snumber => 2, :sname => "Smith"}
    ]
    @suppliers.should_not == [
      {:snumber => 1, :sname => "Jones"},
      {:snumber => 2}
    ]
    @suppliers.should_not == [
      {:snumber => 1, :sname => "Jones"},
      {:snumber => 2, :sname => "Smith"},
      {:snumber => 3, :sname => "Amid"}
    ]
    @suppliers.should_not == []
  end
  
  it "correctly implements << " do
    @suppliers.empty!
    @suppliers << {:snumber => 1, :sname => "Jones"}
    @suppliers.should == [{:snumber => 1, :sname => "Jones"}]
    @suppliers << {:snumber => 2, :sname => "Smith"}
    @suppliers.should == [{:snumber => 1, :sname => "Jones"}, {:snumber => 2, :sname => "Smith"}]

    @suppliers.empty!
    @suppliers.should == []
    @suppliers << [{:snumber => 1, :sname => "Jones"}, {:snumber => 2, :sname => "Smith"}]
    @suppliers.should == [{:snumber => 1, :sname => "Jones"}, {:snumber => 2, :sname => "Smith"}]
  end

end