/*** Controller  ***/
public class PageMessageController {
    Account account;
  public  String message{get;set;}
    public PageReference save() {
    try{
        update account;
    }
    catch(DmlException ex){
        ApexPages.addMessages(ex);
    }
    return null;
    }

    public String getName() { 
        return 'PageMessageController';
    }

    public Account getAccount() {
    try{
        if(account == null)
        account = [select id, name, numberofemployees, numberoflocations__c from Account
        where id = :ApexPages.currentPage().getParameters().get('id')];
       
        }
        catch(Exception e){
            message = String.valueOf(e);  
        } return account;
    }
}