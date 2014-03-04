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
            GameOfWar testGame = new GameOfWar();
            testGame.PlayGame();

            //Card test = new Card(1, 1);
            //Card test1 = new Card(1, 1);
            //Card test2 = new Card(1, 1);
            //Card test3 = new Card(1, 1);// creates new Card object named "test"
            //Console.WriteLine(test.ToString());
            //Console.ReadKey();
        }
    }
}


