require './config/application'

method_name = ARGV[0]
args = ARGV[1..-1]

if Bionexo.respond_to? method_name
  if args
    Bionexo.send(method_name, *args)
  else
    Bionexo.send(method_name)
  end
else
  puts 'bionexo <command> [<args>]'
  puts 'commands you can use:'
  puts 'new              creates a new quotation'
  puts 'continue <id>    continue editing a quotation'
  puts 'list [<status>]  list all quotations in specyfied status'
  puts '                 status can be [initialized, editing, completed]'
  puts '                 default: completed'
end
