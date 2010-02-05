require File.join(File.dirname(__FILE__), 'fixtures')
include ::Rubyrel::Fixtures

def postgres_shell_exec(what)
  `su postgres -c '#{what}'`
end

# for postgresql
info = pgsql_test_connection_info
puts postgres_shell_exec("dropdb #{info[:database]}")
puts postgres_shell_exec("dropuser #{info[:user]}")
puts "The requested password is #{info[:password]}"
puts postgres_shell_exec("createuser --superuser --createdb --createrole --login --encrypted "\
                         "--pwprompt --host #{info[:host]} --port #{info[:port]} #{info[:user]}")
puts postgres_shell_exec("createdb --encoding #{info[:encoding]} --owner #{info[:user]} "\
                         "--host #{info[:host]} --port #{info[:port]} #{info[:database]}")