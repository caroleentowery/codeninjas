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

#=======
# Nice job Caroleen.  Good use of the built in Ruby functions.
#
# Is there a way you could solve the problem with just one looping over the numbers?
#
# Keith
#>>>>>>> 9e530a34d54f9c2953a8cabfec254b3bc2acef06

# Round 2 of the hw to make it one loop instead of two
#elminates need to pull out duplicates

# Make a function named euler1 to do the logic

=begin
def euler1(range_end, divisor1, divisor2)
	# .to_i converts the input to integer
	result = 0
	for i in 1..range_end.to_i
		if (i % divisor1.to_i == 0) || (i % divisor2.to_i == 0)
			result += i
		end
	end	
	return result
end

# Asks for user input at console
# .chomp removes extra spaces

puts "Enter end of range"
range_end = gets.chomp
puts "Enter the first divisor"
divisor1 = gets.chomp
puts "Enter the second divisor"
divisor2 = gets.chomp

# Creates var result for being called in the function
result = euler1(range_end, divisor1, divisor2)

puts "Euler's problem \#1 The result is #{result}"
=end


# Start of homework part 3 where I don't use a loop to solve Euler #1 *CHT 2013-11-24

def euler_single_divisor(divisor, range_end) #function to do the math for one divisor
	# .floor gives the lowest integer value
	return 0.5 * ((range_end - 1) / divisor).floor * ((range_end - 1) / divisor + 1).floor * divisor
end

def euler_pair_divisor(divisor1, divisor2, range_end) #function to do rest of math with two divisors
	return (euler_single_divisor(divisor1,range_end) + euler_single_divisor(divisor2,range_end) - euler_single_divisor((divisor1 * divisor2),range_end)).to_i
end

# Asks for user input at console
# .chomp removes extra spaces
# .to_i turns it into an integer

puts "Enter end of range"
range_end = gets.chomp.to_i
puts "Enter the first divisor"
divisor1 = gets.chomp.to_i
puts "Enter the second divisor"
divisor2 = gets.chomp.to_i

# Creates var result for being called in the function
result = euler_pair_divisor(divisor1, divisor2, range_end)

puts "Euler's problem \#1 The result is #{result}"

