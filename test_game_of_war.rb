hand1 = [1,2,3,4,5,6,7]
discard_pile1 = [8]     
spoils1 = [9,10,11,12]  
  
     
hand2 = [20,21,22, 23, 24]
discard_pile2 = [21,22, 23, 24]  
spoils2 = [25,26,27,28,29]

a1 = [1,2]
a2 = [3,4]

a1.concat(a2)
puts a1.inspect
puts a2.inspect

a1 = [1,2]
a2 = [3,4]

a1.push(a2)
puts a1.inspect
puts a2.inspect

a1 = [1,2]
a2 = [3,4]

a1 << a2
puts a1.inspect
puts a2.inspect

a1 = [1,2]
a2 = [3,4]




=begin
bounty_count = 3


spoils1.clear
spoils2.clear

      bounty_count.times do |n|
          spoils1.push(hand1.shift)
          spoils2.push(hand2.shift)
      end
      puts "spoils 1 = " + spoils1.inspect
      puts "spoils 2 = " + spoils2.inspect
      
playing_card1 = 3
playing_card2 = 4
      
      
spoils1.push(playing_card1,playing_card2).concat(spoils2) 
puts spoils1.inspect
#spoils1 += spoils2
      
puts spoils1.inspect
      
=begin

#combined = hand1 + hand2   
#puts combined.inspect

# Combines and shuffles hand and discard piles when less than bounty count
def rehand(hand, discard_pile, bounty_count) 
    if hand.count < bounty_count
    hand = (hand + discard_pile).shuffle!
    end
    return hand
end
     
        if hand1.count + discard_pile1.count > 4 && hand2.count + discard_pile2.count > 4 
          bounty_count = 3
            puts "Bounty count is " + bounty_count.to_s
        else
            # Sets bounty count as sum of hand and discard pile for player with least cards
            bounty_count = [hand1.count + discard_pile1.count, hand2.count + discard_pile2.count].min - 1 
            puts "Bounty count is " + bounty_count.to_s
        end
          
hand1 = rehand(hand1, discard_pile1, bounty_count)
hand2 = rehand(hand2, discard_pile2, bounty_count)
       
       bounty1 = []
       bounty2 = []
        
        puts "Hand 1 " + hand1.inspect
        puts "Hand 2 " + hand2.inspect
        
         bounty_count.times do
            bounty1.push(hand1.shift) 
            bounty2.push(hand2.shift) 
          end
          
          
        
        battle_card1 = []
        battle_card2 = []
        battle_card1 = hand1.shift
        battle_card2 = hand2.shift
        puts "battle card 1: " + battle_card1.to_s
        puts "battle card 2: " + battle_card2.to_s

        temp_bounty1 = bounty1
        temp_bounty2 = bounty2
        puts "bounty 1: " + temp_bounty1.inspect
        puts "bounty 2: " + temp_bounty2.inspect
        
        spoils1 = bounty1.push(battle_card1)
        spoils2 = bounty2.push(battle_card2)        
        puts "1 played " + battle_card1.to_s + " and bounty is " + temp_bounty1.inspect + " with spoils " + spoils1.inspect
        puts "2 played " + battle_card2.to_s + " and bounty is " + temp_bounty2.inspect + " with spoils " + spoils2.inspect + "\n" + "\n"
 
       
 # Checks if hand < bounty_count
 
=end
 

