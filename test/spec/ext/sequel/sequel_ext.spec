require 'rubyrel'
describe "Rubyrel sequel extensions" do
  
  it "should give a new add_constraint method to schema generator" do
    ::Sequel::Schema::Generator.new(nil).respond_to?(:rubyrel_add_constraint).should == true
  end
  
  it "should add support for schemas on databases" do
    db = ::Sequel::Database.new
    db.respond_to?(:supports_schemas?).should be_true
    db.supports_schemas?.should be_false
    got = db.instance_eval {"#{create_schema_sql('test')};#{drop_schema_sql('test')}"}
    got.should == 'CREATE SCHEMA "TEST";DROP SCHEMA "TEST"'
  end
  
  it "should add real schema support on postgresql databases" do
    db = ::Sequel::Database.adapter_class('postgres').new
    db.supports_schemas?.should be_true
    got = db.instance_eval {"#{create_schema_sql('test')};#{drop_schema_sql('test')}"}
    got.should == 'CREATE SCHEMA "test";DROP SCHEMA "test" CASCADE'
  end
  
end