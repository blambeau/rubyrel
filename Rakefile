require "rake/rdoctask"
require "rake/testtask"
require 'spec/rake/spectask'
require "rake/gempackagetask"
require "rubygems"

dir     = File.dirname(__FILE__)
lib     = File.join(dir, "lib", "rubyrel.rb")
version = File.read(lib)[/^\s*VERSION\s*=\s*(['"])(\d\.\d\.\d)\1/, 2]

task :default => [:test]

desc "Run all rspec test"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = FileList['test/spec/test_all.rb']
end

desc "Lauches all tests"
task :test => [:spec]

gemspec = Gem::Specification.new do |s|
  s.name = 'rubyrel'
  s.version = version
  s.summary = "RubyRel - Towards Support for the Relational Model in Ruby"
  s.description = %{Towards Support for the Relational Model in Ruby}
  s.files = Dir['lib/**/*'] + Dir['test/**/*'] + Dir['bin/*']
  s.require_path = 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ["README.rdoc", "LICENCE.rdoc"]
  s.rdoc_options << '--title' << 'RubyRel - Towards Support for the Relational Model in Ruby' <<
                    '--main' << 'README.rdoc' <<
                    '--line-numbers'  
  s.bindir = "bin"
  s.executables = []
  s.author = "Bernard Lambeau"
  s.email = "blambeau@gmail.com"
  s.homepage = "http://github.com/blambeau/rubyrel"
end
Rake::GemPackageTask.new(gemspec) do |pkg|
	pkg.need_tar = true
end
