import java.io.IOException;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.Scanner;
import java.io.FileWriter;

public class Main{
    public static void main(String[] args) throws IOException{

        Scanner scan = new Scanner(System.in);

        String path = "./data/log.txt";
        FileWriter fw = new FileWriter(path);

        ArrayList<Cuenta> accountList = Data.readData();
        HashMap<Integer, Cuenta> accounts = new HashMap<Integer, Cuenta>();


        for (int i = 0; i < accountList.size(); i++) {
            
            accounts.put(accountList.get(i).id, accountList.get(i));
        }

        //Ask the account nuber to log in and get the account from the HashMap
        System.out.print("Account Number : ");  
        int account = Integer.parseInt(scan.nextLine());
        Cuenta myAcount = accounts.get(account);

        boolean loop = true;

        //Main aplication Loop
        while(loop){

            System.out.println("Operation 0 => Withdraw money" );
            System.out.println("Operation 1 => Insert money" );
            System.out.println("Operation 2 => Check balance" );
            System.out.println("Operation 3 => Actual Account Id" );
            System.out.println("Operation 4 => Tranference" );
            System.out.println("Operation 5 => Check All Accounts" );
            System.out.println("Operation 6 => Create New Account" );
            System.out.println("Operation 7 => Exit" );

            System.out.print("Operation : ");
            int operation = Integer.parseInt(scan.nextLine());

            switch (operation) {
                case 0:
                    //Withdraw Money
                    int withdrawMoney = Integer.parseInt(scan.nextLine());
                    System.out.printf("Operation :> %s\n", myAcount.retirar(withdrawMoney));
                    fw.append("Account "+account+" whithdraw "+withdrawMoney+"€\n");
                    break;
                case 1:
                    //Insert Money
                    int insertMoney = Integer.parseInt(scan.nextLine());
                    System.out.printf("Operation :> %s\n", myAcount.insertar(insertMoney));
                    fw.append("Account "+account+" inserted "+insertMoney+"€\n");
                    break;
                case 2:
                    //Check the actual balance
                    System.out.printf("Actual Balance :> %s\n", myAcount.checkMoney());
                    fw.append("Account "+account+" check balance "+myAcount.checkMoney()+"€\n");
                    break;
                case 3:
                    //Check the actual loged in account ID
                    System.out.printf("Actual Id :> %s\n", myAcount.checkId());
                    fw.append("Account "+account+" check ID\n");
                    break;
                case 4:
                    //Transfer money from one account to another
                    System.out.print("ID of the account to transfer : ");
                    Cuenta transferAccount = accounts.get(Integer.parseInt(scan.nextLine()));
                    System.out.print("Quantity to transfer : ");
                    int quantity = Integer.parseInt(scan.nextLine());

                    System.out.printf("Operation Status :> %s\n", myAcount.transference(transferAccount, quantity));
                    fw.append("Account "+account+" transfered => "+quantity+"€ => to account " + transferAccount.id+"\n");
                    break;
                case 5:
                    //Check all the accounts
                    for (int i = 0; i < accounts.size(); i++) {
                        System.out.printf("Id : %s\nBalance : %s\n", accounts.get(i).checkId(), accounts.get(i).balance);
                        System.out.println("---------------------");
                    }
                    fw.append("Account "+account+" checked all accounts\n");
                    break;
                case 6:
                    //Create new Account
                    System.out.print("Account balance : ");
                    accounts.put(accounts.size(), new Cuenta(accounts.size(), Integer.parseInt(scan.nextLine())));
                    fw.append("Account "+account+" created new account => "+accounts.size()+"\n");
                    break;
                case 7:
                    //Exit application
                    loop = false;
                    fw.append("Account "+account+" exited the application\n");
                    break;
            }
            System.out.println();
        }

        Data.saveData(accounts);

        fw.close();
        scan.close();
        System.out.println("Bye ;D");
    }
}