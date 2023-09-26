package ia;

public class Ia {
    
    //Easy Game Mode
    public char[][] easyMode(char[][] arr, char playerChar){
        EasyMode em = new EasyMode();
        arr = em.makeDecision(arr, playerChar);
        em = null;
        return arr;
    }

    //Hard Game Mode
    public char[][] hardMode(char[][] arr, char robotChar){
        HardMode hm = new HardMode();
        hm.checkWeigths(arr, robotChar);
        hm = null;
        return arr;
    }
}
