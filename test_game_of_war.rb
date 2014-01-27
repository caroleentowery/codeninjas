hand1 = [1,2]
discard_pile1 = [5]     
     
hand2 = [7]
discard_pile2 = [8, 9]     
   def shuffle_hand(hand, discard_pile, bounty_count) 
              if hand.count < bounty_count
              hand = hand + discard_pile
              hand.shuffle!
              puts hand.inspect
              end
            end
     
        if hand1.count + discard_pile1.count > 4 && hand2.count + discard_pile2.count > 4 
          bounty_count = 4
            shuffle_hand(hand1, discard_pile1, bounty_count)
            shuffle_hand(hand2, discard_pile2, bounty_count)
        else
            # Sets bounty count as sum of hand and discard pile for player with least cards
            bounty_count = [hand1.count + discard_pile1.count, hand2.count + discard_pile2.count].min 
            puts bounty_count.to_s
            shuffle_hand(hand1, discard_pile1, bounty_count)
            shuffle_hand(hand2, discard_pile2, bounty_count)
        end
       
 # Checks if hand < bounty_count
 

