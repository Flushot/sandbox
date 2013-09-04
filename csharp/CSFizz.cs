using System;
using System.Runtime.InteropServices;

public class CSFizz {
    [DllImport("libcsfizz.so")]
    static extern int fizzy(int start, int end);

    private static void dieUsage() {
        Console.WriteLine("usage: <start> <end>");
        Environment.Exit(1);
    }

    private static string pluralize(int count, string text) {
        return null;
    }

    public static void Main(string[] args) {
        if (args.Length != 2) dieUsage();

        int start = int.Parse(args[0]),
        end = int.Parse(args[1]);
        
        if (start <= 0 || end <= start) dieUsage();

        int fizzCount = fizzy(start, end);
        Console.WriteLine("fizzed {0} times", fizzCount);
    }
}
