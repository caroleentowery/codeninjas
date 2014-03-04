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

        public override string ToString() 
        {
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
                     suitSymbol = ((char)5).ToString(); // Spade
                     break;
                 case 3:
                     suitSymbol = ((char)6).ToString(); // Clubs
                     break;
             }

            return rankSymbol + " of " + suitSymbol; // shows 3 of heart symbol
        }

        #endregion



    }
}


