@isTest
public class TestDesignationController{


@TestSetup
public static void genericMethod(){

List<Designation__c> designation = new List<Designation__c>();
List<Opportunity> opportunity = new List<Opportunity>();
List<New_Salesforce__c> newSFDC = new List<New_Salesforce__c>();


for(Integer a=0;a<=150;a++){
New_Salesforce__c newSFDC1 = new New_Salesforce__c();

newSFDC1.Name = 'New Test'+a;
System.debug(' new sfdc  ---  '+a);
newSFDC.add(newSFDC1);

}

insert newSFDC;


for(Integer b=0;b<=150;b++){

Opportunity newOppty = new Opportunity();

newOppty.CloseDate= System.Today()+10;
newOppty.Name= 'New Oppty'+b;
newOppty.StageName= 'Prospecting';
System.debug('Opportunity   ---  '+b);
opportunity.add(newOppty);
}
insert opportunity;


for(Integer c=0;c<=150;c++){

Designation__c desig = new Designation__c();
desig.DOB__c = System.Today();
desig.OpportunityM_D__c = opportunity[0].Id;
desig.Test_Salesforce__c = newSFDC[0].Id;
desig.Name = 'I love my India'+c;
desig.Email__c ='abc@abc.com';
desig.Mobile__c = '8106269898';
desig.Country__c= 'India';
System.debug('desig   ---  '+c);

designation.add(desig);
}
insert designation;

//create one user record one user profile

}


//first method
public static testmethod void method1(){

Test.startTest();
List<Designation__c> di = [select Id, Name from Designation__c];

for(Designation__c designat : di){

system.debug('  method 1 values ----   '+designat.Name);


}


Test.stopTest();
}

//second method
public static testmethod void method2(){

Test.startTest();

System.assertEquals(151,[select count() from Opportunity]);
System.assertEquals(151,[select count() from New_salesforce__c]);
 
//get the user record from user object 
List<Designation__c> di = [select Id, Name from Designation__c];
DesignationController con = new DesignationController();
con.designationUpdate(di);
Test.stopTest();
}


}