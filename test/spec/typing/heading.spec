require 'rubyrel'
describe ::Rubyrel::Typing::Heading do
  
  def heading(pairs) ::Rubyrel::Typing::Heading.new(pairs) end
  def self.heading(pairs) ::Rubyrel::Typing::Heading.new(pairs) end  
  
  HEADINGS = [
    heading({}),
    heading(:name => String),
    heading(:name => Integer),
    heading(:name => String, :age => Integer),
  ]
      
  def sort_attributes(attrs)
    attrs.sort{|s1,s2| s1.to_s <=> s2.to_s}
  end
  
  it "should provide a degree method" do
    heading({}).degree.should == 0
    heading({:name => String}).degree.should == 1
    heading({:name => String, :age => Integer}).degree.should == 2
  end
  
  it "should provide an empty? method" do
    heading({}).empty?.should be_true
    heading({:name => String}).empty?.should be_false
    heading({:name => String, :age => Integer}).empty?.should be_false
  end
  
  it 'should support returning attribute names' do
    tests = [
      [heading({}), []],
      [heading(:name => String), [:name]],
      [heading(:name => String, :age => Integer), [:age, :name]]]
    tests.each do |a|
      sort_attributes(a[0].attribute_names).should == a[1]
    end
  end
  
  it "should support checking for attribute existence" do
    heading({}).has_attr?(:name).should be_false
    heading({}).has_attr?(:age).should be_false
    heading({:name => String}).has_attr?(:name).should be_true
    heading({:name => String}).has_attr?(:age).should be_false
    heading({:name => String, :age => Integer}).has_attr?(:name).should be_true
    heading({:name => String, :age => Integer}).has_attr?(:age).should be_true
  end
  
  it "should support requesting the domain of an attribute" do
    heading({}).domain_of(:name).should be_nil
    heading(:name => String).domain_of(:name).should == String
    heading(:name => String).domain_of(:age).should be_nil
    heading(:name => String, :age => Integer).domain_of(:name).should == String
    heading(:name => String, :age => Integer).domain_of(:age).should == Integer
  end
  
  it "should be enumerable" do
    heading({}).each {|a| false.should be_true}
    count=0
    heading(:name => String, :age => Integer).each do |a|
      (a.name == :name || a.name == :age).should be_true
      a.domain.should == ((a.name == :name) ? String : Integer)
      count += 1
    end
    count.should == 2
  end
  
  # Tests heading equality  
  it "should support being compared through == operator" do
    prev = nil;
    HEADINGS.each do |h|
      h.should == h
      h.equal?(h).should be_true
      h.eql?(h).should be_true
      (h == prev).should be_false unless prev == nil
      prev = h;
    end

    h1, h2 = heading({}), heading({})
    ((h1 == h2) && (h1.equal?(h2)) && (h1.eql?(h2))).should be_true
    ((h2 == h1) && (h2.equal?(h1)) && (h2.eql?(h1))).should be_true

    h1, h2 = heading(:name => String), 
             heading(:name => String)
    ((h1 == h2) && (h1.equal?(h2)) && (h1.eql?(h2))).should be_true
    ((h2 == h1) && (h2.equal?(h1)) && (h2.eql?(h1))).should be_true

    h1, h2 = heading(:name => String, :age => Integer), 
             heading(:name => String, :age => Integer)
    ((h1 == h2) && (h1.equal?(h2)) && (h1.eql?(h2))).should be_true
    ((h2 == h1) && (h2.equal?(h1)) && (h2.eql?(h1))).should be_true
  
    h1, h2 = heading(:age => Integer, :name => String), 
             heading(:name => String, :age => Integer)
    ((h1 == h2) && (h1.equal?(h2)) && (h1.eql?(h2))).should be_true
    ((h2 == h1) && (h2.equal?(h1)) && (h2.eql?(h1))).should be_true
  end

  # Tests hash method
  it "should provide a has method" do
    h1, h2 = heading({}), heading({})
    h1.hash.should == h2.hash
    h1, h2 = heading(:name => String), heading(:name => String)
    h1.hash.should == h2.hash
    h1, h2 = heading(:name => String, :age => Integer), 
             heading(:name => String, :age => Integer)
    h1.hash.should == h2.hash
    h1, h2 = heading(:age => Integer, :name => String), 
             heading(:name => String, :age => Integer)
    h1.hash.should == h2.hash
  end
  
  it "should provide a definition method" do
    heading(:name => String).definition.should == "(:name => String)"
    heading(:age => Integer, :name => String).definition.should == "(:age => Integer, :name => String)"
    heading(:name => String, :age => Integer).definition.should == "(:age => Integer, :name => String)"
  end

  it "should help performing type checking" do
    heading({}).valid_ruby_literal?({}).should be_true
    heading({}).valid_ruby_literal?(:age => 12).should be_false
    h = heading(:name => String)
    h.valid_ruby_literal?(:name => "blambeau").should be_true
    h.valid_ruby_literal?({}).should be_false
    h.valid_ruby_literal?(:age => 12).should be_false
    h.valid_ruby_literal?(:name => "blambeau", :age => 12).should be_false
  end

end
