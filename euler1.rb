# This is my homework for Euler problem 1

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

# Nice job Caroleen.  Good use of the built in Ruby functions.
#
# Is there a way you could solve the problem with just one looping over the numbers?
#
# Keith