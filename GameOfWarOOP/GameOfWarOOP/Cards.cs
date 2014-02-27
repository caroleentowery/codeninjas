using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Towery.GameOfWar
{
    public class Cards : List<Card> 
    {
        public void Shuffle()
        {
            Random rng = new Random();
            for (int n = this.Count - 1; n > 0; n--)
            {
                int k = rng.Next(n + 1);
                Card value = this[k];
                this[k] = this[n];
                this[n] = value;
            }
        }
    }

/* Use this for extension method
 * 
    public static class CardsExtensions
    {
        public static void Shuffle(this Cards cards)
        {
            Random rng = new Random();
            for (int n = cards.Count - 1; n > 0; n--)
            {
                int k = rng.Next(n + 1);
                Card value = cards[k];
                cards[k] = cards[n];
                cards[n] = value;
            }
        }
    }
*/


}
