class Colors {
    
    static final String RED = "\u001B[31m";
    static final String BLUE = "\033[36m";
    static final String YELLOW = "\u001B[33m";
    static final String PURPLE = "\u001B[34m";
    static final String GREEN = "\u001B[32m";
    static final String RESET = "\u001B[0m";

    //Print paint text
    static void printColorText(String color, String text){
        System.out.println(color + text + RESET);
    }

    //Return paint text
    static String returnColorText(String color, String text){
        return color + text + RESET;
    }

    //Clear the Screen
    static void clearScreen(){
        System.out.print("\033[H\033[2J");
        System.out.flush();
    }
}
