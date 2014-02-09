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
        
        #endregion

        static void Main()
        {
            // Initial setup of play session
            Initialization();
            GetPlayerNames();
            Pause();
            GetDeck();
            ShuffleDeck(deck);
            deckWithFaces = BuildDeckWithDisplayValues();
            
            // Set up for single game
            DealCards();

            // Play actual game
            //PrintPlayersHands();

            int player1Card = player1Hand[0];
            player1Hand.RemoveAt(0);
            int player2Card = player2Hand[0];
            player2Hand.RemoveAt(0);
            Console.WriteLine(player1Name + " plays " + deckWithFaces[player1Card] + " and " + player2Name + " plays " + deckWithFaces[player2Card] + "\n\n");

            if (player1Card % 13 > player2Card %13)
            {
                player1Spoils.Add(player1Card);
                player2Spoils.Add(player2Card);
                Console.WriteLine(player1Name + ":  Hand count: " + player1Hand.Count + " Discard count: " + player1Discard.Count + " Spoils: " + player1Spoils.Count);
                Console.WriteLine(player2Name + ":  Hand count: " + player2Hand.Count + " Discard count: " + player2Discard.Count + " Spoils: " + player2Spoils.Count + "\n");             
                Console.WriteLine(player1Name + " wins this skirmish." + "\n\n");
                player1Spoils.AddRange(player2Spoils); // Adds player 2 spoils to player 1 spoils
                player1Discard.AddRange(player1Spoils); // Addds total spoils to player 1 discard
                player2Spoils.Clear(); // Clears player 2 spoils
                Console.WriteLine(player1Name + ":  Hand count: " + player1Hand.Count + " Discard count: " + player1Discard.Count + " Spoils: " + player1Spoils.Count);
                Console.WriteLine(player2Name + ":  Hand count: " + player2Hand.Count + " Discard count: " + player2Discard.Count + " Spoils: " + player2Spoils.Count + "\n\n");
                player1Spoils.Clear();
            }

            Pause();

        }

        private static void Initialization()
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
            List<string> deckWithFaces; // Why do I need this line?
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
  