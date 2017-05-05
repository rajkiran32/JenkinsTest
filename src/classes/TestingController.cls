Public class TestingController{


public TestingController(){

}

public static void beforeInsertRecord(List<testing__c> testNew){

System.debug('  -First method--   ');

for(testing__c listnew :testNew){

if(listnew.Name!=null){
listnew.Name = 'before insert current record';
}


}


}
public static void beforeUpdateRecord(List<testing__c> testNew){

System.debug('  -First update method--   ');

for(testing__c listnew :testNew){

if(listnew.Name!=null){
listnew.Name = 'before update current record';
}


}

}

public static void afterInsertRecord(List<testing__c> testNew){

System.debug('  -First update method--   ');

List<Opportunity> opp = [Select Id from Opportunity limit 1];
List<Account> acc = [Select Id from Account limit 1];
List<Case> cas = [Select Id from Case limit 1];

Evening_Object__c evObject = new Evening_Object__c();
for(testing__c listnew :testNew){
evObject.testing__c = listnew.Id;
evObject.Name = 'afterInsertRecord Creation';            
evObject.Account_Name__c = acc[0].Id;
evObject.Case__c = cas[0].Id;
evObject.Opportunity__c = opp[0].Id;
evObject.Phone__c ='8106269898';

}
insert evObject;

}


public static void afterUpdateRecord(List<testing__c> testNew){

List<Evening_Object__c>  listEve = new List<Evening_Object__c>();
List<Evening_Object__c> listRe = [Select Id, Name from Evening_Object__c where testing__c=: testNew[0].Id];
for(Evening_Object__c listnew : listRe){
listnew.Name = 'afterUpdateRecord Creation12345';

listEve.add(listnew);
}
update listEve;


}

}