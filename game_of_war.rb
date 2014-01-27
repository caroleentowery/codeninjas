#Game of War

# Clears the screen when you start.
puts "\e[H\e[2J"

#Ask for players names, capitalizes them, and says welcome
print "Enter name for player 1: "
name1 = gets.chomp.capitalize!()
print "Enter name for player 2: "
name2 = gets.chomp.capitalize!()
puts "\n" + "Welcome #{name1} and #{name2} to the Game of War." + "\n" + "\n"

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

# Initial dealing of cards, 26 for each player
hand1 = []
hand2 = []

26.times do
    hand1.push(deck.pop)
    hand2.push(deck.pop)
end

#puts "Deck after dealing is: " + deck.inspect + "\n" + "\n"

# Wait for the spacebar key to be pressed
require 'io/console'
def wait_for_spacebar
   puts "Push spacebar for next skirmish."
   sleep 1 while $stdin.getch != " "
   puts "\e[H\e[2J" # Clears screen
end

# Method for showing player hand, spoils, and discard pile
discard_pile1 = []
discard_pile2 = []
spoils1 = []
spoils2 = []

def show_player_info(name, hand, discard_pile)
    puts name.to_s + "'s hand: " + hand.inspect
    #puts name.to_s + " spoils: " + spoils.to_s + "\n" 
    puts name.to_s + "'s discard pile: " + discard_pile.to_s + "\n" + "\n"
end

# Combines and shuffles hand and discard piles when less than bounty count
def shuffle_hand(hand, discard_pile, bounty_count) 
    if hand.count < bounty_count
    hand = hand + discard_pile
    hand.shuffle!
    puts "Hand and discard pile were combined and reshuffled: " + hand.inspect
    end
end



# Shows initial hand and discard pile for each player at game start
show_player_info(name1, hand1, discard_pile1)
show_player_info(name2, hand2, discard_pile2)

# Loop runs until one player runs out of cards
until (hand1 + discard_pile1).empty? or (hand2 + discard_pile2).empty?
  
    wait_for_spacebar
    
    # Shows each players hand, spoils, and discard pile
    #show_player_info(name1, hand1, spoils1, discard_pile1)
    #show_player_info(name2, hand2, spoils2, discard_pile2)
    
    # Shows players' card number
    #puts "Card number is " + deck_of_playing_cards[hand1[0]].to_s
    
    # Makes player skirmish
    #player1_skirmish = deck_of_playing_cards[hand1[0]] %13
    
    # Shows mod value
    #puts "Card value (mod) is " + player1_skirmish.to_s + "\n" + "\n"
    
    #puts "Card number is " + deck_of_playing_cards[hand2[0]].to_s
    #player2_skirmish = deck_of_playing_cards[hand2[0]] %13
    #puts "Card value (mod) is " + player2_skirmish.to_s + "\n" + "\n"
    
    # Skirmish and outputs winner 
    
    # Creates and shows each players' spoils
    spoils1 = hand1.shift
    puts name1.to_s + "'s" + " spoils: " + spoils1.to_s + "\n" 
    spoils2 = hand2.shift
    puts name2.to_s + "'s" + " spoils: " + spoils2.to_s + "\n" + "\n"
  
    if deck_of_playing_cards[spoils1] %13 > deck_of_playing_cards[spoils2] %13 # Player 1 wins
        discard_pile1.push(spoils1, spoils2) # Adds both spoils to winner's hand
        puts "* * * " + name1.to_s + " wins this skirmish. * * *\n\n" # Outputs winner name
        show_player_info(name1, hand1, discard_pile1) # Shows winner's info
        show_player_info(name2, hand2, discard_pile2) 
        
    elsif deck_of_playing_cards[spoils2] %13 > deck_of_playing_cards[spoils1] %13 # Player 2 wins
        discard_pile2.push(spoils1, spoils2)
        puts "* * * " + name2.to_s + " wins this skirmish. * * *\n\n" # Outputs winner name
        show_player_info(name2, hand2, discard_pile2) 
        show_player_info(name1, hand1, discard_pile1)
        
    else # Tie condition
        puts "* * * " + name1.to_s + " and " + name2.to_s + "are going to battle! * * *\n\n" # Outputs it's a battle
        show_player_info(name1, hand1, discard_pile1)
        show_player_info(name2, hand2, discard_pile2) 

        # Sets bounty count = 4 if both players have at least 4 cards between hand and discard pile
        if hand1.count + discard_pile1.count > 4 && hand2.count + discard_pile2.count > 4 
            bounty_count = 4
        else
            # Sets bounty count as sum of hand and discard pile for player with least cards
            bounty_count = [hand1.count + discard_pile1.count, hand2.count + discard_pile2.count].min 
        end
        
        # Combines and shuffles if hand and discard < bounty count
        shuffle_hand(hand1, discard_pile1, bounty_count)
        shuffle_hand(hand2, discard_pile2, bounty_count)   
        puts bounty_count
    end
 
 
end 






