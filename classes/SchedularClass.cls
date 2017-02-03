global class SchedularClass implements schedulable{

    global void execute(SchedulableContext sc){
    
    List<Messaging.SingleEmailMessage> mails = 
  new List<Messaging.SingleEmailMessage>();
  
  
     // Step 1: Create a new Email
      Messaging.SingleEmailMessage mail = 
      new Messaging.SingleEmailMessage();
    
      // Step 2: Set list of people who should get the email
      List<String> sendTo = new List<String>();
      sendTo.add('maheshbabu2k6@gmail.com');
      sendTo.add('smounika0506@gmail.com');
      sendTo.add('shailajapatel5115@gmail.com');
      sendTo.add('sampathtechm.sfdc@gmail.com');
      mail.setToAddresses(sendTo);
    
      // Step 3: Set who the email is sent from
      mail.setReplyTo('donotreply@salesforce.com');
      mail.setSenderDisplayName('Official Bank of India');
    
      // (Optional) Set list of people who should be CC'ed
      List<String> ccTo = new List<String>();
      ccTo.add('sampathreddy25.java@gmail.com');
      mail.setCcAddresses(ccTo);

      // Step 4. Set email contents - you can use variables!
      mail.setSubject('URGENT BUSINESS PROPOSAL');
      String body = 'Dear Team';
      body += 'I confess this will come as a surprise to you.';
      body += 'I am John Alliston CEO of the Bank of India.';
      body += 'I write to request your cooperation in this ';
      body += 'urgent matter as I need a foreign partner ';
      body += 'in the assistance of transferring $47,110,000 ';
      body += 'to a INDIA bank account. Please respond with ';
      body += 'your bank account # so I may deposit these funds.';
      mail.setHtmlBody(body);
    
      // Step 5. Add your email to the master list
      mails.add(mail);
    
  // Step 6: Send all emails in the master list
  Messaging.sendEmail(mails);
    }
}