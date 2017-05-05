public class ActionSupportController {


    Integer count = 10;
    Integer count1 = 10;
                        
    public PageReference incrementCounter() {
             count--;
             count1++;
            return null;
    }
                    
    public Integer getCount() {
        return count;
    }
     public Integer getCount1() {
        return count1;
    }
}