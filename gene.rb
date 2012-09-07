class Gene
  attr_accessor :code

  def initialize(code)
    @code = code
  end

  def self.random(length)
    s = (1..length).inject("") { |s, x| s << (rand(94)+31) }
  end

  def cost(target)
    total = 0
    (0..target.size-1).each do |i|
      total += (@code[i].ord - target[i].ord) * (@code[i].ord - target[i].ord)
    end

    total*total
  end

  def mate(gene)
    pivot = rand(@code.length)

    code_a = @code[0,pivot] || ""
    code_b = @code[pivot-@code.length, @code.length] || ""

    gene_a = gene.code[0,pivot] || ""
    gene_b = gene.code[pivot-@code.length, @code.length] || ""

    child_1 = code_a + gene_b
    child_2 = gene_a + code_b

    [Gene.new(child_1), Gene.new(child_2)]
  end

  def mutate(chance)
    if rand() > chance
      return
    end

    index = (rand() * @code.length).floor
    newChar = ((rand(94)+31)).chr
    newString = ''

    (0..@code.length-1).each do |i|
      if i == index
        newString += newChar
      else
        newString += @code[i]
      end
    end

    @code = newString
  end
end