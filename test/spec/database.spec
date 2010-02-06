require 'rubyrel'
describe ::Rubyrel::Database do
  include ::Rubyrel::Fixtures
  
  before(:all) do
    @schema = rrel_schema('suppliers_and_parts')
    @db = pgsql_test_database
    @schema.install_on!(@db)
  end
  
  after(:all) do
    @schema.uninstall_on!(@db)
  end
  
  it "should give access to namespaces" do
    database = database(@schema, @db)
    database.namespace(:base).should_not be_nil
    database.namespace(:base).is_a?(::Rubyrel::Namespace).should be_true
    database.base.is_a?(::Rubyrel::Namespace).should be_true
  end
  
  it "should give access to relation variables through namespace" do
    database = database(@schema, @db)

    suppliers = database.base.relvar(:suppliers)
    suppliers.should_not be_nil
    suppliers.is_a?(::Rubyrel::Relvar).should == true

    suppliers = database.base.suppliers
    suppliers.should_not be_nil
    suppliers.is_a?(::Rubyrel::Relvar).should == true
  end
  
  it "should allow affecting relation values to relation variables" do
    database = database(@schema, @db)
    database.base.suppliers = [
      {:snumber => 1, :sname => "Jones"},
      {:snumber => 2, :sname => "Smith"}
    ]
    #puts database.base.suppliers.inspect
  end
  
end
