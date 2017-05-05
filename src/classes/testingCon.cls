public class testingCon {



public static String testingRecord{get;set;}
public static List<testing__c> testingListRecord{get;set;}
public static String errorMessage{get;set;}

public testing__c test {get;set;}


    public testingCon(ApexPages.StandardController controller) {
    
    test = new testing__c();
    
    testingListRecord = [select id,Name from testing__c];
    
    
    testingRecord = testingListRecord[0].Name;
    
    }
    
    
    
public static String testName{get;set;}
   

public PageReference save(){


//test1.Name = test.Name;

if(test.Name !=null && String.valueOf(test.Name).Contains('test')){

Apexpages.Message myMessage = new ApexPages.Message(Apexpages.Severity.Error,'Please Correct the Name and Proceed');
Apexpages.addMessage(myMessage);

errorMessage = 'Please Correct the Name and Proceed';

}



System.debug(' errorMessage   '+errorMessage);
if(errorMessage==null)
insert test;
//return type -- NULL -- it refers current page and will not invoke the class.

testName = test.Name;

PageReference pageRefer = new PageReference('/apex/DisplayPageContent?id='+test.Id);
pageRefer.setRedirect(true);



return pageRefer;
}



}