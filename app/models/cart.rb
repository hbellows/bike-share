class Cart
  attr_reader :contents

  def initialize(initial_content)
    @contents = initial_content || Hash.new(0)
  end

  def add_accessory(id)
    @contents[id] ||= 0
    @contents[id] += 1
  end

  def total_count
    @contents.values.sum
  end

  def accessories_and_quantity
    accessory_objects = @contents.keys.map do |accessory_id|
      Accessory.find(accessory_id)
    end
    Hash[accessory_objects.zip(@contents.values)]
  end

  def total_price
    accessories_and_quantity.map do |accessory, quantity|
      accessory.price * quantity
    end.sum
  end
end
