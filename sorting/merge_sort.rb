require 'rspec/autorun'

def merge_sort(input)
  return input if input.length == 1
  mid = input.length / 2
  left = input[0...mid]
  right = input[mid..-1]
  merge(merge_sort(left), merge_sort(right))
end

def merge(a, b)
  result = []
  while !a.empty? && !b.empty?
    if a.first < b.first
      result << a.shift
    else
      result << b.shift
    end
  end
  result + a + b
end

describe 'merge_sort' do
  it "sorts 4 elements" do
    expect(merge_sort([4, 2, 3, 1])).to eq([1, 2, 3, 4])
  end
end
