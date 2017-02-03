trigger DesignationTrigger on Designation__c (before Insert, before Update,before Delete, 
                                                    after Insert,after Update,after Delete,after UnDelete){

DesignationController desig = new DesignationController();
//List<First_Setting__c> fsettings = First_Setting__c.getall().values();

//System.debug('-----    '+fsettings[0].Text__c);

if(trigger.isBefore){  // on same object


    if(trigger.isInsert){
        desig.designationInsert(trigger.new);      
    
    }
    if(trigger.isUpdate){
      System.debug('updated successfully');
       desig.designationInsert(trigger.new);        
    }
    if(trigger.isDelete){
    
    }
}
if(trigger.isafter){  // on realted objects
    if(trigger.isInsert){
    }
    if(trigger.isUpdate){
     //desig.designationInsert(trigger.new);
    }
    if(trigger.isDelete){
    }
    if(trigger.isUnDelete){
    }
}
}