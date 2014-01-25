#Game of War

# Clears the screen when you start.
puts "\e[H\e[2J"

#Ask for players names, capitalizes them, and says welcome
print "Enter name for player 1: "
player1_name = gets.chomp.capitalize!()
print "Enter name for player 2: "
player2_name = gets.chomp.capitalize!()
puts "\n" + "Welcome #{player1_name} and #{player2_name} to the Game of War." + "\n" + "\n"

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
#puts "Initial deck of playing cards: " + deck.inspect + "\n" + "\n"

# Converts index of cards to hash with integers from 0 - 51
deck_of_playing_cards = Hash[deck.map.with_index.to_a] 

# Checks that it's returning correct index value and integer / fixnum
#puts deck_of_playing_cards['S5']  #=> 3
#puts deck_of_playing_cards['S5'].class #=> Fixnum

# Shuffles deck of cards and shows to screen
deck.shuffle!
#puts "Shuffled deck of playing cards: " + deck.inspect  + "\n" + "\n"

# Checks that the first shuffled card output matches the correct hash value
# puts deck[0]
# puts deck_of_playing_cards[(deck[0])]

# Deals cards to each player
player1_hand = []
player2_hand = []

26.times do
    player1_hand.push(deck.pop)
    player2_hand.push(deck.pop)
end

#puts "Deck after dealing is: " + deck.inspect + "\n" + "\n"

# Wait for the spacebar key to be pressed
require 'io/console'
def wait_for_spacebar
   puts "\n" + "Push spacebar for skirmish."
   sleep 1 while $stdin.getch != " "
end

player1_discard_pile = []
player2_discard_pile = []
player1_spoils = []
player2_spoils = []

def show_player_info(player_name, hand, spoils, discard_pile)
    puts player_name.to_s + " hand: " + hand.inspect
    puts player_name.to_s + " spoils: " + spoils.to_s + "\n" 
    puts player_name.to_s + " discard pile: " + discard_pile.to_s + "\n" + "\n"
end

show_player_info(player1_name, player1_hand, player1_spoils, player1_discard_pile)
show_player_info(player2_name, player2_hand, player2_spoils, player2_discard_pile)

until (player1_hand + player1_discard_pile).empty? or (player2_hand + player2_discard_pile).empty?
  
    wait_for_spacebar
    
    player1_spoils = player1_hand.shift
    player2_spoils = player2_hand.shift
    
    show_player_info(player1_name, player1_hand, player1_spoils, player1_discard_pile)
    show_player_info(player2_name, player2_hand, player2_spoils, player2_discard_pile)
    
    # Shows players' card number
    #puts "Card number is " + deck_of_playing_cards[player1_hand[0]].to_s
    
    # Makes player skirmish
    #player1_skirmish = deck_of_playing_cards[player1_hand[0]] %13
    
    # Shows mod value
    #puts "Card value (mod) is " + player1_skirmish.to_s + "\n" + "\n"
    
    #puts "Card number is " + deck_of_playing_cards[player2_hand[0]].to_s
    #player2_skirmish = deck_of_playing_cards[player2_hand[0]] %13
    #puts "Card value (mod) is " + player2_skirmish.to_s + "\n" + "\n"
    
    # First skirmish and outputs winner
      
    if deck_of_playing_cards[player1_spoils] %13 > deck_of_playing_cards[player2_spoils] %13
        puts player1_name.to_s + " wins this skirmish." + "\n"
        player1_discard_pile.push(player1_spoils, player2_spoils)
        #puts player1_name.to_s + " hand after skirmish: " + player1_hand.inspect
        #puts player1_name.to_s + " discard pile: " + player1_discard_pile.to_s  
        show_player_info(player1_name, player1_hand, player1_spoils, player1_discard_pile)
        show_player_info(player2_name, player2_hand, player2_spoils, player2_discard_pile) 
        
    elsif deck_of_playing_cards[player2_spoils] %13 > deck_of_playing_cards[player1_spoils] %13
        puts player2_name.to_s + " wins this skirmish." + "\n"
        player2_discard_pile.push(player1_spoils, player2_spoils)
        #puts player2_name.to_s + " hand after skirmish: " + player2_hand.inspect
        #puts player2_name.to_s + " discard pile: " + player2_discard_pile.to_s 
        show_player_info(player1_name, player1_hand, player1_spoils, player1_discard_pile)
        show_player_info(player2_name, player2_hand, player2_spoils, player2_discard_pile) 
    else
        puts "This skirmish is a tie so it's time for a battle!"
    end
 
end 









