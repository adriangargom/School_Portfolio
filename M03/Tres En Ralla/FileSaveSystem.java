
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Scanner;
import java.io.File;

public class FileSaveSystem implements IFileSystem{
    

    // READ SAVE FILE
    static HashMap<String, Integer[]> readSaveFile(String filePath, HashMap<String, Integer[]> players) throws FileNotFoundException{
        File saveFile = new File(filePath);
        Scanner scan = new Scanner(saveFile);

        while(scan.hasNextLine()){
            String data = scan.nextLine();
            String[] splitted = data.split(":");

            players.put(splitted[0], new Integer[]{Integer.parseInt(splitted[1]), Integer.parseInt(splitted[2]), Integer.parseInt(splitted[3])});
        }

        scan.close();
        return players;
    }

    // WRITE SAVE FILE "USER DATA"
    static void writeSaveFile(String filePath, HashMap<String, Integer[]> players) throws FileNotFoundException{    
        try {
            PrintWriter pw = new PrintWriter(filePath);  

            for (String i : players.keySet()) {
                pw.print(String.format("%s:%s:%s:%s\n", i, players.get(i)[0], players.get(i)[1], players.get(i)[2]));
            }
    
            pw.close();

        } catch (FileNotFoundException e) {
            System.out.println("File not found");
            File new_file = new File("saveFile.txt");
            writeSaveFile(filePath, players);
        }
    }

    // WRITE SAVE FILE "USER RANKING"
    static void writeSaveFile(String filePath, HashMap<String, Integer[]> players, ArrayList<String> list) throws FileNotFoundException{
        
        try {
            PrintWriter pw = new PrintWriter(filePath);  

            for (int i = 0; i < list.size(); i++) {
                Integer[] playerPointsData = players.get(list.get(i));
                pw.print(String.format("%s:%s:%s:%s\n", list.get(i), playerPointsData[0], playerPointsData[1], playerPointsData[2]));
            }
    
            pw.close();

        } catch (FileNotFoundException e) {
            System.out.println("File not found");
            File new_file = new File("saveFile.txt");
            writeSaveFile(filePath, players);
        }
    }

    // ORDER THE RANKING IN DESCENDING ORDER
    static ArrayList<String> orderRanking(HashMap<String, Integer[]> hm){
        ArrayList<String> orderedRanking = new ArrayList<String>();

        while(hm.size() > 0){
            String key = "";
            Double value = 0d;

            for (String s : hm.keySet()){
                Double calcVal = 0d;
                calcVal = Double.valueOf(hm.get(s)[0]) / Double.valueOf(hm.get(s)[1]);

                if(calcVal >= value){
                    key = s;
                    value = calcVal;
                }
            }

            hm.remove(key);
            orderedRanking.add(key);
        }

        return orderedRanking;
    }

    // WRITE A NEW LOG ENTRY
    static void writeLogEntry(String winner, String player1Name, String player2Name) throws IOException{

        File f = new File("./data/logs.txt");
        FileWriter fw = new FileWriter(f, true);

        LocalDateTime date = LocalDateTime.now();

        fw.write(String.format("%s : %s AS O | %s AS X : Winner : %s\n", date, player1Name, player2Name, winner));

        fw.close();
    }

    // READ THE LOG FILES
    static void readLogFile() throws FileNotFoundException{

        File lf = new File(logFile);
        Scanner scan = new Scanner(lf);

        System.out.println("----Log File-------------------");
        while(scan.hasNextLine()){
            System.out.println(scan.nextLine());
        }

        System.out.println("-------------------------------");
    }

    // READ THE MACHINE RANKINGS
    static void readRankingsMachine() throws FileNotFoundException{
        
        //Machine Ranking
        File mr = new File(machineRankingPath);
        Scanner scan1 = new Scanner(mr);

        System.out.println("----Machine Rankings-----------");
        System.out.println(String.format("%-31s %-11s %-11s %-13s", "User Name", "Points", "Games", "WinRate"));
        while(scan1.hasNextLine()){
            String[] userData = scan1.nextLine().split(":");
            Double winRate = Double.parseDouble(userData[1]) / Double.parseDouble(userData[2]);
            System.out.println(String.format("%-40s %-20s %-20s %-20s", Colors.returnColorText(Colors.BLUE, userData[0]), 
                                                                            Colors.returnColorText(Colors.YELLOW, userData[1]), 
                                                                            Colors.returnColorText(Colors.PURPLE, userData[2]), 
                                                                            Colors.returnColorText(Colors.GREEN, String.valueOf(winRate))));
        }
        System.out.println("-------------------------------");
    }

    static void readRankingsPlayers() throws FileNotFoundException{
        
        //Player Ranking
        File pr = new File(playerRankingPath);
        Scanner scan2 = new Scanner(pr);

        System.out.println("----Player Rankings------------");
        System.out.println(String.format("%-31s %-11s %-11s %-13s", "User Name", "Points", "Games", "WinRate"));
        while(scan2.hasNextLine()){
            String[] userData = scan2.nextLine().split(":");
            Float winRate = Float.parseFloat(userData[1]) / Float.parseFloat(userData[2]);
            System.out.println(String.format("%-40s %-20s %-20s %-20s", Colors.returnColorText(Colors.BLUE, userData[0]), 
                                                                            Colors.returnColorText(Colors.YELLOW, userData[1]), 
                                                                            Colors.returnColorText(Colors.PURPLE, userData[2]), 
                                                                            Colors.returnColorText(Colors.GREEN, String.valueOf(winRate))));
        }
        System.out.println("-------------------------------");
    }
}