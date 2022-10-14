public  class StudentFeeStatus_Handler {
    public static void FeesStudent(list<Student__c> stdlist)
    {
        list<Student__c> student=new list<Student__c>();
        list<Case> caselist=new list<Case>();
        list<Id> caseIds=new list<Id>();
        list<Id> studentIds=new list<Id>();
        Map<Id,String> mapN = new Map<Id,String> ();
        for(Student__c std:stdlist)
        {
            Case case1=new Case();
            if(std.Fee_Status__c=='Defaulter')
            {
                case1.Student__c=std.Id;
                case1.Subject='Defaulter Student'+std.Name;
                case1.Status='Escalated';
                case1.Origin='Web';
                caselist.add(case1);
                studentIds.add(std.Id);
                
            } 
        } 
        if(caselist.size()>0)
        {
            insert caselist;
        }

        List<Case> caseWithNumber = [SELECT Id, CaseNumber,Student__c FROM Case WHERE Student__c In :studentIds];
        if(!caseWithNumber.isEmpty()){
            for (Case cst : caseWithNumber) {
                mapN.put(cst.Student__c,cst.CaseNumber);
            }
        }

        List<Student__c> stuList = [SELECT Id, Student_Case__c FROM Student__c WHERE Id In: studentIds];
        if(!stuList.isEmpty()){
            for (Student__c stu : stuList) {
                stu.Student_Case__c = mapN.get(stu.Id);
        }
        
        update   stuList;
        }
        
 
    }
}
