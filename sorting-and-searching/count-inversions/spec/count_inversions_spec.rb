require_relative "../count_inversions"

describe '#count_inversions' do

  let(:counter) { CountInversions.new }

  context 'given an ordered array' do
    it "returns 0" do
      expect(counter.count_inversions([1,1,1,2,2])).to eq(0)
    end
  end

  context 'given an unordered array' do
    it "returns the number of inversions required to order the array" do
      expect(counter.count_inversions([2,1,3,1,2])).to eq(4)
    end
  end

end
