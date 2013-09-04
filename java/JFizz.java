public class JFizz {
    // libjfizz.so
    private static native int fizzy(int start, int end);
    static {
        System.loadLibrary("jfizz");
    }

    // Show CLI usage and exit.
    private static void dieUsage() {
        System.out.println(String.format("usage: <start> <end>"));
        System.exit(1);
    }

    // Pluralize a word.
    private static String pluralize(int count, String word) {
        return (count != 1 && word.charAt(word.length() - 1) != 's')
            ? word + "s"
            : word;
    }

    // Program entry point
    public static void main(String[] args) {
        // Get and validate arguments.
        if (args.length != 2) dieUsage();

        int start = Integer.parseInt(args[0], 10),
            end = Integer.parseInt(args[1], 10);

        if (start <= 0 || end < start) dieUsage();

        // Invoke external function.
        int fizzCount = fizzy(start, end);

        // Display number of fizzes.
        String times = pluralize(fizzCount, "time");
        System.out.println(String.format("fizzed %d %s\n", fizzCount, times));
    }
}
