/*
 * @author      Santhosh N
 * @description Logic for Class Enrollment
 */ 
  
public class EnrollClassController{
    //TO DO: decide transient variables to avoid viewstate issues
    public boolean isNew           { get;set; }
    public boolean isNewStud { get; set; }
    public boolean newClassCreated    { get;set; }
    public boolean showSaveBtn    { get;set; }
    public boolean classSelected    { get;set; }
    public boolean isStudEdit   { get;set; }
    public boolean isStudMsg    { get;set; }
    
    public String className    { get;set; }
    public String selectedClassId    { get;set; }
    public String studSelected { get; set; }
    public String clsName    { get;set; }
    public String studName  { get;set; }
    public String selectedStudId    { get;set; }
    public String clsCode   { get;set; }
    
    public Class__c cls           { get;set; }
    public Student__c stud        { get;set; }
    public EnrollClass__c eClass        { get;set; }
    
    public list<Class__c> classes    { get;set; }
    public list< StudentWrapper > studList    { get;set; }
    public list<Class__c> searchResult  { get;set; }    
    public list<Student__c> studResult  { get;set; }
    public list<EnrollClass__c> existingStuds { get;set; }
    public list<Student__c> existStuds  { get;set; }
    
    public Integer classSize    { get { return classes.size(); } set; }
    public Integer searchResSize    { get { return searchResult.size(); } set; }
    public Integer studResultSize    { get { return studResult.size(); } set; }
    public Integer existingStudsSize { get { return existingStuds.size(); } set; }
    public Integer existStudSize    { get { return existStuds.size(); } }
    
    public EnrollClassWrapper eClassWrap    { get;set; }
    public StudentWrapper studWrap  { get;set; }
    
    public List<Student__c> studs {get; set;}
    public list<Student__c> validStuds;
    public Integer studInsertedSize { get { return validStuds.size(); } }
    
    public String today {
        get 
        {
            return Datetime.now().format('EE, MMMMM dd, yyyy');
        }
    }
    
    public EnrollClassController(){
        cls = new Class__c();
        stud = new Student__c();
        classes = new list<Class__c>();
        isNew = false;
        isNewStud  = false;
        showSaveBtn = false;
        classSelected = false;
        isStudEdit = false;
        studList = new list< StudentWrapper >();
        eClassWrap = new EnrollClassWrapper();
        searchResult   = new list<Class__c>();
        existingStuds = new list<EnrollClass__c>();
        existStuds = new list<Student__c>();
        studResult = new list<Student__c>();
        newClassCreated = false;
        isStudMsg = false;
        
        studs = new List<Student__c>();
        validStuds = new list<Student__c>();
        studs.add(new Student__c());
        
        recentClasses();
    }
    
    
    public void searchClasses()
    {
        if(String.isNotEmpty(className)){
            String queryStr = 'Select Id, Name, Class_Code__c From Class__c Where Name LIKE \''+className+'%\'';
            searchResult = Database.query(queryStr);
        }else{
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING,'Search input cannot be empty.'));
            return;
        }
    }
    
    public void searchStudents()
    {
        if(String.isNotEmpty(studName)){
            String queryStr = 'Select Id, Name, Name__c, Status__c From Student__c Where Name__c LIKE \''+studName+'%\' OR Name LIKE \''+studName+'%\'';
            studResult = Database.query(queryStr);
        }else{
            isStudMsg = true;
            studResult.clear();
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING,'No Records found. Please try again.'));
            return;
        }
    }
    
    public void showStudents()
    {
        studList.clear();
        classSelected = true;
        existingStuds = [Select ClassName__c, Student__c, Id From EnrollClass__c Where ClassName__c =: selectedClassId];
        set<Id> studIds = new set<Id>();
        for(EnrollClass__c eClass : existingStuds)
        {
            studIds.add(eClass.Student__c);
        }
        
        for(Student__c stud : [Select Id, Name, Status__c, Name__c From Student__c Where Id IN: studIds])
        {
            StudentWrapper studWrap = new StudentWrapper();
            studWrap.stud = stud;
            studList.add(studWrap);
        }
        
        //studList.sort();
        
    }
    
    public void showEdit(){
        isStudEdit = true;
        stud = [Select Id, Name, Name__c, Status__c From Student__c Where Id =: selectedStudId];
    }
    
    public void showNew(){
        isNew = true;
        isStudEdit = false;
        showSaveBtn = true;
        cls= new Class__c();
    }
    
    public void saveAllRecords()
    {
        //TO DO: exception handling
        if(isNew && !newClassCreated){
            isNew = false;
            cls = new Class__c(Name = clsName, Class_Code__c= clsCode);
            Database.SaveResult saveRes = Database.insert(cls, false);
            
            if (saveRes.isSuccess()) {
                isStudMsg = false;
                newClassCreated = true;
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Class inserted successfully.'));
            }
            else {
                // Operation failed, so get all errors                
                for(Database.Error err : saveRes.getErrors()) {
                    newClassCreated = false;
                    String error = 'The following error has occurred.\n';
                    error+= err.getStatusCode() + ': ' + err.getMessage()+'\n';
                    error+='Class fields that affected this error: ' + err.getFields();
                    
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Class insert failed.\n'+ error));
                }
            }
        }
        
     
        
        recentClasses();
    }
    
    public void cancel()
    {
        isNew = false;    
        isNewStud = false;
        newClassCreated = false;
        isStudEdit = false;
    }
    
    public void showNewStud()
    {
        isNewStud = true;
        stud = new Student__c();
        //studWrap = new StudentWrapper();
        
    }
    
    public void recentClasses()
    {
        classes = [Select Id, Name, Class_Code__c From Class__c Where CreatedDate = TODAY];
    }
    
    public void saveStudent(){
        //TO DO: Exception handling
        //list<EnrollClass__c> eClassList = new list<EnrollClass__c>();
        //check for existing students
        String studId = stud.Id;
        //if(String.isNotEmpty(studId)){
            //sName = String.escapeSingleQuotes(sName)+'%';
        existStuds = [Select Id, Name, Name__c, Status__c From Student__c Where Id =: studId]; 
        
        if(!existStuds.isEmpty()){
            update stud;  
           
        }else{
            /*validStuds = new list<Student__c>();
            if(studs <> null){
                for(Student__c stud : studs){
                    String sName = stud.Name__c;
                    if(String.isNotEmpty(sName)){
                        validStuds.add(stud);
                    }
                }
                
                if(!validStuds.isEmpty()){
                    insert validStuds;
                }
                
                for(Student__c stud : validStuds)
                {
                    EnrollClass__c eClass = new EnrollClass__c(ClassName__c=selectedClassID, Student__c = stud.Id);
                    eClassList.add(eClass);
                }
            }
            
            if(!eClassList.isEmpty()){
                insert eClassList;
            }*/
            insert stud;
        }
         
        EnrollClass__c eClass = new EnrollClass__c(ClassName__c=selectedClassID, Student__c = stud.Id);
        insert eClass;
        
        stud = new Student__c();
        showStudents();
    }
    
    public class EnrollClassWrapper{
        public EnrollClass__c  eClass{ get;set; }
        public boolean studSelected { get;set; }
        
        public EnrollClassWrapper(){
        
        }
    }    
    
    public class StudentWrapper{
        public Student__c stud         { get;set; }
        public boolean studSelected    { get;set; }
        
        public StudentWrapper(){
        
        }
    }
    
    public void deleteStuds(){
        //list<StudentWrapper> delStudWrapper = new list<StudentWrapper>();
        list<Student__c> delStuds = new list<Student__c>();
        list<StudentWrapper> remainingStuds = new list<StudentWrapper>();
        for(StudentWrapper sWrap : studList){
            if(sWrap.studSelected){
                delStuds.add(sWrap.stud);
            }else{
                remainingStuds.add(sWrap);
            }
        }
        
        if(!delStuds.isEmpty()){
            delete delStuds;
        }
        
        studList = remainingStuds;
        
        searchStudents();
    }
    
    public void addrow(){
        studs.add(new Student__c());
    }
}