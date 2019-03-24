require 'rspec/autorun'

def binary_search(input, target)
  floor = -1
  ceiling = input.length
  while floor + 1 < ceiling
    mid = (floor + ceiling) / 2
    value = input[mid]
    return mid if value == target

    if value > target
      ceiling = mid
    else
      floor = mid
    end
  end
end

describe 'binary_search' do
  it "finds the index of an element using binary search" do
    expect(binary_search([1, 2, 3, 4, 5, 6, 6], 2)).to eq(1)
    expect(binary_search([1, 2, 3, 4, 5, 6, 6], 6)).to eq(5)
    expect(binary_search([1, 2, 3, 4, 5, 6, 6], 1)).to eq(0)
    expect(binary_search([1, 2, 3, 4, 5, 6, 6], 3)).to eq(2)
  end
end
