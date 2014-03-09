using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Globalization;

namespace Towery.GameOfWar
{
    class GameOfWar
    {
        static TextInfo textInfo;

        Player player1 = new Player();
        Player player2 = new Player();

        public void PlayGame()
        {
            //Testing returning card values
            Card test = new Card(48); // creates new Card object named "test"
            Console.WriteLine(test.ToString());

            Initialization();
            GetPlayerNames();
            Console.Write("Welcome " + player1.PlayerName + " and " + player2.PlayerName + " to the Game of War.");
            GetDeck();
            //Console.WriteLine(deck);
            Console.ReadKey();
        }

        public void GetDeck() // Creates deck per card values 0 - 51
        {
            Cards deck = new Cards();
            for (int i = 0; i < 52; i++)
            {
                deck.Add(i); // This is where error is
                //Console.WriteLine(i);
            }
        }

        private void GetPlayerNames()
        {
            Console.WriteLine("Enter a name for player 1");
            player1.PlayerName = textInfo.ToTitleCase(Console.ReadLine());

            Console.WriteLine("Enter a name for player 2");
            player2.PlayerName = textInfo.ToTitleCase(Console.ReadLine());
        }

        private void Initialization() // Keith did this so I could use ToTitleCase method
        {
            CultureInfo cultureInfo = CultureInfo.CurrentCulture;
            textInfo = cultureInfo.TextInfo;
        }
    }

}

