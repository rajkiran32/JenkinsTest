public class runSchedularClass{

  



  public pageReference executeMethod(){
    
    SchedularClass scClass = new SchedularClass();
    String sch = '0 22 9 * * ?';// CronExpression

    System.schedule('testmail', '0 32 9 * * ?', new SchedularClass());
    
    //we can see in the corn trigger object

    
    return null;
    }   
   
}