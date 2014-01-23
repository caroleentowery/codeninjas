#Game of War

#Ask for players names, capitalizes them, and says welcome
print "Enter name for player 1: "
player_name1 = gets.chomp.capitalize()
print "Enter name for player 2: "
player_name2 = gets.chomp.capitalize!()
puts "\n" + "Welcome #{player_name1} and #{player_name2} to the Game of War." + "\n" + "\n"

# Makes new array called deck
deck = Array.new([])

# Makes arrays with rank and suit
rank = %w{2 3 4 5 6 7 8 9 10 J Q K A}
suit = %w{S H D C}

# Loops thorugh suit, then rank to create 52 cards
suit.each do |s|
    rank.each do |r|
      deck.push(s+r)
    end
end

# Shows the deck of cards to screen
puts "Initial deck of playing cards: " + deck.inspect + "\n" + "\n"

# Converts index of cards to hash with integers from 0 - 51
deck_of_playing_cards = Hash[deck.map.with_index.to_a] 

# Checks that it's returning correct index value and integer / fixnum
#puts deck_of_playing_cards['S5']  #=> 3
#puts deck_of_playing_cards['S5'].class #=> Fixnum

# Shuffles deck of cards and shows to screen
deck.shuffle!
puts "Shuffled deck of playing cards: " + deck.inspect  + "\n" + "\n"

# Checks that the first shuffled card output matches the correct hash value
# puts deck[0]
# puts deck_of_playing_cards[(deck[0])]

# Deals cards to each player
player1_hand = Array.new([])
player2_hand = Array.new([])
deck.each do |card|
    player1_hand.push(deck.pop)
    player2_hand.push(deck.pop)
end

# Shows cards of each player
puts "Player 1 cards: " + player1_hand.inspect 
puts "Player 2 cards: " + player2_hand.inspect

# Shows Player 1 first card and numeric value attached
puts "Player 1 first card: " + player1_hand[0]
puts deck_of_playing_cards[player1_hand[0]]





