import java.awt.Graphics;
import java.awt.Graphics2D;
import javax.swing.JComponent;
import java.awt.geom.Ellipse2D;
import java.awt.geom.Line2D;
import java.awt.Color;

public class Ball extends JComponent
{
  private int xspeed = 0;
  private int yspeed = 0;
  private int x = 10;
  private int y = 10;
  private int w = 0;
  private int h = 0;
  private int rad = 0;
  private Ellipse2D.Double ellipse;
  private Ellipse2D.Double border;
  private Color currentColor = Color.WHITE;
  public Ball()
  {
    ellipse = new Ellipse2D.Double(x+2,y+2,w-4,h-4);
    border = new Ellipse2D.Double(x,y,w,h);
    xspeed = 1;
    yspeed = 1;
  }
  public void setCoords(int xco, int yco, int r)
  {
    rad = r;
    x = xco - r;
    y = yco -r;
    w = 2*r;
    h = w;
    ellipse = new Ellipse2D.Double(x,y,w,h);
  }
  public void paintComponent(Graphics g)
  {
    Graphics2D g2 = (Graphics2D) g;
    g2.setColor(Color.BLACK);
    g2.fill(border);
    g2.setColor(currentColor);
    g2.fill(ellipse);
  }
  public void moveBall(int xnew, int ynew)
  {
    ellipse = new Ellipse2D.Double(xnew-(w/2),ynew-(h/2),w,h);
    repaint();
  }
  public void move()
  {
    if (y + h >= 600 || y <= 0)
    {
     yspeed = -yspeed;
    }
    if (x + w >= 800 || x <= 0)
    {
      xspeed = -xspeed;
    }
    x = x + xspeed;
    y = y + yspeed;
    
    border = new Ellipse2D.Double(x,y,w,h);
    ellipse = new Ellipse2D.Double(x+2,y+2,w-4,h-4);
    repaint();
  }
  public void changeColor(Color newColor)
  {
    currentColor = newColor;
  }
}