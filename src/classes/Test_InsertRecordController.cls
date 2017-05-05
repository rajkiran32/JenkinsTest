@isTest
public class Test_InsertRecordController{

public static testmethod void method1(){

  InsertRecordController irs = new InsertRecordController ();



Test.setCurrentPageReference(new PageReference('Page.InsertRecord'));
irs.Account.Name='Techm';
irs.Account.accountNumber='';


      
irs.save();
irs.Back();


}

}