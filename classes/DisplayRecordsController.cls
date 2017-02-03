public class DisplayRecordsController {


public List<Account> accounts{get;set;}
     
    public DisplayRecordsController() {
 accounts = [Select Name, Description, Phone from Account];

    }
}