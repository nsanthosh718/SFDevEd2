public class PaginationDemo{
    public list<Account> accs { get;set; }
    public Integer OFFSET_SIZE = 0;
    public static final Integer LIMIT_SIZE = 5;
    
    
    public PaginationDemo(){
        accs = new list<Account>();  
           
    }
    
    public list<Account> getAccounts()
    {
        accs = [Select Id, Name From Account LIMIT :LIMIT_SIZE OFFSET: OFFSET_SIZE];
        return accs;
    }
    
    public PageReference firstPage(){
        OFFSET_SIZE  = 0;
        return null;
    }
    
    public PageReference nextPage(){
        OFFSET_SIZE  += LIMIT_SIZE;
        return null;
    }
    
    public PageReference previousPage(){
        OFFSET_SIZE  -= LIMIT_SIZE;
        return null;
    }
    
}