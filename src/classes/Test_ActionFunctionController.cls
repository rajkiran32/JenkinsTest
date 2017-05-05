@isTest
public class Test_ActionFunctionController{

public static testMethod void testMethod1(){

ActionFunctionController actController = new ActionFunctionController();

actController.getUsername();
actController.methodOne();
actController.sayHello();


actController.setState('n');
actController.getState();

}


}