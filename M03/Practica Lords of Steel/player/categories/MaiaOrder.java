package player.categories;
import color.Color;
import color.InterfaceColors;
import weapon.Weapon;

public class MaiaOrder extends Maia implements InterfaceOrder, InterfaceColors{
    
    public MaiaOrder(String name, int strength, int constitution, int velocity, int intelligence, int luck, Weapon weapon, int statPoints){
        super(name, strength, constitution, velocity, intelligence, luck, weapon, statPoints, "Order");
    }

    @Override
    public void restPS() {
        setPs(getPs() + ((getStartPs()* 10) / 100));
        setPs((getPs() >= getStartPs())? getStartPs():getPs());

        System.out.printf(Color.paint(" > %s restored PS\n", GREEN), getName());
    }
}
