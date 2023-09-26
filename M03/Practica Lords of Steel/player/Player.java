package player;
import weapon.Weapon;

public abstract class Player {
    
    private String name;
    private int strength, constitution, velocity, intelligence, luck;

    private int startPs;
    private int ps, pd, pa, pe;

    private Weapon weapon;
    
    private int statPoints;

    private int pex = 0, niv = 0;

    private String playerClass, playerOrder;


    public Player(String name, int strength, int constitution, int velocity, int intelligence, int luck, Weapon weapon, int statPoints, String playerClass, String playerOrder){

        this.name = name;

        this.strength = strength;
        this.constitution = constitution;
        this.velocity = velocity;
        this.intelligence = intelligence;
        this.luck = luck;

        this.weapon = weapon;

        this.statPoints = statPoints;

        this.playerClass = playerClass;
        this.playerOrder = playerOrder;
    }


    // Getters and setters of the priary stats
    public String getName(){
        return this.name;
    }
    public int getStrength(){
        return this.strength;
    }
    public int getConstitution(){
        return this.constitution;
    }
    public int getVelocity(){
        return this.velocity;
    }
    public int getIntelligence(){
        return this.intelligence;
    }
    public int getLuck(){
        return this.luck;
    }

    public void setStrength(int strength) {
        this.strength = strength;
    }
    public void setConstitution(int constitution) {
        this.constitution = constitution;
    }
    public void setVelocity(int velocity) {
        this.velocity = velocity;
    }
    public void setIntelligence(int intelligence) {
        this.intelligence = intelligence;
    }
    public void setLuck(int luck) {
        this.luck = luck;
    }

    //Getter for the Weapon
    public Weapon getWeapon() {
        return weapon;
    }

    //Getter for the statPoints
    public int getStatPoints() {
        return statPoints;
    }

    // Getters and setters of the secondary stats
    public int getStartPs() {
        return startPs;
    }
    public int getPs(){
        return this.ps;
    }
    public int getPd(){
        return this.pd;
    }
    public int getPa(){
        return this.pa;
    }
    public int getPe(){
        return this.pe;
    }

    public void setStartPs(int startPs) {
        this.startPs = startPs;
    }
    public void setPs(int ps){
        this.ps = ps;
    }
    public void setPd(int pd){
        this.pd = pd;
    }
    public void setPa(int pa){
        this.pa = pa;
    }
    public void setPe(int pe){
        this.pe = pe;
    }

    // Getters for the player class and order
    public String getPlayerClass() {
        return playerClass;
    }
    public String getPlayerOrder() {
        return playerOrder;
    }


    public void setPrimaryStats(int strength, int constitution, int velocity, int intelligence, int luck){
        this.strength = strength;
        this.constitution = constitution;
        this.velocity = velocity;
        this.intelligence = intelligence;
        this.luck = luck;
    }

    public int getPex() {
        return pex;
    }
    public int getNiv() {
        return niv;
    }


    // Abstract Method
    public abstract void calcSecondaryStats();

    // Other Methods
    public void getDamage(int damage){
        this.ps -= damage;
    }

    public void restorePs(){
        calcSecondaryStats();
    }

    public void augmentPex(int pexQuant, int looserPS){
        this.pex += pexQuant + looserPS;
        upgradeNiv();
    }

    public void upgradeNiv(){

        if(this.niv == 0 && this.pex >= 100){
            upNiv(100);
        }else if(this.niv == 1 && this.pex >= 200){
            upNiv(200);
        }else if(this.niv == 2 && this.pex >= 500){
            upNiv(500);
        }else if(this.niv == 3 && this.pex >= 1000){
            upNiv(1000);
        }else if(this.niv >= 4 && this.pex >= 2000){
            upNiv(2000);
        }
    }

    private void upNiv(int pexQuant){
        this.niv += 1;
        this.pex -= pexQuant;
        this.statPoints += 5;

        this.strength += 1;
        this.constitution += 1;
        this.velocity += 1;
        this.intelligence += 1;
        this.luck += 1;

        calcSecondaryStats();
    }

}
