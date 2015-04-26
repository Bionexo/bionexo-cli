require './config/application'

method_name = ARGV[0]

if Bionexo.respond_to? method_name
  args = ARGV[1].present? ? ARGV[1] : :completed
  Bionexo.send(method_name, args)
else
  puts 'bionexo <command> [<args>]'
  puts 'commands you can use:'
  puts 'new              creates a new quotation'
  puts 'continue <id>    continue editing a quotation'
  puts 'list [<status>]  list all quotations in specyfied status'
  puts '                 status can be [initialized, editing, completed]'
  puts '                 default: completed'
end
