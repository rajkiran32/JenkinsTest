public class RenderController {

public static boolean flag{get;set;}
public RenderController(){



}
  public Boolean abool {get;set;}
    public Boolean bbool {get;set;}
    
    public Boolean sabool {get;set;}
    public Boolean sbbool {get;set;}
    public Boolean habool {get;set;}
    public Boolean hbbool {get;set;}
    public Boolean sabbool {get;set;}
    public Boolean habbool {get;set;}
    

 public void showA()
    {
        abool = true;
        check();
    }
    
     public void showB()
    {
        bbool = true;
        check();
    }   
     
     
     public void check()
    {
        if(abool == true && bbool == false)
        {
            sabool = false;
            sbbool = true;
            habool = true;
            hbbool = false;
            sabbool = true;
            habbool = false;
        }
        else if(abool == false && bbool == true)
        {
            sabool = true;
            sbbool = false;
            habool = false;
            hbbool = true;
            sabbool = true;
            habbool = false;
        }
        
    }   
}