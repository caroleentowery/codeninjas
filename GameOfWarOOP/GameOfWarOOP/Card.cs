using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Towery.GameOfWar
{
    public class Card
    {
        private int _cardIndex;
        private int _rankNumber;
        private int _suitNumber;

        #region Properties

        public int CardIndex // public are Pascal case
        {
            get { return _cardIndex; }
        }

        public string Name
        {
            get { return this.ToString(); } // Run the ToString for this class (not an inherited one)
        }

        #endregion

        public Card(int cardIndex) // constructor
        {
            _cardIndex = cardIndex;
        }

        #region Methods

        public override string ToString() 
        {

            _rankNumber = _cardIndex % 13;
            _suitNumber = _cardIndex / 13;

            string rankSymbol = string.Empty; // Declare empty variable
            string suitSymbol = string.Empty;

            if (_rankNumber <= 8)
            {
                rankSymbol = (_rankNumber + 2).ToString();
            }

            else
            {
                switch (_rankNumber)
                {
                    case 9:
                        rankSymbol = "J";
                        break;
                    case 10:
                        rankSymbol = "Q";
                        break;
                    case 11:
                        rankSymbol = "K";
                        break;
                    case 12:
                        rankSymbol = "A";
                        break;
                }
            }

             switch (_suitNumber)
             {
                 case 0:
                     suitSymbol = ((char)3).ToString(); // Heart
                     break;
                 case 1:
                     suitSymbol = ((char)4).ToString(); // Diamond
                     break;
                 case 2:
                     suitSymbol = ((char)5).ToString(); // Clubs
                     break;
                 case 3:
                     suitSymbol = ((char)6).ToString(); // Spades
                     break;
             }

            return rankSymbol + " of " + suitSymbol; // shows 3 of heart symbol
        }

        #endregion

    }
}


