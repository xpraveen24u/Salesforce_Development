public class StudentFeesStatus_Handler
{
    public static void FeesStudent(list<Student__c> stdlist)
    {
        list<Student_c> stduent=new list<Student_c>();
        list<Case> caselist=new list<Case>();
        for(Student__c std:stdlist)
        {
            Case case1=new Case();
            if(std.Fee_Status__c=='Defaulter')
            {
                //case1.Student__c=std.Id;
                case1.Subject='Defaulter Student'+std.Name;
                case1.Status='Escalated';
                case1.Origin='Web';
                caselist.add(case1);
            } 
        } 
        if(caselist.size()>0)
        {
            insert caselist;
        }
        
        list<Student_c> std12=[Select id,Casec from Student_c];
        System.debug(std12);
        for(Student__c std1: std12)
        {
            for(Case caselit :caselist )
            {
                std1.Case__c=caselit.Id;
                System.debug(std1);
                stduent.add(std1);   
            }
        }
        insert stduent;
    }
    
}