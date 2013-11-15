# This is my homework for Euler problem 1

=begin
#commenting out my first attempt CHT 2013-11-15

# Declares the starting point for threes
threes = 3 

# Creates an array with multiples of three
wholeArray = Array.new [threes]
while threes < 1000 
	wholeArray.push(threes)
	threes += 3
end

# Creates an array with multiples of five
fives = 5 
while fives < 1000 
	wholeArray.push(fives)
	fives += 5
end

# Pulls out the duplicates from my wholeArray
wholeArray = wholeArray.uniq

# Adds numbers in wholeArray
total = 0
for number in wholeArray
	total = total + number
end

# Writes total of sum of wholeArray to screen.
puts total

=end

# Round 2 of the hw to make it one loop instead of two
#elminates need to pull out duplicates

# Asks for user input at console
# .chomp removes extra spaces

puts "Enter end of range"
range_end = gets.chomp
puts "Enter the first divisor"
divisor1 = gets.chomp
puts "Enter the second divisor"
divisor2 = gets.chomp

# .to_i converts the input to integer
result = 0
for i in 1..range_end.to_i
	if (i % divisor1.to_i == 0) || (i % divisor2.to_i == 0)
		result += i
	end
end

puts "Euler's problem \#1 The result is #{result}"
