require 'rubyrel'
describe "Rubyrel algebra query parser" do
  include ::Rubyrel::Fixtures
  
  def parse(schema, &block)
    parser = Rubyrel::Algebra::QueryParser.new(schema)
    parser.parse(&block)
  end
  
  it "should support reference to relvars" do
    result = parse(rrel_schema('suppliers_and_parts')) { base.suppliers }
    (Rubyrel::Algebra::RelvarRef===result).should be_true
  end
  
  it "should support projection" do
    result = parse(rrel_schema('suppliers_and_parts')) { base.suppliers.project(:snumber) }
    (Rubyrel::Algebra::Project===result).should be_true
    result = parse(rrel_schema('suppliers_and_parts')) { base.suppliers[:snumber] }
    (Rubyrel::Algebra::Project===result).should be_true
  end

end
