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

        // Properties
        public string PlayerName 
        { 
            get { return _playerName; }
            set { _playerName = value; }
        }

        // Constructor
        public Player(string _playerName)
        {
            this._playerName = _playerName;
        }

    }
}
