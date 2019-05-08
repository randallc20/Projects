import javax.swing.JButton;
import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Random;

public class ColorButton extends JButton
{
  private Color myColor;
  private Ball myTarget;
  private boolean random = false;

  public ColorButton(String buttonName, boolean random, Ball target)
  {
    this("Random",Color.WHITE,target);
    this.random = true;
  }
  public ColorButton(String buttonName, Color newColor, Ball target)
  {
    super(buttonName);
    myTarget = target;
    myColor = newColor;
    class ColorListener implements ActionListener
    {
      public void actionPerformed(ActionEvent event)
      {
        System.out.println(random);
        if(random)
        {
          Random rn = new Random();
          myColor = new Color(rn.nextInt(255),rn.nextInt(255),rn.nextInt(255));
        }
        myTarget.changeColor(myColor);
      }
    }
    ActionListener listener = new ColorListener();
    addActionListener(listener);
  }
}
