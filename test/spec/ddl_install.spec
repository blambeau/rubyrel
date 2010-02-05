require 'rubyrel'
describe "Rubyrel schema" do
  include ::Rubyrel::Fixtures
  
  it "should be installable on a sequel database easily" do
    all_schema do |schema|
      all_sequel_databases do |db|
        # puts "Installing on #{db}"
        # schema.install_on(db)
        # puts "Uninstalling on #{db}"
        # schema.uninstall_on(db)
      end
    end
  end
  
end