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
        private string _rankDisplay;

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
            if (_rankNumber <= 8)
                return (_rankNumber + 2).ToString();
            else
            {
                switch (_rankNumber)
                {
                    case 9:
                        return "J";
                        break;
                    case 10:
                        return "Q";
                        break;
                    case 11:
                        return "K";
                        break;
                    case 12:
                        return "A";
                        break;
                }
            }

             switch (_suitNumber)
             {
                 case 0:
                     return "Clubs"; // char '\u0005'
                     break;
                 case 1:
                     return "Diamonds"; // char '\u0006';
                     break;
                 case 2:
                     return "Hearts"; // char '\u0007';
                     break;
                 case 3:
                     return "Spades"; // char '\u0008';
                     break;
             }

            return _rankNumber + " of " + _suitNumber;
        }

        #endregion



    }
}


