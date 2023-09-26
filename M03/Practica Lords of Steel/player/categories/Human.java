package player.categories;
import player.Player;
import weapon.Weapon;

public class Human extends Player{

    public Human(String name, int strength, int constitution, int velocity, int intelligence, int luck, Weapon weapon, int statPoints, String playerOrder){
        super(name, strength, constitution, velocity, intelligence, luck, weapon, statPoints, "Human", playerOrder);
        
        calcSecondaryStats();
        setStartPs(getPs());
    }

    @Override
    public void calcSecondaryStats() {
        

        setPs((getConstitution() + getStrength() + getIntelligence())); // <----- Special
        setPd(((getStrength() + getWeapon().getwPow()) / 4));
        setPa((getIntelligence() + getLuck() + getWeapon().getwVel()));
        setPe((getVelocity() + getLuck() + getIntelligence()));
    }
}
