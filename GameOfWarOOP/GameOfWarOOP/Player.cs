using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Towery.GameOfWar
{
    class Player
    {
        // Fields
        private string _playerName;
        private Cards _hand = new Cards();
        private Cards _spoils = new Cards();
        private Cards _discard = new Cards();

        // Properties
        public string PlayerName 
        { 
            get { return _playerName; }
            set { _playerName = value; }
        }

        public Cards Hand
        {
            get { return _hand; }
            set { _hand = value; }
        }

        public Cards Spoils
        {
            get { return _spoils; }
            set { _spoils = value; }
        }

        public Cards Discard
        {
            get { return _discard; }
            set { _discard = value; }
        }


    }
}
