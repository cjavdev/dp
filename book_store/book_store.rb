class BookStore
  DISCOUNT = {
    0 => 0,
    1 => 0,
    2 => 5,
    3 => 10,
    4 => 20,
    5 => 25
  }
  @groups = {}

  def self.calculate_price(basket)
    return 0 if basket.empty?
    best_price = Float::INFINITY
    make_groups(basket).each do |group|
      current_price = price(group)
      if current_price < best_price
        best_price = current_price
      end
    end
    best_price
  end

  def self.make_groups(basket)
    return [] if basket.empty?
    return [[basket]] if basket.length == 1

    if @groups.key?(basket)
      return @groups[basket]
    end

    results = make_groups(basket[1..-1])
    item = basket.first
    groups = []
    results.each do |result|
      groups << result + [[item]]
      result.each do |sub_result|
        # Prune tree by ignoring sub groups
        # with duplicate items.
        if !sub_result.include?(item)
          other_results = result.select{|r| r.object_id != sub_result.object_id}
          this_result = sub_result + [item]
          groups << other_results + [this_result]
        end
      end
    end
    @groups[basket] = groups
    groups
  end

  def self.price(groups)
    # memoize prices so we only calculate once per group.
    @prices = {}
    groups.sum do |g|
      if @prices.key?(g)
        @prices[g]
      else
        @prices[g] = BookStore.new(g).calculate
      end
    end
  end

  def initialize(items)
    @items = items
  end

  def calculate
    group_count = @items.uniq.count
    full_price = (@items.length - group_count) * 8.0
    discount = DISCOUNT[group_count] || 0
    full_price + (8.00 * group_count) * (100 - discount) / 100
  end
end
