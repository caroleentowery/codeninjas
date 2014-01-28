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
      deck.push(r+s) # Makes card showing rank and suit
    end
end

# Converts index of cards to hash with integers from 0 - 51
deck_of_playing_cards = Hash[deck.map.with_index.to_a] 

# Shuffles deck of cards and shows to screen
deck.shuffle!

# Initial dealing of cards, 26 for each player
hand1 = []
hand2 = []

26.times do
    hand1.push(deck.pop)
    hand2.push(deck.pop)
end

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
def rehand(hand, discard_pile, bounty_count) 
    if hand.count < bounty_count
        hand = (hand + discard_pile).shuffle!
        #puts "Hand and discard pile were combined and reshuffled: " + hand.inspect
    end
    return hand
end

# Shows initial hand and discard pile for each player at game start
show_player_info(name1, hand1, discard_pile1)
show_player_info(name2, hand2, discard_pile2)

# Loop runs until one player runs out of cards
until (hand1 + discard_pile1).empty? or (hand2 + discard_pile2).empty?
  
    wait_for_spacebar

    # Creates and shows each players' spoils
    spoils1 = hand1.shift
    puts name1.to_s + "'s" + " spoils: " + spoils1.to_s + "\n" 
    spoils2 = hand2.shift
    puts name2.to_s + "'s" + " spoils: " + spoils2.to_s + "\n" + "\n"
  
    if deck_of_playing_cards[spoils1] %13 > deck_of_playing_cards[spoils2] %13 # Player 1 wins
        discard_pile1.push(spoils1, spoils2) # Adds both spoils to winner's hand
        puts "* * * " + name1.to_s + " wins this skirmish and takes the spoils " + spoils1 + ", " + spoils2 + " * * *\n\n" # Outputs winner name
        show_player_info(name1, hand1, discard_pile1) # Shows winner's info
        show_player_info(name2, hand2, discard_pile2) 
        
    elsif deck_of_playing_cards[spoils2] %13 > deck_of_playing_cards[spoils1] %13 # Player 2 wins
        discard_pile2.push(spoils1, spoils2)
        puts "* * * " + name2.to_s + " wins this skirmish and takes the spoils " + spoils1 + ", " + spoils2 + " * * *\n\n" # Outputs winner name
        show_player_info(name2, hand2, discard_pile2) 
        show_player_info(name1, hand1, discard_pile1)
        
    else # Tie condition
        puts "* * * " + name1.to_s + " and " + name2.to_s + " are going to battle! * * *\n\n" # Outputs it's a battle
        show_player_info(name1, hand1, discard_pile1)
        show_player_info(name2, hand2, discard_pile2) 

        # Sets bounty count
        if hand1.count + discard_pile1.count > 4 && hand2.count + discard_pile2.count > 4 # Sets to 3 if minimum of 4 cards
            bounty_count = 3 # Subtract 1 for the card to be played
            puts "Bounty count is " + bounty_count.to_s
        else # Sets bounty count as sum of hand and discard pile minus one for player with least cards
            bounty_count = [hand1.count + discard_pile1.count, hand2.count + discard_pile2.count].min - 1
            puts "Bounty count is " + bounty_count.to_s
        end
        
        # Rehand if needed
        hand1 = rehand(hand1, discard_pile1, bounty_count)
        hand2 = rehand(hand2, discard_pile2, bounty_count)   
        
        bounty1 = [] # Defines bounty for battle
        bounty2 = []
        (bounty_count).times do # Adds cards to bounty based on bounty_count
            bounty1.push(hand1.shift)  
            bounty2.push(hand2.shift)
        end
        
        # Battle card is card played after adding bounty
        battle_card1 = []
        battle_card2 = []
        battle_card1 = hand1.shift
        battle_card2 = hand2.shift
       
        # Outputs card played, bounty, and spoils
        puts name1.to_s + " played " + battle_card1.inspect + " with bounty " + bounty1.inspect +  " to create spoils " + (spoils1 =               bounty1.push(battle_card1).inspect)
        puts name2.to_s + " played " + battle_card2.inspect + " with bounty " + bounty2.inspect +  " to creates spoils " + (spoils2 = bounty2.push(battle_card2).inspect)
        
# Need to add way to check who wins this battle.  Should I re-write all that same code again?
# Need to handle how to do another battle if needed
# Need to add how to rehand if needed here

    end
end 






