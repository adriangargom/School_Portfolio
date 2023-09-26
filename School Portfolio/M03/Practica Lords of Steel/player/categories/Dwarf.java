package player.categories;
import player.Player;
import weapon.Weapon;

public class Dwarf extends Player{
    
    public Dwarf(String name, int strength, int constitution, int velocity, int intelligence, int luck, Weapon weapon, int statPoints, String playerOrder){
        super(name, strength, constitution, velocity, intelligence, luck, weapon, statPoints, "Dwarf", playerOrder);
        
        calcSecondaryStats();
        setStartPs(getPs());
    }

    @Override
    public void calcSecondaryStats() {
        
        setPs((getConstitution() + getStrength()));
        setPd(((getStrength() + getWeapon().getwPow() + getConstitution()) / 4)); // <----- Special
        setPa((getIntelligence() + getLuck() + getWeapon().getwVel()));
        setPe((getVelocity() + getLuck() + getIntelligence()));
    }
}
