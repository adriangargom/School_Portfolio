import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

public class Data {

    public static String path = "./data/save.txt";
    
    static void saveData(HashMap<Integer, Cuenta> accounts) throws IOException{

        FileWriter fw = new FileWriter(path);
        
        fw.write("");
        fw.append(String.valueOf(accounts.size()) + "\n");

        for (int i = 0; i < accounts.size(); i++) {
            fw.append("----------\n");
            fw.append(accounts.get(i).id + "\n");
            fw.append(accounts.get(i).balance + "\n");
        }

        fw.close();
    }

    static ArrayList<Cuenta> readData() throws IOException{

        FileReader fr = new FileReader(path);
        BufferedReader br = new BufferedReader(fr);

        int times = Integer.parseInt(br.readLine());

        ArrayList<Cuenta> arr = new ArrayList<Cuenta>();

        for (int i = 0; i < times; i++) {
            System.out.println(br.readLine());
            arr.add(new Cuenta(Integer.parseInt(br.readLine()), Integer.parseInt(br.readLine())));
        }
        System.out.print("\033[H\033[2J");  
        System.out.flush();  
        return arr;
    }

}
