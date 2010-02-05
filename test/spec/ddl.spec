require "rubyrel"
describe ::Rubyrel::DDL do
  
  it "should propose creating database schemas easily" do
    schema = Rubyrel::DDL.schema(:database) do
      open(:public) {
        relvar(:people) {
          attribute :id   => Integer
          attribute :name => String
          primary_key :id
          candidate_key :name
        } 
      }
    end
    schema.name.should == :database
    schema.namespaces.size.should == 1
    
    public_n = schema.namespace(:public)
    public_n.should_not be_nil
    
    people = public_n.relvar(:people)
    people.should_not be_nil
    people.name.should == :people
    people.attributes.size.should == 2

    id = people.attribute(:id)
    id.should_not be_nil
    id.name.should == :id
    id.domain.should == Integer

    name = people.attribute(:name)
    name.should_not be_nil
    name.name.should == :name
    name.domain.should == String
    
    pk = people.primary_key
    pk.should_not be_nil
    pk.name.should == "pk_people"
    pk.attributes.should == [people.attribute(:id)]
    
    aks = people.candidate_keys
    aks.size.should == 2
    ak = aks["ak_people_1"]
    ak.should_not be_nil
    ak.name.should == "ak_people_1"
    ak.attributes.should == [people.attribute(:name)]
  end
  
end