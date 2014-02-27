using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Towery.GameOfWar;

namespace ConsoleApplication1
{
    class Program
    {
        static void Main(string[] args)
        {
            Card myCard = new Card(0);
            Cards myCards = new Cards();
            myCards.Add(myCard);
            Console.WriteLine(myCards.Count);
            myCards.Remove(myCard);
            Console.WriteLine(myCards.Count);
            Console.WriteLine(myCard.ToString());
            Console.WriteLine(myCard.CardIndex);
            Console.ReadLine();
        }
    }
}


