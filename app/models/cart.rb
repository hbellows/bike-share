class Cart
  attr_reader :contents

  def initialize(initial_content)
    @contents = initial_content || Hash.new(0)
  end

  def add_accessory(id)
    @contents[id] = @contents[id] + 1
  end

  def total_count
    @contents.values.sum
  end
end
