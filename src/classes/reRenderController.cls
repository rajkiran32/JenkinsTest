public class reRenderController {

    public Integer value{get; private set;}
    public Integer amount{get; set;}
    public reRenderController (){
    value=0;
    }
    
    public PageReference increment(){
       value+= amount;
    return null;
    }
}