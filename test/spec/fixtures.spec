require 'rubyrel'
describe ::Rubyrel::Fixtures do
  include ::Rubyrel::Fixtures
  
  it "should have a correct suppliers and parts schema" do
    s = rrel_schema('suppliers_and_parts')
    n = s.namespace(:base, false)
    n.should_not be_nil
    n.name.should == :base
    n.relvars.size.should == 3
    
    suppliers = n.relvar(:suppliers, false)
    suppliers.should_not be_nil
    suppliers.attributes.size.should == 2
    
    sname = suppliers.attribute(:sname)
    sname.name.should == :sname
    sname.domain.should == String
  end

end


