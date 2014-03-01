using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Towery.GameOfWar
{
    public class Card
    {
        private int _rankNumber;
        private int _suitNumber;

        #region Properties

        public int RankNumber // public are Pascal case
        {
            get { return _rankNumber; }
        }

        public string Name
        {
            get { return this.ToString(); } // Run the ToString for this class (not an inherited one)
        }


        #endregion

        public Card(int rankNumber, int suitNumber) // Constructor
        {
            _rankNumber = rankNumber;
            _suitNumber = suitNumber;
        }



        #region Methods
        /*
        public override string ToString() // Use this over a method bc 
        {
            deckWithFaces = new List<string>();  // Creates initial deck with faces like 3H or 2D
            var rank = new List<string> { "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A" };
            // Had to use var as generic term for list of characters
            var suit = new List<char> { '\u0005', '\u0004', '\u0003', '\u0006' }; // 5 = clubs, 4 = diamonds, 3 = hearts, 6 = spades

            foreach (var s in suit) // Builds deck with rank and suit
            {
                foreach (var r in rank)
                {
                    deckWithFaces.Add(r + s); // Adds cards with rank and suit to list
                }
            }
            return deckWithFaces[_cardIndex];
        }

        #endregion
         */

    }
}


