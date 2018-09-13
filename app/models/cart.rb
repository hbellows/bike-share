class Cart
  attr_reader :contents

  def initialize(initial_content)
    @contents = initial_content || Hash.new(0)
  end

  def add_accessory(id)
    @contents[id] ||= 0
    @contents[id] += 1
  end

  def remove_accessory(id)
    @contents.delete(id)
  end

  def decrease_quantity(id)
    @contents[id] -= 1
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

  def checkout(current_user)
    order = Order.create(status: 'ordered', user_id: current_user.id)
    contents.each do |accessory_id, quantity|
      accessory = Accessory.find(accessory_id)
      OrderAccessory.create(
        order_id:     order.id,
        accessory_id: accessory_id,
        quantity:     quantity,
        unit_price:   accessory.price
      )
    end
  end
end
