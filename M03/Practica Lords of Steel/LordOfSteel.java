import java.util.HashMap;
import java.util.Scanner;
import java.util.Random;

import player.Player;
import player.categories.*;
import weapon.*;

import color.Color;
import color.InterfaceColors;

public class LordOfSteel implements InterfaceColors{
    public static HashMap<String, Player> players = new HashMap<String, Player>(); //Players HashMap
    public static int statPoints;   // Actual Editing StatPoints
    public static boolean running = true;   //Running the loop?
    
    // Components
    public static Scanner scan = new Scanner(System.in);    // Scanner
    public static Random rand = new Random();   // Random
    
    public static void main(String[] args){

        // 4 new Player Creations
        players.put("Gnome", new DwarfOrder("Gnome", 5, 5, 5, 19, 5, new Dagger(), 60));
        players.put("Pedro", new HumanChaos("Pedro", 10, 5, 5, 5, 5, new Dagger(), 60));
        players.put("Valdur", new MidleOrder("Valdur", 5, 15, 5, 5, 5, new Dagger(), 60));
        players.put("Cronor", new MaiaChaos("Cronor", 5, 5, 17, 5, 18, new Dagger(), 60));

        while (running) {
            mainMenu();
        }
    }

    //Main menu
    public static void mainMenu(){
        System.out.println(Color.paint("----- Lord Of Steel -----", RED));
        System.out.println("1. Add Player\n2. Delete Player\n3. Edit Player\n4. Combat\n5. Exit");

        switch (askInteger(1, 5)) {
            case 1:
                createCharacter();
                break;
            case 2:
                deleteCharacter();
                break;
            case 3:
                editCharacter();
                break;
            case 4:
                combat();
                break;
            case 5:
                running = false;
                System.out.println("Bye ;D");
                break;
        }
    }

    //Creates a new character   Menu Option - 1
    public static void createCharacter(){
        //Ask Character
        System.out.println("Category\n----------\n0. Dwarf\n1. Human\n2. Midle\n3. Maia");
        int playerCategory = askInteger(0, 3);

        //Ask Atributes -- Name
        System.out.printf("Name\n----------\n> ");
        String name = scan.next();
        while(name.length() > 18){
            System.out.print("Name to Long\n>");
            name = scan.next();
        }

        // Check if the player name is created or not, if the name is alredy created returns to the main menu
        if(players.containsKey(name)){ 
            clearConsole();
            System.out.println(Color.paint("This player is alredy created!", RED));
            return;
        }

        //Ask Atributes -- Stats
        statPoints = 60;
        int strength = askStat("Strength");
        int constitution = askStat("Constitution");
        int speed = askStat("Speed");
        int intelligence = askStat("Intelligence");
        int luck = askStat("Luck");

        //Ask Weapon
        System.out.println("Weapon\n----------\n0. Dagger\n1. Sword\n2. Hummer");
        Weapon weapon = null;
        switch (askInteger(0, 2)) {
            case 0:
                weapon = new Dagger();
                break;
            case 1:
                weapon = new Sword();
                break;
            case 2:
                weapon = new Hummer();
                break;
        }

        //Ask Devotion
        System.out.println("Devotion\n----------\n0. Order\n1. Chaos");
        int playerDevotion = askInteger(0, 1);

        //Generate the new player
        String playerId = String.valueOf(playerCategory) + String.valueOf(playerDevotion);

        switch (playerId) {
            case "00": // Dwarf Order Id
                players.put(name, new DwarfOrder(name, strength, constitution,
                                                 speed, intelligence, luck, weapon, 60));
                break;
            case "01": // Dwarf Chaos Id
                players.put(name, new DwarfChaos(name, strength, constitution,
                                                 speed, intelligence, luck, weapon, 60));
                break;
            case "10": // Human Order Id
                players.put(name, new HumanOrder(name, strength, constitution,
                                                 speed, intelligence, luck, weapon, 60));
                break;
            case "11": // Human Chaos Id
                players.put(name, new HumanChaos(name, strength, constitution,
                                                 speed, intelligence, luck, weapon, 60));
                break;
            case "20": // Midle Order Id
                players.put(name, new MidleOrder(name, strength, constitution,
                                                 speed, intelligence, luck, weapon, 60));
                break;
            case "21": // Midle Chaos Id
                players.put(name, new MidleChaos(name, strength, constitution,
                                                 speed, intelligence, luck, weapon, 60));
                break;
            case "30": // Maia Order Id
                players.put(name, new MaiaOrder(name, strength, constitution,
                                                 speed, intelligence, luck, weapon, 60));
                break;
            case "31": // Maia Chaos Id
                players.put(name, new MaiaChaos(name, strength, constitution,
                                                 speed, intelligence, luck, weapon, 60));
                break;
        }

    }

    //Deletes a created character   Menu Option - 2
    public static void deleteCharacter(){
        System.out.println("Characters To Delete\n--------------------");
        players.remove(selectCharacter());
        System.gc();
    }

    //Edit a created Character   Menu Option - 3
    public static void editCharacter(){

        System.out.println("Characters To Edit\n--------------------");
        Player selPlay = players.get(selectCharacter());
        statPoints = selPlay.getStatPoints();

        selPlay.setPrimaryStats(askStat("Strength"), askStat("Constitution"),
                                askStat("Velocity"), askStat("Intelligence"), 
                                askStat("Luck"));

        selPlay.calcSecondaryStats();
    }

    //Combat main Method   Menu Option - 4
    public static void combat(){
        String p1Name = selectCharacter(), p2Name = p1Name;

        while(p1Name.equals(p2Name)){
            p2Name = selectCharacter();
        }

        Player p1 = players.get(p1Name), p2 = players.get(p2Name);

        System.out.println("-----Battle Review-----");
        while(p1.getPs() > 0 && p2.getPs() > 0){
            round(p1, p2); // Round "p1" atacks to "p2"

            if(p1.getPs() < 0 && p2.getPs() < 0){break;}

            round(p2, p1); // Round "p2" atacks to "p1"
        }

        Player winner = (p1.getPs() > 0)?p1: p2;
        Player looser = (p1.getPs() <= 0)?p1:p2;

        System.out.printf(Color.paint("Winner %s!\n", GREEN), winner.getName());
        System.out.printf(Color.paint("Looser %s!\n", RED), looser.getName());
        winner.restorePs();
        looser.restorePs();

        winner.augmentPex(100, looser.getPs());

        System.out.printf("\n0. Back to menu\n1. Exit Game\n");
        switch (askInteger(0, 1)) {
            case 1:
                running = false;
                break;
            default:
                break;
        }
    }

    //Each combat round method
    public static void round(Player atackPlayer, Player defensePlayer){

        int atackTournDice = throwDices();
        //Player1 Atack
        if(atackTournDice <= atackPlayer.getPa()){
            System.out.printf(Color.paint(" > %s, atacks to %s !\n", RED), atackPlayer.getName(), defensePlayer.getName());

            //Player2 Defense
            int defenseTournDice = throwDices();
            if(defenseTournDice <= defensePlayer.getPe()){
                System.out.printf(Color.paint(" > %s, dodges the %s atack !\n", CYAN), defensePlayer.getName(), atackPlayer.getName());
                
                checkChaos(defensePlayer, atackPlayer); // <= Check Chaos and execute necessary functions
                System.out.printf(Color.paint("\n%s PS => %s\n", YELLOW), atackPlayer.getName(), atackPlayer.getPs());
                System.out.printf(Color.paint("%s PS => %s\n", YELLOW), defensePlayer.getName(), defensePlayer.getPs());
                System.out.println("------------------------------");
                System.gc();    //Call the GC to clean the instantiated classes
                return;
            }

            checkOrder(atackPlayer, defensePlayer); // <= Check Order and execute necessary functions
            defensePlayer.getDamage(atackPlayer.getPd());
        }else{
            System.out.printf(Color.paint(" > %s, has failed the atack to %s !\n", BLUE), atackPlayer.getName(), defensePlayer.getName()); 
        }

        System.out.printf(Color.paint("\n%s PS => %s\n", YELLOW), atackPlayer.getName(), atackPlayer.getPs());
        System.out.printf(Color.paint("%s PS => %s\n", YELLOW), defensePlayer.getName(), defensePlayer.getPs());
        System.out.println("------------------------------");
        System.gc();    //Call the GC to clean the instantiated classes
    }

    // Check if the player devotion == Order and then executes the needed actions
    public static void checkOrder(Player actionPlayer, Player afectedPlayer){
        
        if(actionPlayer instanceof InterfaceOrder){
            InterfaceOrder playerOrder = (InterfaceOrder)actionPlayer;
            playerOrder.restPS();
            playerOrder = null;
        }
    }

    // Check if the player devotion == Chaos and then executes the needed actions
    public static void checkChaos(Player actionPlayer, Player afectedPlayer){

        if(actionPlayer instanceof InterfaceChaos){
            InterfaceChaos playerOrder = (InterfaceChaos)actionPlayer;

            if(playerOrder.diceAtack(throwDices())){
                afectedPlayer.setPs(afectedPlayer.getPs()-actionPlayer.getPd());
            }
    
            playerOrder = null;
        }
    }

    //Returns the Value of the 3 dices roll
    public static int throwDices(){
        int res = rand.nextInt(1, 26) + rand.nextInt(1, 26) + rand.nextInt(1, 26);
        System.out.printf("Dice Roll result => %s\n", res);
        return res;
    }

    //Select a character from the character List
    public static String selectCharacter(){

        int id = 0;
        System.out.printf("%-22s %-3s %-3s %-3s %-3s %-3s - %-3s %-3s %-3s %-3s - %-8s - %-8s - %-3s %-3s\n",
                  "","STR", "CON", "VEL", "INT", "LUC", "PS ", "PD ", "PA ", "PE ", "CLASS", "DEVOTION", "PEX", "NIV"); // Head Decorator

        for (String key : players.keySet()) {
            Player tmp = players.get(key);
            System.out.printf("%2s.%-20s", id, key);
            System.out.printf("%-3s %-3s %-3s %-3s %-3s", tmp.getStrength(), tmp.getConstitution(), tmp.getVelocity(), tmp.getIntelligence(), tmp.getLuck()); // Primary Stats
            System.out.printf(" - %-3s %-3s %-3s %-3s", tmp.getPs(), tmp.getPd(), tmp.getPa(), tmp.getPe()); // Secondary Stats
            System.out.printf(" - %-8s - %-8s", tmp.getPlayerClass(), tmp.getPlayerOrder()); // Class and order
            System.out.printf(" - %-3s %-3s\n", tmp.getPex(), tmp.getNiv()); // Class and order
            id += 1;
        }
        
        int characterId = askInteger(0, players.size()-1);
        return players.keySet().toArray(new String[players.size()])[characterId];
    }

    //Ask a integer value between a range of values
    public static int askInteger(int startRange, int endRange){
        try {
            System.out.print("> ");
            int val = Integer.parseInt(scan.next());

            if(val < startRange || val > endRange){
                throw new Exception("Not valid");
            }

            clearConsole();
            return val;
        } catch (Exception e) {
            return askInteger(startRange, endRange);
        }
    }

    //Ask a new stat value, check if this value is valid or not and shows the left StatPoints that remains to be given
    public static int askStat(String statName){
        clearConsole();
        System.out.printf("Stats\n----------\nValid Points = %s\n%s >", statPoints, statName);
        
        try {
            int val = Integer.parseInt(scan.next());

            if(val < 3 || val > 18 || statPoints <= 0 || statPoints - val < 0){
                throw new Exception("Not valid");
            }

            statPoints -= val;
            clearConsole();
            return val;
        } catch (Exception e) {
            return (statPoints <= 0)?0:askStat(statName);
        }
    }

    //Clear the console
    public static void clearConsole(){
        System.out.print("\033[H\033[2J");  
        System.out.flush();  
    }

}