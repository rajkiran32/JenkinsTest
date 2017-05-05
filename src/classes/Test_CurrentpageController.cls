@istest
public class Test_CurrentpageController{

public static testmethod void method1(){

CurrentpageController   cpc = new CurrentpageController();
cpc.Back();
cpc.flag = false;
cpc.account = new Account();

}
}