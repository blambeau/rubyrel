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
    
    puts supplies.to_sql_create_table(db)
  end
  
end