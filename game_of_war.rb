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
   puts "\nPush spacebar for skirmish."
   sleep 1 while $stdin.getch != " "
   puts "\e[H\e[2J" # Clears screen
end

# Method to show each player's hand, discard, and spoils count
def show_info(name1,name2,hand1,hand2,discard1,discard2,spoils1,spoils2)
    puts "#{name1}:  Hand count = #{hand1.count}  Discard count = #{discard1.count}  Spoils count = #{spoils1.count}"
    puts "#{name2}:  Hand count = #{hand2.count}  Discard count = #{discard2.count}  Spoils count = #{spoils2.count} \n\n"
end

spoils1 = []
spoils2 = []
discard1 = []
discard2 = []

def skirmish(name1,name2,hand1,hand2,discard1,discard2,spoils1,spoils2)
    # Deals each player one card
    playing_card1 = hand1.shift # Takes first card from hand
    puts "#{name1} plays " + show_card(playing_card1).to_s + "\n" 
    playing_card2 = hand2.shift
    puts "#{name2} plays " + show_card(playing_card2).to_s + "\n" + "\n"
    
    if playing_card1 %13 > playing_card2 %13 # Mod 13 for card value, Player 1 wins
        puts "#{name1} wins this skirmish. \n\n" # Outputs winner name
        spoils1.push(playing_card1,playing_card2).concat(spoils2) # Push adds the cards played, concat add spoils2 array if leftover from a battle
        discard1.concat(spoils1) # Add spoils1 to current discard pile, this also works:  discard1 += spoils1
        spoils2.clear # Empties loser's spoil count since it was added to winner's spoil count
        show_info(name1,name2,hand1,hand2,discard1,discard2,spoils1,spoils2) # Shows info here before emptying winner's spoils count
        spoils1.clear # Empties winner's spoils count too

    elsif playing_card1 %13 < playing_card2 %13 # Player 2 wins
        puts name2.to_s + " wins this skirmish. \n\n" # Outputs winner name
        spoils2.push(playing_card1, playing_card2).concat(spoils1)
        discard2.concat(spoils2)
        spoils1.clear 
        show_info(name1,name2,hand1,hand2,discard1,discard2,spoils1,spoils2) 
        spoils2.clear
        
    elsif playing_card1 %13 == playing_card2 %13 # Tie condition
        puts "#{name1} and #{name2} are going to battle! \n\n" # Outputs names and it's a battle
        puts "Before battle:"
        show_info(name1,name2,hand1,hand2,discard1,discard2,spoils1,spoils2)
        
        # Sets bounty count
        if hand1.count + discard1.count > 4 && hand2.count + discard2.count > 4 # Sets to 3 if minimum of 4 cards
            bounty_count = 3 # Subtract 1 for the card to be played
            #puts "Bounty count is #{bounty_count}"
        else # Sets bounty count as sum of hand and discard pile minus one for player with least cards
            bounty_count = [hand1.count + discard1.count, hand2.count + discard2.count].min - 1
            #puts "Bounty count is #{bounty_count}"
        end
        
        if hand1.count < bounty_count 
           hand1.concat(discard1).shuffle!
           puts "#{name1} reshuffled hand and discard piles for battle."
           discard1.clear
        end
        
        if hand2.count < bounty_count
           hand2.concat(discard2).shuffle!
           puts "#{name2} reshuffled hand and discard piles for battle."
           discard2.clear
        end   
        
        # Adds current playing card to each player's spoils
        spoils1.push(playing_card1)
        spoils2.push(playing_card2)
        
        bounty_count.times do |n|
            spoils1.push(hand1.shift)
            spoils2.push(hand2.shift)
        end 
        puts "\nAfter battle:"
        show_info(name1,name2,hand1,hand2,discard1,discard2,spoils1,spoils2)
        end
end

show_info(name1,name2,hand1,hand2,discard1,discard2,spoils1,spoils2) 

until (hand1 + discard1).empty? or (hand2 + discard2).empty?
    wait_for_spacebar
    skirmish(name1,name2,hand1,hand2,discard1,discard2,spoils1,spoils2)
    
        if hand1.empty? && !discard1.empty?# Checks if hand ran out, reshuffles discard as long as it's not empty
           hand1.concat(discard1).shuffle!
           discard1.clear # Empties discard pile since it was added back into hand
           puts "#{name1} reshuffled discard pile."
           #show_info(name1,name2,hand1,hand2,discard1,discard2,spoils1,spoils2)
        end
        
        if hand2.empty? && !discard2.empty?
           hand2.concat(discard2).shuffle!
           discard2.clear
           puts "#{name2} reshuffled discard pile."
           #show_info(name1,name2,hand1,hand2,discard1,discard2,spoils1,spoils2)
        end
end

# Determines and outputs winner
if (hand1 + discard1).empty?
    puts "#{name2} is the winner because #{name1} ran out of cards."
elsif (hand2 + discard2).empty?
    puts "#{name1} is the winner because #{name2} ran out of cards."
end
   

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

