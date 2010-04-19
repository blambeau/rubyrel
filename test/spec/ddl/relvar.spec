require 'rubyrel'
require 'sequel'
describe ::Rubyrel::DDL::Relvar do
  include ::Rubyrel::Fixtures
  
  it "should propose a SQL create table statement" do
    schema = rrel_schema('suppliers_and_parts')
    suppliers = schema.namespace(:base).relvar(:suppliers)
    parts = schema.namespace(:base).relvar(:parts)
    supplies = schema.namespace(:base).relvar(:supplies)
    
    db = ::Sequel::Database.adapter_class('postgres').new
    suppliers.to_sql_create_table(db).should_not be_nil
    parts.to_sql_create_table(db).should_not be_nil
    supplies.to_sql_create_table(db).should_not be_nil
  end
  
  it "should support defaut values" do
    schema = rrel_schema('suppliers_and_parts')
    suppliers = schema.namespace(:base).relvar(:suppliers)
    suppliers.__to_physical_tuple(nil, :sname => "blambeau").should == {:sname => 'blambeau', :snumber => 0}
  end
  
end