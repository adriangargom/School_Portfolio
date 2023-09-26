public class Cuenta {

    public int id;
    public int balance;

    //Account constructor
    public Cuenta(int id, int balance){

        this.id = id;
        this.balance = balance;
    }

    //Withdraw money
    public boolean retirar(int withdraw){

        if(this.balance - withdraw > 0){
            this.balance -= withdraw;
        }else{
            return false;
        }

        return true;
    }

    //Insert Money
    public boolean insertar(int insert){
        try {
            this.balance += insert;
        } catch (Exception e) {return false;}

        return true;
    }

    //Check Money
    public int checkMoney(){
        return this.balance;
    }

    //Check Id
    public int checkId(){
        return this.id;
    }

    //Transfer Money
    public boolean transference(Cuenta account, int quantity){

        try {
            this.balance -= quantity;
            account.balance += quantity;

        } catch (Exception e) {
            return false;
        }

        return true;
    }
}
