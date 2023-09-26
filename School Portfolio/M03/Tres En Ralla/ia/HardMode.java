package ia;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;

public class HardMode {
    
    public static ArrayList<Integer[]> availablePositions = new ArrayList<Integer[]>();
    public static HashMap<Integer[], Integer> calculatedWeigths = new HashMap<Integer[], Integer>();

    //Check Matrix for available positions
    public void checkMatrix(char[][] arr){

        availablePositions.clear();
        
        for (int i = 0; i < arr.length; i++) {
            for (int j = 0; j < arr.length; j++) {
                if(arr[i][j] == ' '){
                    Integer[] positions = new Integer[]{i, j};
                    availablePositions.add(positions);
                }
            }
        }
    }

    public static int turns = 0;

    //Check the weigths and select the better option
    public char[][] checkWeigths(char[][] arr, char robotChar){


        if(turns == 0 && arr[1][1] == ' '){

            arr[1][1] = robotChar;

        }else{

            checkMatrix(arr);
            
            //Calcylate the weigth of each available position
            for (Integer[] key : availablePositions) {
    
                int totalWeigth = 0;

                //Calc Bot lose Positions
                totalWeigth += calcWeigth(arr, key, 'X', 1 , 4);

                //Calc Bot Win Positions
                totalWeigth += calcWeigth(arr, key, 'O', 1, 3);

                calculatedWeigths.put(key, totalWeigth);
    
            }
            
            int maxWeigth = 0;
            Integer[] betterOption = {0, 0}; 

            for (Integer[] keys : calculatedWeigths.keySet()) {
    
                if(calculatedWeigths.get(keys) > maxWeigth){
    
                    maxWeigth = calculatedWeigths.get(keys);
                    betterOption = keys;
                }
                
                //System.out.println(Arrays.toString(keys) + " Weigth => " + calculatedWeigths.get(keys));
            }
    
            //System.out.println(Arrays.toString(betterOption) + " Weigth => " + maxWeigth);
    
            //Recalculate if the position is not free <= This part is not necesari but i lefted for double redundance level an less failture
            if(arr[betterOption[0]][betterOption[1]] != ' '){
    
                calculatedWeigths.remove(betterOption);
                checkWeigths(arr, robotChar);

            }else{
                arr[betterOption[0]][betterOption[1]] = robotChar;
                calculatedWeigths.clear();
            }

        }

        return arr;
    }

    //Calculate each direction weigth
    public int calcWeigth(char arr[][], Integer[] key, char inUseChar, int plusOne, int plusTwoo){

        int totalWeigth = 0;

        //Up
        try {
            if(arr[key[0]-1][key[1]] == inUseChar){

                totalWeigth += plusOne;
                try {
                    if(arr[key[0]-2][key[1]] == inUseChar){
                        totalWeigth += plusTwoo;
                    }
                } catch (Exception e) {}
            }
        } catch (Exception e) {}

        //Down
        try {
            if(arr[key[0]+1][key[1]] == inUseChar){

                totalWeigth += plusOne;
                try {
                    if(arr[key[0]+2][key[1]] == inUseChar){
                        totalWeigth += plusTwoo;
                    }
                } catch (Exception e) {}
            }
        } catch (Exception e) {}

        //Left
        try {
            if(arr[key[0]][key[1]-1] == inUseChar){

                totalWeigth += plusOne;
                try {
                    if(arr[key[0]][key[1]-2] == inUseChar){
                        totalWeigth += plusTwoo;
                    }
                } catch (Exception e) {}
            }
        } catch (Exception e) {}

        //Rigth
        try {
            if(arr[key[0]][key[1]+1] == inUseChar){

                totalWeigth += plusOne;
                try {
                    if(arr[key[0]][key[1]+2] == inUseChar){
                        totalWeigth += plusTwoo;
                    }
                } catch (Exception e) {}
            }
        } catch (Exception e) {}

        //Diagonal 1
        try {
            if(arr[key[0]-1][key[1]-1] == inUseChar){

                totalWeigth += plusOne;
                try {
                    if(arr[key[0]-2][key[1]-2] == inUseChar){
                        totalWeigth += plusTwoo;
                    }
                } catch (Exception e) {}
            }
        } catch (Exception e) {}

        //Diagonal 2
        try {
            if(arr[key[0]-1][key[1]+1] == inUseChar){

                totalWeigth += plusOne;
                try {
                    if(arr[key[0]-2][key[1]+2] == inUseChar){
                        totalWeigth += plusTwoo;
                    }
                } catch (Exception e) {}
            }
        } catch (Exception e) {}

        //Diagonal 3
        try {
            if(arr[key[0]+1][key[1]-1] == inUseChar){

                totalWeigth += plusOne;
                try {
                    if(arr[key[0]+2][key[1]-2] == inUseChar){
                        totalWeigth += plusTwoo;
                    }
                } catch (Exception e) {}
            }
        } catch (Exception e) {}

        //Diagonal 4
        try {
            if(arr[key[0]+1][key[1]+1] == inUseChar){

                totalWeigth += plusOne;
                try {
                    if(arr[key[0]+2][key[1]+2] == inUseChar){
                        totalWeigth += plusTwoo;
                    }
                } catch (Exception e) {}
            }
        } catch (Exception e) {}

        return totalWeigth;
    }

}