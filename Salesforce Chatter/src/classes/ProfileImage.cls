Public class ProfileImage
{ 
public String uName { get; set; }
public string UserfullPhoto{get;set;}
public string UserSmallPhoto{get;set;}
Public String groupId { get; set; }
public string groupOptions{get;set;}   
            
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

               Public ProfileImage()
                {
                User u = [Select id, Name, u.SmallPhotoUrl, u.FullPhotoUrl From User u where u.id=:Userinfo.getUserid()];
                UserfullPhoto = u.FullPhotoUrl;
                UserSmallPhoto = u.SmallPhotoUrl;
                }
          
          
          public PageReference picchange() 
          {
            System.debug(uName);
            User  p = [Select Name, SmallPhotoUrl, FullPhotoUrl From User where Id=:uName];
            UserfullPhoto = p.FullPhotoUrl;
            UserSmallPhoto = p.SmallPhotoUrl;            
            return null;
          }  
}