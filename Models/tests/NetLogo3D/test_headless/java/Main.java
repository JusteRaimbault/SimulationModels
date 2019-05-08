package nlheadless;

import org.nlogo.agent.Observer;
import org.nlogo.agent.World;
import org.nlogo.api.LogoException;
import org.nlogo.api.LogoListBuilder;
//import org.nlogo.core.LogoList;
import org.nlogo.headless.HeadlessWorkspace;

public class Main {

  public static void main(String[] args){

      try{

      HeadlessWorkspace workspace = HeadlessWorkspace.newInstance(false);

      System.out.println("Sucessfully opened 2d workspace");

      workspace.open("../Flocking.nlogo",false);
      workspace.command("setup");
      workspace.command("ask one-of turtles [show self]");

      HeadlessWorkspace workspace3d = HeadlessWorkspace.newInstance(true);

      System.out.println("Sucessfully opened 3d workspace");

      workspace3d.open("../Flocking3D.nlogo3d",false);
      System.out.println(workspace3d._world.is3d());

      workspace3d.command("setup");
      workspace3d.command("ask one-of turtles [show self]");

      for (int i = 0;i<100;i++){
        workspace.command("repeat 5 [go]");
        workspace.command("ask one-of turtles with [who = 0] [show (word xcor \" - \" ycor)]");
        workspace3d.command("repeat 5 [go]");
        workspace3d.command("ask one-of turtles with [who = 0] [show (word xcor \" - \" ycor \" - \" zcor)]");
      }


    }catch(Exception e){e.printStackTrace();}
  }


}
