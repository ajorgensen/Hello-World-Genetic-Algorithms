class Population

  attr_accessor :members, :generation_number, :goal

  def initialize(members, goal)
    @goal = goal
    @generation_number = 0
    @members = members
  end

  def self.random_population(size, goal)
    Population.new (0..size-1).each.collect { Gene.new(Gene.random(goal.length)) }, goal
  end

  def self.sort_members(members, goal)
    members.sort { |a, b| a.cost(goal) <=> b.cost(goal) }
  end

  def run_generation
    sorted_members  = Population.sort_members(@members, @goal)

    # Generate the children of the top two members.
    children = sorted_members[0].mate(sorted_members[1])

    # Create a new list of members with the children substitute for the worst two
    new_members = sorted_members.first(sorted_members.length-2) + children

    new_members.drop(2).each do |member|
      member.mutate(0.75)
    end

    @members = Population.sort_members(new_members, @goal)
    @generation_number += 1
  end
end