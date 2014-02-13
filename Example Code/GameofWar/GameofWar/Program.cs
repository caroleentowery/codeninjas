using System;
using System.Collections.Generic;
using System.Globalization;

namespace GameofWar
{
    class Program
    {
        #region Variables // Use #region to start code folding
        
        static string player1Name;
        static string player2Name;
        static TextInfo textInfo;

        static List<int> deck;

        static List<int> player1Hand = new List<int>();
        static List<int> player1Spoils = new List<int>();
        static List<int> player1Discard = new List<int>(0);

        static List<int> player2Hand = new List<int>();
        static List<int> player2Spoils = new List<int>();
        static List<int> player2Discard = new List<int>(0);


        static List<string> deckWithFaces;

        static int bountyCount;
        
        #endregion

        static void Main()
        {
            // Initial setup of play session
            Initialization();
            GetPlayerNames();
            GetDeck();
            ShuffleDeck(deck);
            deckWithFaces = BuildDeckWithDisplayValues();
            
            // Set up for single game
            DealCards();

            // Play actual game
            // Keeps playing while both players still have cards
            while ((Convert.ToInt32(player1Hand.Count) + Convert.ToInt32(player1Discard.Count)) != 0 && (Convert.ToInt32(player2Hand.Count) + Convert.ToInt32(player2Discard.Count)) != 0)
            {
                Pause();
                Skirmish();

                // Checks if hand is empty but discard still has cards, if so, then combines and reshuffles 
                if (Convert.ToInt32(player1Hand.Count) == 0 && Convert.ToInt32(player1Discard.Count) != 0)
                {
                    player1Hand.AddRange(player1Discard); // Combines hand and discard pile
                    player1Discard.Clear(); // Empties discard pile
                    ShuffleDeck(player1Hand); // Shuffles combined hand and discard pile
                    Console.WriteLine("\n\n" + player1Name + "'s hand and discard pile will be combined and reshuffled.");
                }

                if (Convert.ToInt32(player2Hand.Count) == 0 && Convert.ToInt32(player2Discard.Count) != 0)
                {
                    player2Hand.AddRange(player2Discard); // Combines hand and discard pile
                    player2Discard.Clear(); // Empties discard pile
                    ShuffleDeck(player2Hand); // Shuffles combined hand and discard pile
                    Console.WriteLine("\n\n" + player2Name + "'s hand and discard pile will be combined and reshuffled.");
                }
            }

            // Writes winner's name when one player runs out of cards
            if (Convert.ToInt32(player1Hand.Count) + Convert.ToInt32(player1Discard.Count) == 0) 
            {
                Console.WriteLine("\n\n" + player2Name + " is the winner because " + player1Name + " ran out of cards.");
            }

            if (Convert.ToInt32(player2Hand.Count) + Convert.ToInt32(player2Discard.Count) == 0)
            {
                Console.WriteLine("\n\n" + player1Name + " is the winner because " + player2Name + " ran out of cards.");
            }

            Pause();

        }

        private static void Skirmish()
        {
            Console.Clear();

            // Takes first card from each player and makes it the player card
            int player1Card = player1Hand[0];
            player1Hand.RemoveAt(0);
            int player2Card = player2Hand[0];
            player2Hand.RemoveAt(0);
            Console.WriteLine(player1Name + " plays " + deckWithFaces[player1Card] + " and " + player2Name + " plays " + deckWithFaces[player2Card] + "\n\n");
            // Adds player card to spoils
            player1Spoils.Add(player1Card);
            player2Spoils.Add(player2Card);

            // Shows player info before playing
            Console.WriteLine(player1Name + ":  Hand count: " + player1Hand.Count + " Discard count: " + player1Discard.Count + " Spoils: " + player1Spoils.Count);
            Console.WriteLine(player2Name + ":  Hand count: " + player2Hand.Count + " Discard count: " + player2Discard.Count + " Spoils: " + player2Spoils.Count + "\n");

            if (player1Card % 13 > player2Card % 13) // Player 1 wins
            {
                player1Spoils.AddRange(player2Spoils); // Adds player 2 spoils to player 1 spoils
                player2Spoils.Clear(); // Clears player 2 spoils                
                Console.WriteLine(player1Name + " wins this skirmish and get spoils: " + player1Spoils.Count + ".\n\n");
                player1Discard.AddRange(player1Spoils); // Addds total spoils to player 1 discard

                Console.WriteLine(player1Name + ":  Hand count: " + player1Hand.Count + " Discard count: " + player1Discard.Count + " Score: " + (Convert.ToInt32(player1Hand.Count) + Convert.ToInt32(player1Discard.Count)));
                Console.WriteLine(player2Name + ":  Hand count: " + player2Hand.Count + " Discard count: " + player2Discard.Count + " Score: " + (Convert.ToInt32(player2Hand.Count) + Convert.ToInt32(player2Discard.Count)));
                player1Spoils.Clear(); // Clears player 1 spoils for next skirmish
            }

            else if (player1Card % 13 < player2Card % 13) // Player 2 wins
            {
                player2Spoils.AddRange(player1Spoils); // Adds player 1 spoils to player 2 spoils
                player1Spoils.Clear(); // Clears player 1 spoils
                Console.WriteLine(player2Name + " wins this skirmish and get spoils: " + player2Spoils.Count + ".\n\n");
                player2Discard.AddRange(player2Spoils); // Addds total spoils to player 2 discard

                Console.WriteLine(player1Name + ":  Hand count: " + player1Hand.Count + " Discard count: " + player1Discard.Count + " Score: " + (Convert.ToInt32(player1Hand.Count) + Convert.ToInt32(player1Discard.Count)));
                Console.WriteLine(player2Name + ":  Hand count: " + player2Hand.Count + " Discard count: " + player2Discard.Count + " Score: " + (Convert.ToInt32(player2Hand.Count) + Convert.ToInt32(player2Discard.Count)));
                player2Spoils.Clear();
            }

            else if (player1Card % 13 == player2Card % 13) // Players tie, could use just else without condition
            {
                // Sets bounty count
                if ((Convert.ToInt32(player1Hand.Count) + Convert.ToInt32(player1Discard.Count) > 4) && (Convert.ToInt32(player2Hand.Count) + Convert.ToInt32(player2Discard.Count) > 4))
                {
                    bountyCount = 3; // Sets 3 if have minimum of 4 cards, subtracted 1 for playing card
                }
                else // Sets bounty count as sum of hand and discard pile minus one for player with least cards
                {
                    bountyCount = Math.Min((Convert.ToInt32(player1Hand.Count) + Convert.ToInt32(player1Discard.Count)), (Convert.ToInt32(player2Hand.Count) + Convert.ToInt32(player2Discard.Count))) - 1;
                }

                // Checks each player's hand to see if need to combine hand and discard then reshuffle
                if (player1Hand.Count < bountyCount)
                {
                    player1Hand.AddRange(player1Discard); // Combines hand and discard pile
                    player1Discard.Clear(); // Empties discard pile
                    ShuffleDeck(player1Hand); // Shuffles combined hand and discard pile
                    Console.WriteLine("\n\n" + player1Name + "'s hand and discard pile will be combined and reshuffled to complete the battle." + "\n\n");
                }
                if (player2Hand.Count < bountyCount)
                {
                    player2Hand.AddRange(player2Discard);
                    player2Discard.Clear();
                    ShuffleDeck(player2Hand);
                    Console.WriteLine("\n\n" + player2Name + "'s hand and discard pile will be combined and reshuffled to complete the battle." + "\n\n");
                }

                Console.WriteLine(player1Name + " and " + player2Name + " are going to battle with bounty count: " + bountyCount + "\n\n");

                // Adds player cards to spoils up to bounty count
                for (int i = 0; i < bountyCount; i++)
                {
                    player1Card = player1Hand[0]; // Makes first card from hand the playing card
                    player1Hand.RemoveAt(0); // Removes first card from hand
                    player1Spoils.Add(player1Card); // Adds that first card into spoils
                    player2Card = player2Hand[0];
                    player2Hand.RemoveAt(0);
                    player2Spoils.Add(player2Card);
                }

                // Shows after battle info
                Console.WriteLine(player1Name + ":  Hand count: " + player1Hand.Count + " Discard count: " + player1Discard.Count + " Spoils: " + player1Spoils.Count);
                Console.WriteLine(player2Name + ":  Hand count: " + player2Hand.Count + " Discard count: " + player2Discard.Count + " Spoils: " + player2Spoils.Count + "\n");
            }
        }

        private static void Initialization() // Keith did this so I could use ToTitleCase method
        {
            CultureInfo cultureInfo = CultureInfo.CurrentCulture;
            textInfo = cultureInfo.TextInfo;
        }


        private static void GetPlayerNames()
        {
            Console.WriteLine("Enter a name for player 1");
            player1Name = textInfo.ToTitleCase(Console.ReadLine());

            Console.WriteLine("Enter a name for player 2");
            player2Name = textInfo.ToTitleCase(Console.ReadLine());

            Console.Write("Welcome " + player1Name + " and " + player2Name + " to the Game of War.");
        }

        private static void GetDeck() // Creates deck per card values 0 - 51
        {
            deck = new List<int>();
            for (int i = 0; i < 52; i++)
            {
                deck.Add(i);
            }
        }

        private static void ShuffleDeck(List<int> deckToShuffle)
        {
            Random rng = new Random();
            for (int n = deckToShuffle.Count - 1; n > 0; n--)
            {
                int k = rng.Next(n + 1);
                int value = deckToShuffle[k];
                deckToShuffle[k] = deckToShuffle[n];
                deckToShuffle[n] = value;
            }
        }

        private static void DealCards() // Deals each player half the deck
        {
            for (int i = 0; i < 26; i++)
            {
                player1Hand.Add(deck[2 * i + 1]);
                player2Hand.Add(deck[2 * i]);
            }
            deck.Clear();
        }

        private static void PrintCard(int card) // Prints the card from deckWithFaces
        {

            //deckWithFaces.ForEach(Console.WriteLine); // Writes rank and suit of 52 cards
            Console.WriteLine(deckWithFaces[card]); // Accesses card from deckWithFaces by card index
        }

        private static List<string> BuildDeckWithDisplayValues() // Creates initial deck with faces like 3H or 2D
        {
            deckWithFaces = new List<string>();
            List<string> rank1 = new List<string> { "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A" };
            List<string> suit1 = new List<string> { "S", "H", "D", "C" };

            foreach (string s in suit1) // Builds deck with rank and suit
            {
                foreach (string r in rank1)
                {
                    deckWithFaces.Add(r + s); // Adds cards with rank and suit to list
                }
            }
            return deckWithFaces;
        }

        private static void PrintPlayersHands() // Don't call this anymore, skipping printing players hands at first
        {
            Console.Clear();
            Console.WriteLine("Player 1's hand");
            foreach (int card in player1Hand)
            {
                PrintCard(card);
            }

            Pause();
            Console.Clear();
            Console.WriteLine("Player 2's hand");
            foreach (int card in player2Hand)
            {
                PrintCard(card);
            }
        }

        private static void Pause()
        {
            //Console.WriteLine("\n");
            Console.WriteLine("\n\n" + "Press any key to continue ..." + "\n\n");
            Console.ReadKey(true); // Set to true so it won't display the key entered
        }
    }
}
  