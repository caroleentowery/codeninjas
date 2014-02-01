#Game of War

# Clears the screen when you start.
puts "\e[H\e[2J"

#Ask for players names, capitalizes them, and says welcome
print "Enter name for player 1: "
name1 = gets.chomp.capitalize!()
print "Enter name for player 2: "
name2 = gets.chomp.capitalize!()
puts "\n" + "Welcome #{name1} and #{name2} to the Game of War." + "\n" + "\n"

# Makes new array called card that makes arrays with rank and suit
$deck = Array.new([]) # "$" makes deck array global
rank = %w{2 3 4 5 6 7 8 9 10 J Q K A}
suit = %w{S H D C}
# Loops thorugh suit, then rank to create 52 cards with rank and suit
suit.each do |s|
    rank.each do |r|
      $deck.push(r+s) # Makes card showing rank and suit
    end
end

# Makes deck array wiht index numbers 0 - 51 and shuffles deck 
card_values = Array.new(52) {|i| i}
card_values.shuffle!

# Initial dealing of shuffled card_value array (0 - 51), 26 for each player
hand1 = []
hand2 = []

26.times do
    hand1.push(card_values.pop)
    hand2.push(card_values.pop)
end

# Method to return card face (ex: 2S) by card index
def show_card(card_index) 
  return $deck[card_index]
end

# Method to wait for the spacebar key to be pressed
require 'io/console'
def wait_for_spacebar
   puts "Push spacebar for next skirmish."
   sleep 1 while $stdin.getch != " "
   puts "\e[H\e[2J" # Clears screen
end

# Method for showing player hand, spoils, and discard pile
discard_pile1 = []
discard_pile2 = []




# Combines and shuffles hand and discard piles when less than bounty count
def rehand(hand, discard_pile, bounty_count) 
    if hand.count < bounty_count
        hand = (hand + discard_pile).shuffle!
        #puts "Hand and discard pile were combined and reshuffled: " + hand.inspect
    end
    return hand
end


# Method to show each player's hand, discard, and spoils count
def show_info(name1,name2,hand1,hand2,discard1,discard2,spoils1,spoils2)
    puts name1.to_s + ":  Hand count = " + hand1.count.to_s + " Discard count = " + discard1.count.to_s + " Spoils count = " + spoils1.count.to_s
    puts name2.to_s + ":  Hand count = " + hand2.count.to_s + " Discard count = " + discard2.count.to_s + " Spoils count = " + spoils2.count.to_s
end

spoils1 = []
spoils2 = []
discard1 = Array.new
discard2 = Array.new
 
def skirmish(name1,name2,hand1,hand2,discard1,discard2,spoils1,spoils2)
    # Deals each player one card
    playing_card1 = hand1.shift
    puts name1.to_s + " plays " + show_card(playing_card1).to_s + "\n" 
    playing_card2 = hand2.shift
    puts name2.to_s + " plays " + show_card(playing_card2).to_s + "\n" + "\n"
    
    if playing_card1 %13 > playing_card2 %13 # Mod 13 for card value, Player 1 wins
         puts name1.to_s + " wins this skirmish. \n\n" # Outputs winner name
         spoils1.push(playing_card1, playing_card2) + spoils2 # Added spoils2 in case there were spoils from previous battle
         discard1 = discard1 + spoils1
         spoils2.clear
         show_info(name1,name2,hand1,hand2,discard1,discard2,spoils1,spoils2)
         spoils1.clear # Empties spoils aftera a winner
    elsif playing_card1 %13 < playing_card2 %13 # Player 2 wins
         puts name2.to_s + " wins this skirmish. \n\n" # Outputs winner name
         spoils2.push(playing_card1, playing_card2) + spoils1
         discard2 = discard2 + spoils2
         spoils1.clear; 
         show_info(name1,name2,hand1,hand2,discard1,discard2,spoils1,spoils2) 
         spoils2.clear # Empties spoils aftera a winner
    else playing_card1 %13 == playing_card2 %13 # Tie condition
      puts name1.to_s + " and " + name2.to_s + " are going to battle! \n\n" # Outputs it's a battle
      # Sets bounty count
      if hand1.count + discard1.count > 4 && hand2.count + discard2.count > 4 # Sets to 3 if minimum of 4 cards
          bounty_count = 3 # Subtract 1 for the card to be played
          puts "Bounty count is " + bounty_count.to_s
      else # Sets bounty count as sum of hand and discard pile minus one for player with least cards
          bounty_count = [hand1.count + discard1.count, hand2.count + discard2.count].min - 1
          puts "Bounty count is " + bounty_count.to_s
      end
      if hand1.count < bounty_count 
         hand1 = (hand1 + discard1).shuffle!
      end
      if hand2.count < bounty_count
         hand2 = (hand2 + discard2).shuffle!
      end    

      bounty_count.times do |n|
          spoils1.push(hand1.shift)
          spoils2.push(hand2.shift)
      end
      puts "spoils 1 = " + spoils1.inspect
      puts "spoils 2 = " + spoils2.inspect
      show_info(name1,name2,hand1,hand2,discard1,discard2,spoils1,spoils2)
    end
end

until (hand1 + discard1).empty? or (hand2 + discard2).empty?
    wait_for_spacebar
    skirmish(name1,name2,hand1,hand2,discard1,discard2,spoils1,spoils2)
end
  
# After one hand empties out, announces the winner   
if (hand1 + discard_pile1).empty? == true
  puts name2 + " is the winner!"
else
  puts name1 = " is the winner!"
end
   
=begin

# Loop runs until one player runs out of cards
until (hand1 + discard_pile1).empty? or (hand2 + discard_pile2).empty?
  
    wait_for_spacebar

    # Creates and shows each players' spoils
    playing_card1 = hand1.shift
    puts name1.to_s + "'s" + " spoils: " + playing_card1.to_s + "\n" 
    playing_card2 = hand2.shift
    puts name2.to_s + "'s" + " spoils: " + playing_card2.to_s + "\n" + "\n"
  
  
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
        #hand1 = rehand(hand1, discard_pile1, bounty_count)
        #hand2 = rehand(hand2, discard_pile2, bounty_count)   
        
        bounty1 = [] # Defines bounty for battle
        bounty2 = []
        (bounty_count).times do # Adds cards to bounty based on bounty_count
            bounty1.push(hand1.shift)  
            bounty2.push(hand2.shift)
        end
        
        # Battle card is card played after adding bounty
        #battle_card1 = []
        #battle_card2 = []
        #battle_card1 = hand1.shift
        #battle_card2 = hand2.shift
       
        # Outputs card played, bounty, and spoils
        puts name1.to_s + " played " + battle_card1.inspect + " with bounty " + bounty1.inspect +  " to create spoils " + (spoils1 =               bounty1.push(battle_card1).inspect)
        puts name2.to_s + " played " + battle_card2.inspect + " with bounty " + bounty2.inspect +  " to creates spoils " + (spoils2 = bounty2.push(battle_card2).inspect)
        
# Need to add way to check who wins this battle.  Should I re-write all that same code again?
# Need to handle how to do another battle if needed
# Need to add how to rehand if needed here

# Caroleen
#
# What you want to do here is leverage methods.  By putting the 'skirmish' portion of this loop in a method
# including the part of it that determines the winner, you will be able to call that skirmish method at the end
# of a battle.
#
# So, it would look like this:
# 
# Skirmish Method (Called within the overall game loop)
#     Inside skirmish method the following happens
#        Deal a card from each player
#        Determine the outcome (one of three outcomes)
#            Outcome 1 - Player 1 wins, give player 1 the spoils
#            Outcome 2 - Player 2 wins, give player 2 the spoils
#            Outcome 3 - Battle, call a method that runs the battle (see below)
# End Skirmish Method
#
# Battle Method (Called with skirmish method has outcome 3
#     Inside battle method the following happens
#         Deal three cards from each player
#         Call Skirmish Method
# End Battle Method
#
# See how the methods call each other?
#
# You will also want to look into using methods from some of the other checks you make,
# such as determining the skirmish outcome and determining if a player has won.
# 
# Great job so far, keep it up.
#
# Keith

    end
end 

=end
