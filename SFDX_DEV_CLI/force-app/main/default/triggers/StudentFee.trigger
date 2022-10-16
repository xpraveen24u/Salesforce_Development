trigger StudentFee on Student__c (after insert,after update) {
   List<Student__c> studentList = new List<Student__c>();
for (Student__c student : Trigger.New) {
   studentList.add(student);
}
   if(recursiveClass.triggerEnd==true){
       recursiveClass.triggerEnd = false;
     StudentFeeStatus_Handler.FeesStudent(studentList);  
      // recursiveClass.stopTrigger();
      
   }

}