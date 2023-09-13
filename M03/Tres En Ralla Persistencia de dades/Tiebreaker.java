import java.util.Scanner;
import java.util.Random;

public class Tiebreaker {
    
    public int tiebreak(){
        Random rnd = new Random();
        Colors.clearScreen();

        System.out.println("=====Tiebreak Mode=====");

        int randomNumber = rnd.nextInt(0, 10);

        int numb = 100;
        int counter = 0;

        while(randomNumber != numb){

            System.out.printf("Player %s\n > ", (counter == 0)? "O":"X");

            numb = askNumber();
            if(numb == randomNumber){break;} 

            if(counter == 0){
                counter += 1;
            }else if(counter == 1){
                counter = 0;
            }

            Colors.clearScreen();
        }

        System.out.printf("Winner Player => %s\n", ((counter == 0)? "O":"X"));

        return counter;
    }


    public int askNumber(){
        Scanner scan = new Scanner(System.in);

        try {
            int numb = scan.nextInt();

            if(numb < 0 || numb > 10){
                throw new Exception("Not valid Number");
            }
            return numb;
        } catch (Exception e) {
            System.out.println(e);
        }

        return 0;
    }

}
