package player.categories;
import color.Color;
import color.InterfaceColors;
import weapon.Weapon;

public class MidleChaos extends Midle implements InterfaceChaos, InterfaceColors {
    
    public MidleChaos(String name, int strength, int constitution, int velocity, int intelligence, int luck, Weapon weapon, int statPoints){
        super(name, strength, constitution, velocity, intelligence, luck, weapon, statPoints, "Chaos");
    }

    @Override
    public boolean diceAtack(int diceResult) {
        int paPercentatge = (getPa() * 50) / 100;
        
        if(diceResult <= paPercentatge){

            System.out.printf(Color.paint(" > %s dodged and atacked!\n", GREEN), getName());
            return true;
        }

        return false;
    }
}
