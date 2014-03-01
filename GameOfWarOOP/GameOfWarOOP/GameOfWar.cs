using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Globalization;

namespace Towery.GameOfWar
{
    class GameOfWar
    {
        string player1Name;
        string player2Name;
        static TextInfo textInfo;
        Cards deck;
        
        private void GetPlayerNames()
        {
            Console.WriteLine("Enter a name for player 1");
            player1Name = textInfo.ToTitleCase(Console.ReadLine());

            Console.WriteLine("Enter a name for player 2");
            player2Name = textInfo.ToTitleCase(Console.ReadLine());

            Console.Write("Welcome " + player1Name + " and " + player2Name + " to the Game of War.");
        }

        private void Initialization() // Keith did this so I could use ToTitleCase method
        {
            CultureInfo cultureInfo = CultureInfo.CurrentCulture;
            textInfo = cultureInfo.TextInfo;
        }

        private void GetDeck() // Creates deck per card values 0 - 51
        {
            deck = new Cards();
            for (int i = 0; i < 52; i++)
            {
                deck.Add(i);
            }
        }


    }
}
