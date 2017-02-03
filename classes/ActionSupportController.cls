public class ActionSupportController {


    Integer count = 10;
                        
    public PageReference incrementCounter() {
            count--;
            return null;
    }
                    
    public Integer getCount() {
        return count;
    }
}