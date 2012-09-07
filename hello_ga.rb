require_relative 'gene'
require_relative 'population'
require 'ruby-prof'

goal = 'Hello World!'

p = Population.random_population(100, goal)

puts "generation number #{p.generation_number}"

g = p.members.first
puts "code: #{g.code}"
puts "cost: #{g.cost(goal)}\n\n"

RubyProf.start
beginning_time = Time.now

while p.members.first.code != goal
  puts "generation number #{p.generation_number}"
  p.run_generation

  g = p.members.first
  puts "code: #{g.code}"
  puts "cost: #{g.cost(goal)}\n\n"
end

end_time = Time.now
puts "Time elapsed #{(end_time - beginning_time)} seconds"

result = RubyProf.stop
# Print a flat profile to text
printer = RubyProf::FlatPrinter.new(result)
printer.print(STDOUT)