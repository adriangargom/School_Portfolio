import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Scanner;
import ia.Ia;

public class Main implements IFileSystem{

    //Various Object instantiations
    public static Scanner scan = new Scanner(System.in);
    public static Ia ia = new Ia();

    public static String player1Name;
    public static String player2Name;
    public static char winChar;

    //Important public variables
    public static int size = 12;
    public static int drawnCounter = 0;
    public static boolean win = false;
    public static boolean drawn = false;
    public static int tickCounter = 0;
    public static boolean vsMachine = false;
    public static boolean machineLevel = false;


    public static HashMap<String, Integer[]> players = new HashMap<String, Integer[]>();


    //Entry Welcome               Ok
    public static void entry(){
        System.out.println("-----Tree X Tree-----");
        System.out.println("1. Select the game Mode");
        System.out.println("2. Select Board Size");
        System.out.println("3. Set the position of the board");
        System.out.println("4. Exit the program with the comand (exit)");
        System.out.println("5. Reload the game if you want");
        System.out.println("6. Have a nice Time ;)\n");
    }

    //Main               Ok
    public static void main(String[] args){
        Colors.clearScreen();
        entry();

        if (askQuestions("You want to show the Logs? (Y/N) ", "Not valid option, pls retry with a valid parameter")){
            Colors.clearScreen();
            try {
                FileSaveSystem.readLogFile();
            } catch (FileNotFoundException e) {
                System.out.println(Colors.returnColorText(Colors.RED, "No Actual Log File!, Play for generating a Log File"));
            }
        }



        if (askQuestions("You want to show the Rankings? (Y/N) ", "Not valid option, pls retry with a valid parameter")){
            Colors.clearScreen();
            if(askQuestions("Show Machine Mode Rankings(Y) OR Show Player Mode Rankings(N) : ", "Not valid option, pls retry with a valid parameter")){
                try {
                    FileSaveSystem.readRankingsMachine();
                } catch (FileNotFoundException e) {
                    System.out.println(Colors.returnColorText(Colors.RED, "No Actual Rankings File!, Play for updating the ranking data"));
                }

            }else{
                try {
                    FileSaveSystem.readRankingsPlayers();
                } catch (FileNotFoundException e) {
                    System.out.println(Colors.returnColorText(Colors.RED, "No Actual Rankings File!, Play for updating the ranking data"));
                }
            }
        }

        //Ask if the player wants to play with the machine or not
        vsMachine = askQuestions("Play VS machine (Y/N): ", "Not valid option, pls retry with a valid parameter");

        //If the player wants to play with the machine then fix the board size to 3 and ask the machine level
        //else if the mode is player vs player then ask the board size and check if is valid
        if(vsMachine){
            //Read Machine Mode Ranking
            try {
                players = FileSaveSystem.readSaveFile(machinePath, players);
            } catch (FileNotFoundException e) {}

            player1Name = askPlayer(); // Get the player Name =====
            //Stack board size to 3 and ask machine level
            size = 3;
            machineLevel = askQuestions("Machine Level (Y.Easy / N.Hard): ", "Not valid option, pls retry with a valid parameter");




        }else{

            //Read Player VS Player Mode Ranking
            try {
                players = FileSaveSystem.readSaveFile(playerPath, players);
            } catch (FileNotFoundException e) {}
            
            //Ask player Names
            System.out.println("Player O");
            player1Name = askPlayer(); 
            System.out.println("Player X");
            player2Name = player1Name;
            while(player2Name.equals(player1Name)){
                player2Name = askPlayer();
            }


            //Select board Size and check if is valid
            while(size >= 11 || size <= 2){
                System.out.print("Size of the Board : ");
                try {
                    size = scan.nextInt();
                } catch (Exception e) {
                    scan.nextLine();
                    Colors.printColorText(Colors.RED, "Size not valid");
                }
            }
        }

        //Generate the board Array and restart the game
        char[][] arr = new char[size][size];
        restartGame(arr);

        char playerChar = '-';

        //Main Game Loop
        while(true){

            if(!win){

                //Clear the screen in each cicle of the game
                Colors.clearScreen();

                //Tick system that switches each tourn between the player1 and the player2
                playerChar = (tickCounter % 2 == 0)?'X':'O';
                
                //if is the oposite tourn and the vsMachine bool is true then verify the machine level selected and make a machine move
                //else if is mode player vs player then print the player tourn, draw the updated map and ask the player the position
                if(playerChar == 'O' && vsMachine){ //IA code

                    if(machineLevel){
                        arr = ia.easyMode(arr, playerChar);
                    }else if(!machineLevel){
                        arr = ia.hardMode(arr, playerChar);
                    }

                    drawMap(arr);
                    tickCounter += 1;
                    drawnCounter += 1;

                }else{  //Player VS player code

                    System.out.println((playerChar == 'X')? 
                    Colors.returnColorText(Colors.PURPLE, "Player "+playerChar+" turn"):
                    Colors.returnColorText(Colors.YELLOW, "Player "+playerChar+" turn"));
    
                    tickCounter += 1;
                    drawnCounter += 1;
        
                    drawMap(arr);
                    arr = playerMovement(arr, playerChar);
                }

                //If the map verification is null and there is not winner then check for posible Drawns, 
                //in the case of a winner then the verifyMap will call the winFunction() and will set the win bool to true, 
                //this will cause to jump in the next cicle of the while to the else code below
                if(!verifyMap(arr, playerChar)){
                    checkDrawn(arr, playerChar);
                }

            }else{ // Ask if the player wants to reset the game

                if(vsMachine && drawn == false){            // VS Machine Mode
                    String machineName = "";
                    int increment = 0;
                    
                    if(machineLevel == true){
                        machineName = "Machine_Easy";
                        increment = 1;
                    }else{
                        machineName = "Machine_Hard";
                        increment = 3;
                    }

                    int sumPoints = 0, games = 0;

                    games = players.get(player1Name)[1] + 1;

                    try {
                        if('X' == winChar){     //Player Win vs machine
                            sumPoints = players.get(player1Name)[0] + increment;
                            FileSaveSystem.writeLogEntry(player1Name, player1Name, machineName);

                        }else{                  //Machine Win vs Player
                            FileSaveSystem.writeLogEntry(machineName, player1Name, machineName);
                        }
                    } catch (IOException e) {
                        e.printStackTrace();
                    }

                    //IF zero division Error then set the winRate to 0
                    try {
                        players.put(player1Name, new Integer[]{sumPoints, games, sumPoints / games});
                    } catch (ArithmeticException e) {
                        players.put(player1Name, new Integer[]{sumPoints, games, 0});
                    }


                    try {
                        FileSaveSystem.writeSaveFile(machinePath, (HashMap<String, Integer[]>) players.clone());
                        FileSaveSystem.writeSaveFile(machineRankingPath, (HashMap<String, Integer[]>) players.clone(), FileSaveSystem.orderRanking(players));
                        FileSaveSystem.readSaveFile(machinePath, players);
                        players = FileSaveSystem.readSaveFile(machinePath, players);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }

                }else if(!vsMachine && drawn == false){     // VS Players Mode

                    try {
                        players = FileSaveSystem.readSaveFile(playerPath, players);
                    } catch (FileNotFoundException e) {
                    }
                    
                    Integer[] player1Data = players.get(player1Name);
                    player1Data[1] = 1;
                    players.put(player1Name, player1Data);

                    Integer[] player2Data = players.get(player2Name);
                    player2Data[1] = 1;
                    players.put(player2Name, player2Data);

                    if(playerChar == 'O'){

                        Integer[] playerPointsData = players.get(player1Name);
                        int playerScore = playerPointsData[0] + 3;

                        players.put(player1Name, new Integer[]{playerScore, playerPointsData[1], playerScore / playerPointsData[1]});

                        try {
                            FileSaveSystem.writeSaveFile(playerPath, (HashMap<String, Integer[]>) players.clone());
                            players = FileSaveSystem.readSaveFile(playerPath, players);
                            FileSaveSystem.writeLogEntry(player1Name, player1Name, player2Name);
                            FileSaveSystem.writeSaveFile(playerRankingPath, (HashMap<String, Integer[]>) players.clone(), FileSaveSystem.orderRanking(players));
                        } catch (IOException e) {
                            e.printStackTrace();
                        }

                    }else if(playerChar == 'X'){

                        Integer[] playerPointsData = players.get(player2Name);
                        int playerScore = playerPointsData[0] + 3;

                        players.put(player2Name, new Integer[]{playerScore, playerPointsData[1], playerScore / playerPointsData[1]});

                        try {
                            FileSaveSystem.writeSaveFile(playerPath, (HashMap<String, Integer[]>) players.clone());
                            players = FileSaveSystem.readSaveFile(playerPath, players);
                            FileSaveSystem.writeLogEntry(player2Name, player1Name, player2Name);
                            FileSaveSystem.writeSaveFile(playerRankingPath, (HashMap<String, Integer[]>) players.clone(), FileSaveSystem.orderRanking(players));
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }


                }

                //Reset game options that will set the win bool to true or false depending of the option picked by the player
                win = (askQuestions("Restart Game (Y/N): ", "Not valid option, pls retry with a valid parameter"))?true:false;




                //If the player selected not to reset the win variable will be false then we call the exitGame() function
                if(!win){
                    exitGame();
                }

                //If the previous if didn't acomplish then the player has selected to restart the game so we call the restart gameFunction()
                restartGame(arr);
            }
        }
    }

    //Player Movement               Ok
    public static char[][] playerMovement(char[][] arr, char playerChar){

        int x = 0, y = 0;

        x = askAxis('X');
        y = askAxis('Y');

        //Ask the 2 axis and verify if the value is valid
        while(true){
            if(x < 0 || x >= arr.length || y < 0 || y >= arr.length || arr[y][x] != ' '){
                Colors.printColorText(Colors.RED, "Not Valid Position");
                x = askAxis('X');
                y = askAxis('Y');
            }else{
                break;
            }
        }

        //Update the board and return it
        arr[y][x] =  playerChar;

        return arr;
    }

    //Ask the axis and verify if is valid               Ok
    public static int askAxis(char posChar){

        System.out.printf("Position %s : ", posChar);
        int value = 0;
        String cordinade = scan.next();

        if(cordinade.equals("exit")){
            exitGame();
        }

        try {
            value = Integer.parseInt(cordinade);
        } catch (Exception e) {
            Colors.printColorText(Colors.RED, "Not Valid Value, Retry");
            value = askAxis(posChar);
        }

        return value;
    }

    //Draw the map               Ok
    public static void drawMap(char[][] arr){

        System.out.print("  ");
        for (int i = 0; i < arr.length; i++) {
            System.out.printf("|%s", i);
        }
        System.out.print("|\n");

        for (int i = 0; i < arr.length; i++) {
            System.out.printf("|%s", i);
            for (int j = 0; j < arr.length; j++) {
                System.out.print("|"+((arr[i][j] == 'X')? 
                    Colors.returnColorText(Colors.PURPLE, Character.toString(arr[i][j])): 
                    Colors.returnColorText(Colors.YELLOW, Character.toString(arr[i][j]))));
            }
            System.out.print("|\n");   
        }
    }

    //Verify Verticals, Horizontals and Diagonals               Ok
    public static boolean verifyMap(char[][] arr, char playerChar){

        int counterVertL = 0, counterVertR = 0;

        for (int i = 0, o = arr.length-1; i < arr.length; i++, o--) {

            int counterVert = 0, counterHor = 0;

            counterVertL += (arr[i][i] == playerChar)?1:0;
            counterVertR += (arr[o][i] == playerChar)?1:0;

            for (int j = 0; j < arr.length; j++) {
                counterVert += (arr[i][j] == playerChar)?1:0;
                counterHor += (arr[j][i] == playerChar)?1:0;
            }

            if(counterVert == arr.length || counterHor == arr.length || counterVertL == arr.length || counterVertR == arr.length){
                winner(arr, playerChar);
                return true;
            }
        }

        return false;
    }

    //Check Drawn               Ok
    public static void checkDrawn(char[][] arr, char playerChar){
        boolean isDrawn = (drawnCounter == Math.pow(arr.length, 2))?true:false; 

        if(isDrawn){
            drawn(arr, playerChar);
        }
    }
    
    //Set the winner               Ok
    public static void winner(char[][] arr, char playerChar){
        winChar = playerChar;
        Colors.clearScreen();
        Colors.printColorText(Colors.GREEN, "Player " + playerChar + " Winned the game");
        drawMap(arr);
        win = true;
    }
    
    //Set a drawn               Ok
    public static void drawn(char[][] arr, char playerChar){
        
        Colors.clearScreen();
        Colors.printColorText(Colors.BLUE, "Players have a drawn in the game");
        drawMap(arr);

        if(vsMachine == true){
            win = true;
            drawn = true;
            return;
        }

        Tiebreaker tiebreaker = new Tiebreaker();

        int player_id = tiebreaker.tiebreak();

        try {
            if(player_id == 0){
                Integer[] playerDataArr = players.get(player1Name);
                players.put(player1Name, new Integer[]{playerDataArr[0] + 3, playerDataArr[2], playerDataArr[2]});
                FileSaveSystem.writeLogEntry(player1Name, player1Name, player2Name);

            }else{
                Integer[] playerDataArr = players.get(player2Name);
                players.put(player2Name, new Integer[]{playerDataArr[0] + 3, playerDataArr[2], playerDataArr[2]});
                FileSaveSystem.writeLogEntry(player2Name, player1Name, player2Name);
            }
        } catch (IOException e) {}

        try {
            FileSaveSystem.writeSaveFile(playerPath, players);
            FileSaveSystem.writeSaveFile(playerRankingPath, (HashMap<String, Integer[]>) players.clone(), FileSaveSystem.orderRanking(players));
            players = FileSaveSystem.readSaveFile(playerPath, players);
        } catch (IOException e) {}

        win = true;
        drawn = true;
    }

    //Ask questions               Ok
    public static boolean askQuestions(String message, String errorMessage){
        
        System.out.print(Colors.returnColorText(Colors.BLUE, message));
        String restartGame = scan.next().toLowerCase();

        if(restartGame.equals("y")){
            return true;
        }else if(restartGame.equals("n")){
            return false;
        }else{
            System.out.println(Colors.returnColorText(Colors.RED, errorMessage));
            return askQuestions(message, errorMessage);
        }
    }

    //Restart the full game scene               Ok
    public static char[][] restartGame(char[][] arr){

        drawnCounter = 0;
        win = false;
        tickCounter = 0;
        
        //Reset the board matrix
        for (int i = 0; i < arr.length; i++) {
            for (int j = 0; j < arr.length; j++) {
                arr[i][j] = ' ';
            }
        }
        return arr;
    }

    //Exit the Game               Ok
    public static void exitGame(){
        System.out.println("Bye ;D");
        System.exit(0);
    }

    //Ask the player Name               Ok
    public static String askPlayer(){
        try {
            System.out.print("Insert User Name > ");
            String name = scan.next();

            if(players.containsKey(name)){
                System.out.printf("Wellcome %s!\n", name);
            }else{
                players.put(name, new Integer[]{0, 0, 0});
            }

            return name;

        } catch (Exception e) {
            return askPlayer();
        }
    }

}