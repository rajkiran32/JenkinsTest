public class DesignationController{

     //constructor
     public DesignationController(){
     }


    public void designationInsert(List<Designation__c> newVlues){
   
    for(Designation__c designation : newVlues){
        designation.Designation__c = 'updating value with the help of trigger testing';
        System.debug('inserted successfuly');
    }
   // new DesignationController().executeMethod();
    
    }
 @TestVisible
 private void designationUpdate(List<Designation__c> newVlues){
 
 for(Designation__c designation : newVlues){
        designation.Designation__c = 'updating value with the help of trigger testing11111';
        System.debug('inserted successfuly');
    }
    
 }
    
    

}