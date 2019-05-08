import java.awt.Graphics;
import java.awt.Graphics2D;
import javax.swing.JComponent;
import java.awt.geom.Ellipse2D;
import java.awt.event.MouseListener;
import java.awt.event.MouseEvent;
import javax.swing.JFrame;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.Color;
import java.awt.Dimension;

public class BallProject
{
  public static void main(String[] Args) 
  {
    JFrame frame = new JFrame();
    JFrame frame2 = new JFrame();
    //frame.setSize(800,600);
    
    frame.setSize(800,600);
    frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    frame2.setSize(200,100);
    frame2.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    final Ball ball = new Ball();
    
    ColorButton buttonRed = new ColorButton("Red",Color.RED,ball);
    ColorButton buttonGreen = new ColorButton("Green",Color.GREEN,ball);
    ColorButton buttonYellow = new ColorButton("Yellow",Color.YELLOW,ball);
    ColorButton buttonRandom = new ColorButton("Random",true,ball);
    JPanel colorChart = new JPanel();
    colorChart.add(buttonRed);
    colorChart.add(buttonGreen);
    colorChart.add(buttonYellow);
    colorChart.add(buttonRandom);
    frame2.add(colorChart);
    
    class MousePressListener implements MouseListener
    {
      private int x = 0;
      private int y = 0;
      public boolean created = false;
      public void mousePressed(MouseEvent event)
      {
        x = event.getX();
        y = event.getY();
        if(!created)
        {
          System.out.println(x + " and " + y);
        }
        else
        {
          ball.moveBall(x,y);
        }
      }
      public void mouseReleased(MouseEvent event) 
      {
        if (!created)
        {
          int x2 = event.getX();
          int y2 = event.getY();
          int r = (int)(Math.sqrt(Math.pow((1.0*x2-x),2) + Math.pow((1.0*y2-y),2)));
          ball.setCoords(x,y,r);
          created = true;
        }
      }
      public void mouseClicked(MouseEvent event)
      {
      }
      public void mouseEntered(MouseEvent event)
      {
      }
      public void mouseExited(MouseEvent event)
      {
      }
    }
    MouseListener listener = new MousePressListener();
    frame.addMouseListener(listener);
    frame.add(ball);
    frame.setVisible(true);
    frame2.setVisible(true);
    while (true)
    {
      ball.move();
      try
      {
        Thread.sleep(10);
      }
      catch (InterruptedException e)
      {
      }
    }
    
  }
}