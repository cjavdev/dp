require 'byebug'

class BookStore
  PRICE = [
    nil,
    8.0,
    8.0 * 2 * 0.95,
    8.0 * 3 * 0.90,
    8.0 * 4 * 0.80,
    8.0 * 5 * 0.75,
  ]

  def self.calculate_price(basket)
    price = 0
    book_sets_for(basket).each do |book_set|
      price += PRICE[book_set.size]
    end
    price
  end

  def self.book_sets_for(basket)
    book_sets = []
    priority = {1 => 8, 2 => 1, 3 => 10, 4 => 9, 5 => 1}
    basket.each do |book|
      if book_sets.all? {|s| s.include?(book)}
        book_sets << [book]
      else
        possible_sets = book_sets.reject {|s| s.include?(book)}
        ideal_set = possible_sets.sort_by {|s| priority[s.size]}.last
        ideal_set << book
      end
    end
    book_sets
  end
end
