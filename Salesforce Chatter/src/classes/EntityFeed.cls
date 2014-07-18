Public class EntityFeed
{ 
public String uName { get; set; }
public String userFullPhoto{get;set;}
Public String groupId { get; set; }
public string groupOptions{get;set;}
              public List<selectOption> getAccounts() 
                {
                    List<selectOption> options = new List<selectOption>(); 
                     options.add(new selectOption('', ''));
                    for (account accounts: [SELECT Id, Name FROM Account]) 
                    { 
                        options.add(new selectOption(accounts.Id, accounts.Name)); 
                    }
                    return options; 
                }         
          public PageReference changeFlow() 
          {
          System.debug(uName);
      
            return null;
          }                  
            public List<AccountFeed> getRecentTextUpdates()
            {
                        List <AccountFeed> aEntityFeed = [SELECT Id, Type, 
                         CreatedById, CreatedBy.FirstName, CreatedBy.LastName,LastModifiedDate,
                         ParentId, Parent.Name, 
                         Body, Title, LinkUrl, ContentData, ContentFileName,
                             (SELECT Id, FieldName,OldValue, NewValue 
                              FROM FeedTrackedChanges ORDER BY Id DESC), 
                             (SELECT Id, CommentBody, CreatedDate,
                              CreatedBy.FirstName, CreatedBy.LastName
                              FROM FeedComments ORDER BY CreatedDate LIMIT 10),
                             (SELECT CreatedBy.FirstName, CreatedBy.LastName
                              FROM FeedLikes)
                         FROM AccountFeed
                         WHERE ParentID = :uName
                         ORDER BY CreatedDate DESC, Id DESC
                         LIMIT 10];
            return aEntityFeed;
            }         
 }