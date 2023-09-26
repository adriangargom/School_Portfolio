package ia;

import java.util.Random;
import java.util.ArrayList;

public class EasyMode{

    public static Random rand = new Random();

    public static ArrayList<Integer[]> availablePositions = new ArrayList<Integer[]>();

    public void checkMatrix(char[][] arr){

        for (int i = 0; i < arr.length; i++) {
            for (int j = 0; j < arr.length; j++) {
                if(arr[i][j] == ' '){
                    Integer[] positions = new Integer[]{j, i};
                    availablePositions.add(positions);
                }
            }
        }
    }

    //Make the new positon decision
    public char[][] makeDecision(char[][] arr, char playerChar){

        checkMatrix(arr);

        int randomPos = rand.nextInt((availablePositions.size()));

        int posX = availablePositions.get(randomPos)[0];
        int posY = availablePositions.get(randomPos)[1];

        if(arr[posY][posX] != ' '){

            try {
                makeDecision(arr, playerChar);
            } catch (Exception e) {
                System.out.println("Error");
            }
            
        }else{
            arr[posY][posX] = playerChar;
        }

        return arr;
    }
}