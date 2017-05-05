public class CurrentpageController {

    public PageReference Back() {
        return  new PageReference('/apex/InsertRecord?id='+strId); 
    }
    
    public Boolean flag{get;set;}
    public String message{get;set;}

public String strId = ApexPages.currentPage().getParameters().get('id');// adding the parameters in the cache.
    
public Account account{get;set;}



    public CurrentpageController(){
    try{
    if(strId!=null || strId!= ''){
    System.debug('   --   '+strId);
   account = [SELECT Id, Name,Site,type,accountNumber FROM Account  where Id = : strId];
   }
   }catch(exception e){
    message = 'Currently you do not have reocrds';
   }
   
 //new CurrentpageController().executeMethod();
}
 
   
    
}