require 'rspec'
require './enumerable.rb'

describe Enumerable do
  let(:array) { [1, 2, 3] }
  let(:hash) { { one: 1, two: 1, three: 2 } }
  let(:range) { (1..10) }
  let(:pr) do
    proc do |num|
      num
    end
  end

  describe '#my_each' do
    it 'returns an Enumerator when no block is given' do
      expect(array.my_each).to be_an(Enumerator)
    end

    it 'returns self when self is an array and  block is given' do
      expect(array.my_each { |num| num }).to eql(array)
    end

    it 'returns self when self is a hash and  block is given' do
      expect(hash.my_each { |num| num }).to eql(hash)
    end

    it 'returns self when self is a range and  block is given' do
      expect(range.my_each { |num| num }).to eql(range)
    end

    it 'returns self when self is an array and proc is given' do
      expect(array.my_each(&pr)).to eql(array)
    end

    it 'returns self when self is a hash and proc is given' do
      expect(hash.my_each(&pr)).to eql(hash)
    end

    it 'returns self when self is a hash and proc is given' do
      expect(range.my_each(&pr)).to eql(range)
    end
  end

  describe '#my_each_with_index' do
    it 'returns an Enumerator when no block is given' do
      expect(array.my_each_with_index).to be_an(Enumerator)
    end

    it 'returns self when self is an array and  block is given' do
      expect(array.my_each_with_index { |num| num }).to eql(array)
    end

    it 'returns self when self is a hash and  block is given' do
      expect(hash.my_each_with_index { |num| num }).to eql(hash)
    end

    it 'returns self when self is a range and  block is given' do
      expect(range.my_each_with_index { |num| num }).to eql(range)
    end

    it 'returns self when self is an array and proc is given' do
      expect(array.my_each_with_index(&pr)).to eql(array)
    end

    it 'returns self when self is a hash and proc is given' do
      expect(hash.my_each_with_index(&pr)).to eql(hash)
    end

    it 'returns self when self is a hash and proc is given' do
      expect(range.my_each_with_index(&pr)).to eql(range)
    end
  end

  describe '#my_select' do
    it 'returns an Enumerator when no block is given' do
      expect(array.my_select).to be_an(Enumerator)
    end

    it 'returns an array containing elements that passed a particular condition in a block when called on an array' do
      expect(array.my_select { |num| num < 2 }).to eql([1])
    end

    it 'returns a hash containing elements that passed a particular condition in a block when called on a hash' do
      expect(hash.my_select { |_key, num| num < 2 }).to eql({ one: 1, two: 1 })
    end

    it 'returns an array containing elements that passed a particular condition in a block when called on a range' do
      expect(range.my_select { |num| num < 5 }).to eql([1, 2, 3, 4])
    end
  end

  describe '#my_all?' do
    it 'returns true if all elements of the array that my_all? is called on are true and no block is given' do
      expect(array.my_all?).to be true
    end

    it 'returns false if atleast one element of the array is false or nil and no block is given' do
      expect([false, nil].my_all?).to be false
    end

    it 'returns true if self is a hash and no block is given' do
      expect(hash.my_all?).to be true
    end

    it 'returns true if self is a range and no block is given' do
      expect(range.my_all?).to be true
    end

    it "returns true if self is an array and all it's elements pass for the condition in a given block" do
      expect(array.my_all?(&:positive?)).to be true
    end

    it "returns false if self is an array and atleast one of it's elements fails the condition in a given block" do
      expect(array.my_all?(&:even?)).to be false
    end

    it "returns true if self is a hash and all it's elements pass for the condition in a given block" do
      expect(hash.my_all? { |_key, num| num.positive? }).to be true
    end

    it "returns false if self is a hash and atleast one of it's elements fails the condition in a given block" do
      expect(hash.my_all? { |_key, num| num.even? }).to be false
    end

    it "returns true if self is a range and all it's elements pass for the condition in a given block" do
      expect(range.my_all?(&:positive?)).to be true
    end

    it "returns false if self is a range and atleast one of it's elements fails the condition in a given block" do
      expect(range.my_all?(&:even?)).to be false
    end

    it 'returns true if self is an array and all elements match specified element given as an argument' do
      expect([1, 1, 1, 1].my_all?(1)).to be true
    end

    it 'returns false if self is an array and atleast one of the elements do not match the given argument' do
      expect(array.my_all?(1)).to be false
    end

    it "returns false if self is a hash and an argument is given that doesn't match all of elements" do
      expect(hash.my_all?(1)).to be false
    end

    it 'returns true if self is an empty hash and the argument given is a Hash' do
      expect({}.my_all?(Hash)).to be true
    end

    it 'returns true if self is a range of 1 number that matches the given argument' do
      expect((1..1).my_all?(1)).to be true
    end

    it 'returns false if self is a range and the argument given does not match all of the range numbers' do
      expect(range.my_all?(1)).to be false
    end
  end

  describe '#my_any?' do
    it 'returns true if any element of the array that my_any? is called on is true and no block is given' do
      expect(array.my_any?).to be true
    end

    it 'returns false if all elements of the array that my_any? is called on are false or nil and no block is given' do
      expect([false, nil].my_any?).to be false
    end

    it 'returns true if self is an empty array and no block is given' do
      expect([].my_any?).to be false
    end

    it 'returns true if self is not an empty hash and no block is given' do
      expect(hash.my_any?).to be true
    end

    it 'return false if self is an empty hash and no block is given' do
      expect({}.my_any?).to be false
    end

    it 'returns true if self is a range and no block is given' do
      expect(range.my_any?).to be true
    end

    it "returns true if self is an array and any of it's elements pass for the condition in a given block" do
      expect(array.my_any?(&:positive?)).to be true
    end

    it "returns false if self is an array and all of it's elements fail the condition in a given block" do
      expect(array.my_any?(&:zero?)).to be false
    end

    it "returns true if self is a hash and any of it's elements pass for the condition in a given block" do
      expect(hash.my_any? { |_key, num| num.positive? }).to be true
    end

    it "returns false if self is a hash and all of it's elements fail the condition in a given block" do
      expect(hash.my_any? { |_key, num| num.zero? }).to be false
    end

    it "returns true if self is a range and any of it's elements pass for the condition in a given block" do
      expect(range.my_any? { |num| num == 2 }).to be true
    end

    it "returns false if self is a range and all of it's elements fail the condition in a given block" do
      expect(range.my_any?(&:zero?)).to be false
    end

    it "returns true if self is an array and any of it's elements match specified element given as an argument" do
      expect(array.my_any?(1)).to be true
    end

    it "returns false if self is an array and all of it's elements do not match the given argument" do
      expect(array.my_any?(10)).to be false
    end

    it 'returns false if self is a hash and an argument is given' do
      expect(hash.my_any?(1)).to be false
    end

    it 'returns true if self is a range containing a number that matches the given argument' do
      expect(range.my_any?(1)).to be true
    end

    it 'returns false if self is a range and none of the range numbers match the given argument' do
      expect(range.my_any?(0)).to be false
    end
  end

  describe '#my_none?' do
    it 'returns true if all of the elements of the array are false and no block is given' do
      expect([false, false, false].my_none?).to be true
    end

    it 'returns false if atleast one element of the array is not false or nil and no block is given' do
      expect([false, nil, 'I am a string'].my_none?).to be false
    end

    it 'returns false if self is a not an empty hash and no block is given' do
      expect(hash.my_none?).to be false
    end

    it 'returns true if self is an empty hash and no block is given' do
      expect({}.my_none?).to be true
    end

    it 'returns false if self is a range and no block is given' do
      expect(range.my_none?).to be false
    end

    it "returns true if self is an array and none of it's elements pass for the condition in a given block" do
      expect(array.my_none?(&:zero?)).to be true
    end

    it "returns false if self is an array and any of it's elements pass the condition in a given block" do
      expect(array.my_none?(&:even?)).to be false
    end

    it "returns true if self is a hash and none of it's elements pass for the condition in a given block" do
      expect(hash.my_none? { |_key, num| num.zero? }).to be true
    end

    it "returns false if self is a hash and any of it's elements pass the condition in a given block" do
      expect(hash.my_none? { |_key, num| num.even? }).to be false
    end

    it "returns true if self is a range and none of it's elements pass for the condition in a given block" do
      expect(range.my_none?(&:zero?)).to be true
    end

    it "returns false if self is a range and atleast one of it's elements passes the condition in a given block" do
      expect(range.my_none?(&:even?)).to be false
    end

    it 'returns false if self is an array and all elements match specified element given as an argument' do
      expect(array.my_none?(1)).to be false
    end

    it 'returns true if self is an array and none of the elements match the given argument' do
      expect(array.my_none?(0)).to be true
    end

    it 'returns true if self is a hash and an argument is given that matches none of elements' do
      expect(hash.my_none?(0)).to be true
    end

    it 'returns true if self is an empty hash and the argument given is a Hash' do
      expect({}.my_none?(Hash)).to be true
    end

    it 'returns false if self is a range of 1 number that matches the given argument' do
      expect((1..1).my_none?(1)).to be false
    end

    it 'returns true if self is a range and the argument does not match any of the range numbers' do
      expect(range.my_none?(0)).to be true
    end
  end

  describe '#my_count' do
    it 'returns the length of calling array when no block is given.' do
      expect(array.my_count).to eql(3)
    end

    it 'returns the size of calling hash when no block is given' do
      expect(hash.my_count).to eql(3)
    end

    it 'returns the size of calling range when no block is given' do
      expect(range.my_count).to eql(10)
    end

    it 'returns the amount of elements in calling array that pass a condition given in a block' do
      expect(array.my_count(&:even?)).to eql(1)
    end

    it 'returns the amount of elements in calling hash that pass a condition given in a block' do
      expect(hash.my_count { |_key, val| val == 1 }).to eql(2)
    end

    it 'returns the amount of elements in calling range that pass a condition given in a block' do
      expect(range.my_count(&:odd?)).to eql(5)
    end

    it 'returns the amount of elements in calling array that match a given argument' do
      expect(array.my_count(2)).to eql(1)
    end

    it 'returns the amount of elements in calling hash that match a given argument' do
      expect(hash.my_count(1)).to eql(0)
    end

    it 'returns the amount of elements in calling range that match a given argument' do
      expect(range.my_count(3)).to eql(1)
    end
  end

  describe '#my_map' do
    it 'returns Enumerator when method is called on an array and no block or proc argument is given' do
      expect(array.my_map).to be_an(Enumerator)
    end

    it 'returns Enumerator when method is called on a hash and no block or proc argument is given' do
      expect(hash.my_map).to be_an(Enumerator)
    end

    it 'returns Enumerator when method is called on a range and no block or proc argument is given' do
      expect(range.my_map).to be_an(Enumerator)
    end

    it 'when called on an array returns a new array with new items equal to specified paramaters of given block' do
      expect(array.my_map { |num| num * 2 }).to eql([2, 4, 6])
    end

    it 'when called on a hash returns a new array with new items equal to specified paramaters of given block' do
      expect(hash.my_map { |_key, num| num * 2 }).to eql([2, 2, 4])
    end

    it 'when called on a range returns a new array with new items equal to specified paramaters of given block' do
      expect(range.my_map { |num| num * 2 }).to eql([2, 4, 6, 8, 10, 12, 14, 16, 18, 20])
    end

    it 'when called on an array returns a new array with items equal to paramaters of given proc as argument' do
      expect(array.my_map(pr)).to eql([1, 2, 3])
    end

    it 'when called on a hash returns a new nested array with items equal to paramaters of given proc as argument' do
      expect(hash.my_map(pr)).to eql([[:one, 1], [:two, 1], [:three, 2]])
    end

    it 'when called on a range returns a new array with items equal to paramaters of given proc as argument' do
      expect(range.my_map(pr)).to eql([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
    end
  end

  describe '#my_inject' do
    it 'returns the first array element when no argument is given and block contains one variable' do
      expect(array.my_inject { |num| num }).to eql(1)
    end

    it 'returns the first hash element as an array when no argument is given and block contains one variable' do
      expect(hash.my_inject { |num| num }).to eql([:one, 1])
    end

    it 'returns the first range element when no argument is given and block contains one variable' do
      expect(range.my_inject { |num| num }).to eql(1)
    end

    it 'returns the argument value when called on an array and block contains one variable' do
      expect(array.my_inject(2) { |num| num }).to eql(2)
    end

    it 'returns the argument value when called on a range and block contains one variable' do
      expect(array.my_inject(2) { |num| num }).to eql(2)
    end

    it 'returns an accumulated value of an array based on provided parameters in a block and no argument is given' do
      expect(array.my_inject { |sum, num| sum + num }).to eql(6)
    end

    it 'returns an accumulated value of a range based on provided parameters in a block and no argument is given' do
      expect(range.my_inject { |sum, num| sum + num }).to eql(55)
    end

    it 'returns an accumulated value of an array based on provided argument value and parameters in a block' do
      expect(array.my_inject(2) { |sum, num| sum + num }).to eql(8)
    end

    it 'returns an accumulated value of a range based on provided argument value and parameters in a block' do
      expect(range.my_inject(2) { |sum, num| sum + num }).to eql(57)
    end

    it 'returns an accumulated value of an array based on provided argument symbol and no block is given' do
      expect(array.my_inject(:*)).to eql(6)
    end

    it 'returns an accumulated value of a range based on provided argument symbol and no block is given' do
      expect(range.my_inject(:+)).to eql(55)
    end

    it 'returns an accumulated value of an array when given a value and a symbol as arguments and no block is given' do
      expect(array.my_inject(2, :*)).to eql(12)
    end

    it 'returns an accumulated value of a range when given a value and a symbol as arguments and no block is given' do
      expect(range.my_inject(2, :+)).to eql(57)
    end
  end
end

describe '#multiply_els' do
  it 'returns a multiplication based accumulated value of the argument given' do
    expect(multiply_els([1, 2, 3])).to eql(6)
  end
end
