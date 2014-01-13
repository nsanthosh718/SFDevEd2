public with sharing class NewStudentExt {
    public List<Student__c> studs {get; set;}
    public list<Student__c> validStuds;
    public Integer studInsertedSize { get { return validStuds.size(); } }
    
    public NewStudentExt(){
        studs = new List<Student__c>();
        validStuds = new list<Student__c>();
        studs.add(new Student__c());
    }
    
    public void addrow(){
        studs.add(new Student__c());
    }
    
    public PageReference save(){
        validStuds = new list<Student__c>();
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
        }
        return null;
    }

}