public class InsertRecordController {

public Account account{get;set;}
public static String strId = ApexPages.currentPage().getParameters().get('id');

 public InsertRecordController() {

    account = new Account();
     try{
    if(strId!=null || strId!= ''){
    System.debug('   --   '+strId);
   account = [SELECT Id, Name,Site,type,accountNumber,Industry,Phone FROM Account  where Id = : strId];
   }
   }catch(exception e){
   // message = 'Currently you do not have reocrds';
   } 
    }
    
    
 public PageReference save(){
  
 
  
   if(String.isBlank(account.accountNumber)) {
  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please enter AccountNumber'));
  }
  
  
        
      Account acc = new Account();
          acc.name =account.name;
          
        insert acc;
      return  new PageReference('/apex/CurrentpageRecords'); 
    /// return  null; 
       // Database.SaveResult[] results = Database.insert(contacts,false);
          
  
  }
  
  
  public PageReference Back(){
  Account acc = new Account();
  return  new PageReference('/apex/InsertRecord'); 
  }

}