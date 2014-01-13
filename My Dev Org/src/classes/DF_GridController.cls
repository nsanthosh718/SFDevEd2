public class DF_GridController {
    transient public list<Account> accts;
    
    
    public DF_GridController (){
        accts = [Select Id, Name From Account];
        
    }
    
    public list<Account> getAccounts(){ return accts; }
    
}