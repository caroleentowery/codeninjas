#Game of War

#Ask for players names, capitalizes them, and says welcome
print "Enter name for player 1: "
player_name1 = gets.chomp.capitalize()
print "Enter name for player 2: "
player_name2 = gets.chomp.capitalize!()
puts "Welcome #{player_name1} and #{player_name2} to the Game of War."

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
puts deck.inspect

# Converts index of cards to hash with integers from 0 - 51
deck_of_playing_cards = Hash[deck.map.with_index.to_a] 

# Checks that it's returning correct index value and integer / fixnum
#puts deck_of_playing_cards['S5']  #=> 3
#puts deck_of_playing_cards['S5'].class #=> Fixnum

