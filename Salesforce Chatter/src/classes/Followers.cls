public class Followers { 


public String uName { get; set; } 
public String uid  {get;set;} 
         public List<selectOption> getUsers() 
                        {
                            List<selectOption> options = new List<selectOption>(); 
                            options.add(new selectOption('', 'Current User')); 
                            for (User users : [SELECT Id, Name FROM User ]) 
                            { 
                                options.add(new selectOption(users.Id, users.Name)); 
                            }
                            return options; 
                        }      
                        
         public followers()
             {
             uid=UserInfo.getUserId();    
             }     
         public PageReference followchange() 
          {
            uid=uName;            
            return null;
          }     
}