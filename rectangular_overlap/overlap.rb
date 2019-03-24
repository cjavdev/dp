require 'rspec/autorun'

def overlap(r1, r2)
  left_x = [r1[:left_x], r2[:left_x]].max
  bottom_y = [r1[:bottom_y], r2[:bottom_y]].max

  width = [r1[:left_x] + r1[:width], r2[:left_x] + r2[:width]].min - left_x
  height = [r1[:bottom_y] + r1[:height], r2[:bottom_y] + r2[:height]].min - bottom_y

  return if height <= 0 || width <= 0
  {
    left_x: left_x,
    bottom_y: bottom_y,
    width: width,
    height: height
  }
end

describe 'overlap' do
  it "works when entirely contained in the other" do
    # 4 x x x x x
    # 3 x b b b x
    # 2 x b b b x
    # 1 x x x x x
    # 0 1 2 3 4 5 6 7
    r1 = {
      left_x: 1,
      bottom_y: 1,
      width: 5,
      height: 4
    }
    r2 = {
      left_x: 2,
      bottom_y: 2,
      width: 3,
      height: 2
    }
    expect(overlap(r1, r2)).to eq(r2)
  end

  it "perfect overlap" do
    # 2 b b
    # 1 b b
    # 0 1 2 3 4 5 6 7
    r1 = {
      left_x: 1,
      bottom_y: 1,
      width: 2,
      height: 2
    }
    r2 = {
      left_x: 1,
      bottom_y: 1,
      width: 2,
      height: 2
    }
    expect(overlap(r1, r2)).to eq(r1)
  end

  it "finds overlap of two non overlapping rectangles" do
    # 5 x x
    # 4 x x
    # 3
    # 2 r r
    # 1 r r
    # 0 1 2 3 4 5 6 7
    r1 = {
      left_x: 1,
      bottom_y: 1,
      width: 2,
      height: 2
    }
    r2 = {
      left_x: 1,
      bottom_y: 4,
      width: 2,
      height: 2
    }
    expect(overlap(r1, r2)).to eq(nil)
  end

  it "finds overlap of two non overlapping rectangles" do
    # 4 x x
    # 3 x x
    # 2 r r
    # 1 r r
    # 0 1 2 3 4 5 6 7
    r1 = {
      left_x: 1,
      bottom_y: 1,
      width: 2,
      height: 2
    }
    r2 = {
      left_x: 1,
      bottom_y: 3,
      width: 2,
      height: 2
    }
    expect(overlap(r1, r2)).to eq(nil)
  end

  it "finds overlap of two simple rectangles" do
    # 4   x x x x x x
    # 3 r b b b b b x
    # 2 r b b b b b x
    # 1 r r r r r r
    # 0 1 2 3 4 5 6 7
    r1 = {
      left_x: 1,
      bottom_y: 1,
      width: 6,
      height: 3
    }
    r2 = {
      left_x: 2,
      bottom_y: 2,
      width: 6,
      height: 3
    }
    expect(overlap(r1, r2)).to eq({
      left_x: 2,
      bottom_y: 2,
      width: 5,
      height: 2
    })
  end

  it "finds overlap of flipped two simple rectangles" do
    # 4   x x x x x x
    # 3 r b b b b b x
    # 2 r b b b b b x
    # 1 r r r r r r
    # 0 1 2 3 4 5 6 7
    r1 = {
      left_x: 1,
      bottom_y: 1,
      width: 6,
      height: 3
    }
    r2 = {
      left_x: 2,
      bottom_y: 2,
      width: 6,
      height: 3
    }
    expect(overlap(r2, r1)).to eq({
      left_x: 2,
      bottom_y: 2,
      width: 5,
      height: 2
    })
  end
end
