require "rubyrel"
describe ::Rubyrel::DDL do
  include ::Rubyrel::Fixtures
  
  it "should parse all fixture files correctly" do
    all_rrel_files{|f| Rubyrel.parse_ddl_file(f)}
  end
  
  it "should propose creating database schemas easily" do
    schema = Rubyrel::DDL.schema(:database) do
      namespace(:public) {
        relvar(:people) {
          attribute :id, Integer
          attribute :name, String
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
  
  it "should support naming candidate keys" do
    schema = Rubyrel::DDL.schema(:database) do
      namespace(:public) {
        relvar(:people) {
          attribute :id, Integer
          attribute :name, String
          primary_key "primary_key", :id
          candidate_key "by_name", :name
        } 
      }
    end
    people = schema.namespace(:public).relvar(:people)
    pk = people.primary_key
    pk.name.should == "primary_key"
    pk = people.candidate_keys["primary_key"]
    pk.name.should == "primary_key"
    pk.attributes.should == people.attributes(:id)
    
    ak = people.candidate_keys["by_name"]
    ak.name.should == "by_name"
    ak.attributes.should == people.attributes(:name)
  end
  
  it "should support expressing composite keys" do
    schema = Rubyrel::DDL.schema(:database) do
      namespace(:public) {
        relvar(:people) {
          attribute :id, Integer
          attribute :name, String
          primary_key :id, :name
        }
      }
    end
    people = schema.namespace(:public).relvar(:people)
    pk = people.primary_key
    pk.attributes.should == people.attributes(:id, :name)
  end

  it "should support expressing named composite keys" do
    schema = Rubyrel::DDL.schema(:database) do
      namespace(:public) {
        relvar(:people) {
          attribute :id, Integer
          attribute :name, String
          primary_key "pk", :id, :name
        }
      }
    end
    people = schema.namespace(:public).relvar(:people)
    pk = people.primary_key
    pk.name.should == "pk"
    pk.attributes.should == people.attributes(:id, :name)
  end

  it "should support expressing foreign keys" do
    schema = Rubyrel::DDL.schema(:database) do
      namespace(:public) {
        relvar(:people) {
          attribute :id, Integer
          attribute :name, String
          primary_key :id
          candidate_key :name
        }
        relvar(:mails) {
          attribute :people, Integer
          attribute :mail, String
          primary_key :people, :mail
          foreign_key :people => relvar(:people)
        }
      }
    end
    n = schema.namespace(:public)
    people = n.relvar(:people)
    mails = n.relvar(:mails)
    fk = mails.foreign_keys.values[0]
    fk.should_not be_nil
    fk.name.should == "fk_mails_0"
    fk.attributes.should == mails.attributes(:people)
    fk.target.should == people.primary_key
  end
  
  it "should help creating SQL script" do
    schema = rrel_schema('suppliers_and_parts')
    schema.to_create_sql(::Sequel::Database.adapter_class('postgres').new).should_not be_nil
  end

end