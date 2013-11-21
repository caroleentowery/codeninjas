#!/usr/bin/env ruby

require 'mathn'
require 'set'
require 'benchmark'
require "test/unit"

class MultipleCalculator
  
  def self.single(number, upperLimit)
    return (0.5 * ((upperLimit - 1) / number).floor * ((upperLimit - 1) / number + 1).floor * number).floor
  end
  
  def self.pair(number1, number2, upperLimit)
    return single(number1, upperLimit) + single(number2, upperLimit) - single(number1 * number2, upperLimit)
  end
  
  def self.validate(numbers)
    numbers = numbers.uniq
    results = Array.new
    
    numbers.sort.each do |nbr|      
      if !(results.detect {|result| nbr % result == 0 && nbr >= 1})
        results.push nbr.floor
      end
    end
    
    return results
  end
  
  def self.set(numbers, upperLimit)
    
    # puts "starting for numbers: #{numbers.join(", ")} with upper limit of: #{upperLimit}"
    numbers = validate(numbers)
    
    if (numbers.count == 0)
      return 0
    elsif (numbers.count == 1)
      return single(numbers[0], upperLimit)
    elsif (numbers.count == 2)
      return pair(numbers[0], numbers[1], upperLimit)
    end
    
    result = 0
    # initialResult = pair(numbers[0], numbers[1], upperLimit)
    # 
    # puts "\ninitial result #{initialResult}"
    # 
    # tempResult = single(numbers[2], upperLimit)
    # 
    # puts "temp result #{tempResult}"
    # 
    # a = numbers[2].lcm(numbers[0])
    # b = numbers[2].lcm(numbers[1])
    # c = numbers[0].lcm(numbers[1])
    # 
    # puts "a = #{a} b = #{b} c = #{c}"
    # 
    # subs = pair(a, b, upperLimit)
    # 
    # puts "subs = #{subs}"
    # 
    # subs -= single(numbers[2].lcm(c), upperLimit)
    # 
    # puts "subs = #{subs}"
    # 
    # tempResult -= subs
    # 
    # puts "tempResult = #{tempResult}"
    # 
    # if (a % numbers[2] == 0 && b % numbers[2] == 0)
    #   # ab = a.lcm(b)
    #   ab = a * b
    #   puts "ab is #{ab}"
    # 
    #   if (ab < upperLimit)
    #     tempResult -= single(ab, upperLimit)
    #     puts "ab adjusts #{single(ab, upperLimit)}"
    #   end
    # end
    # 
    # result = initialResult + tempResult #+ pump
    # 
    # puts "result = #{initialResult} - #{tempResult} = #{result}"
    
    return result
  end
  
  def self.forLoop(numbers, upperLimit)
    result = 0
  
    for i in 0..upperLimit - 1
      result += numbers.detect {|nbr| i % nbr == 0} ? i : 0
    end
    return result
  end
    
  def self.select(numbers, upperLimit)
    return (1..upperLimit - 1).find_all { |i| numbers.detect {|nbr| i % nbr == 0} }.inject(:+)
  end

end

class MultipleCalculatorTests < Test::Unit::TestCase
 
  def test_validate
    values = [2, 3, 4, 5, 6, 7, 8]
    corrected = MultipleCalculator.validate(values)
    
    assert_equal([2, 3, 5, 7], corrected)  
  end
  
  def test_calculateSingle
    limits = [10, 76, 100, 1000]
    numbers = [3, 5, 7, 9, 10, 11, 13, 14, 15, 16, 76, 78, 100, 101]
    
    limits.each do |limit|
      numbers.each do |nbr|
        assert_equal(MultipleCalculator.forLoop([nbr], limit), MultipleCalculator.single(nbr, limit))
      end
    end
  end
  
  def test_calculatePair
    limits = [10, 76, 100, 1000]
    numberSet = Set.new
    numberSet.add([3, 5])
    numberSet.add([4, 5])
    numberSet.add([3, 7])
    numberSet.add([3, 11])
    
    limits.each do |limit|
      numberSet.each do |nbrs|
        assert_equal(MultipleCalculator.forLoop(nbrs, limit), MultipleCalculator.pair(nbrs[0], nbrs[1], limit))
      end
    end
  end
  
  def test_calculateSet
    limits = [10, 76, 100, 1000]
    numberSet = Set.new
    numberSet.add([3])
    numberSet.add([5])
    numberSet.add([7])
    numberSet.add([13])
    numberSet.add([3, 5])
    numberSet.add([4, 5])
    numberSet.add([3, 7])
    numberSet.add([3, 11])
    
    limits.each do |limit|
      numberSet.each do |nbrs|
        assert_equal(MultipleCalculator.forLoop(nbrs, limit), MultipleCalculator.set(nbrs, limit))
      end
    end
  end
  
  # def test_calculate3Values
  #   limits = [10, 20, 30, 40, 50, 60, 75, 100, 110, 150, 200, 500, 750, 1000, 2000, 10000, 100000, 100000]
  #   numberSet = Set.new
  #   numberSet.add([3, 5, 7])    
  #   numberSet.add([3, 4, 5])   
  #   numberSet.add([2, 3, 4])
  #   numberSet.add([2, 3, 5])
  #   numberSet.add([5, 6, 7])  
  #   numberSet.add([2, 4, 9]) 
  #   numberSet.add([8, 9, 10])   
  #   numberSet.add([11, 12, 13])
  #   numberSet.add([3, 14, 23])  
  #   numberSet.add([3, 15, 28])  
  #   numberSet.add([1, 2, 3]) 
  #   
  #   limits.each do |limit|
  #     numberSet.each do |nbrs|
  #       assert_equal(MultipleCalculator.forLoop(nbrs, limit), MultipleCalculator.set(nbrs, limit))
  #     end
  #   end
  # end
  
  # def test_calculateValues
  #   limits = [10, 20, 30, 40, 50]#, 60, 75, 100, 110, 150, 200, 500, 750, 1000, 2000, 10000, 100000, 100000]
  #   numberSet = Set.new
  #   numberSet.add([3, 5, 7])    
  #   numberSet.add([3, 4, 5])   
  #   numberSet.add([2, 3, 4])
  #   numberSet.add([3, 5, 7, 11])    
  #   numberSet.add([3, 4, 5, 13])  
  #   
  #   limits.each do |limit|
  #     numberSet.each do |nbrs|
  #       assert_equal(MultipleCalculator.forLoop(nbrs, limit), MultipleCalculator.set(nbrs, limit))
  #     end
  #   end
  # end
 
end

=begin
print "Numbers to Sum: "
numbers = gets.chomp.split(/[\s,]+/).map { |x| x.to_i }

print "Upper limit: "
upperLimit = gets.to_i


puts  "Caclulating for #{numbers.join(", ")}..."

result = Array.new

Benchmark.bm do |b|
  b.report("via for loop") do
    result.push MultipleCalculator.forLoop(numbers, upperLimit)
  end
  
  b.report("via Select") do
    result.push MultipleCalculator.select(numbers, upperLimit)
  end

  b.report("via Maths") do
    result.push MultipleCalculator.set(numbers, upperLimit)
  end
end

if (result.uniq.count == 1)
  puts "\nThe results match!"
  puts "The result is #{result[0].floor}"
else
  puts "\nThe results do NOT match!"
  puts "The result from for loop: #{result[0].floor}"
  puts "The result from select : #{result[1].floor}"
  puts "The result from maths: #{result[2].floor}"
end

puts "Done!"
=end
