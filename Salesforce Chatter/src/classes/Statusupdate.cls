global with sharing class Statusupdate {
public string UserSmallPhoto{get;set;}
public String feedUpdate { get; set; }

public String textUpdate {get; set; }
 private static String communityId = null;
        Public Statusupdate()
        {
           User u = [Select id, Name, u.SmallPhotoUrl, u.FullPhotoUrl From User u where u.id=:Userinfo.getUserid()];            
                    UserSmallPhoto = u.FullPhotoUrl;
                   
        }

        public PageReference go()
        {
                User u = [SELECT id FROM User WHERE id = :UserInfo.getUserId()];
                FeedItem fItem = new FeedItem();
                fItem.Type = 'TextPost';
                fItem.ParentId = u.id;
                fItem.Body = this.feedUpdate;
                insert fItem;
                return null;
        }
        
        public   PageReference likestatus()
        {
               ConnectApi.ChatterFeeds.likeFeedItem(null, '0D59000000dKjHbCAK');
               return  null;
        }
        public   PageReference deletelike()
        {
              try
               {
               ConnectApi.ChatterFeeds.deleteLike(null, '0I090000000xMaACAU');
               return  null;
               }
               catch(exception e)
               {
               System.debug('---------> Reach to here');
               return  null;
               }
               
               
               
        }
         
         
        public List<FeedItem> getRecentTextUpdates1() 
        {
        List <feeditem> aNewsFeed = [SELECT Id,Type, CreatedDate, CreatedBy.name, Body,LikeCount FROM FeedItem WHERE Type='TextPost' ORDER BY CreatedDate DESC];
        return aNewsFeed;
        }
        
        public List<FeedComment> getrecentComments() 
        {
        List <FeedComment> aNewsFeed = [SELECT Id, FeedItemId, CommentBody, IsDeleted, InsertedById, CommentType, RelatedRecordId FROM FeedComment   LIMIT 10];
        return aNewsFeed;
        }
        
        
        @RemoteAction   
        global static  string  feedUnlike(string feedId)     
        {
            List <UserFeed> UnlikeList= [SELECT (SELECT fs.Id,InsertedById  FROM FeedLikes fs where CreatedById=:Userinfo.getUserid() and FeedItemId=:feedId)  
                                         FROM UserFeed where Id=:feedId];
           ConnectApi.ChatterFeeds.deleteLike(null,UnlikeList[0].FeedLikes[0].Id);
           return  UnlikeList[0].FeedLikes[0].Id;
   
        }
        
        @RemoteAction   
        global static  string  feedLike(string feedId)     
        {
            ConnectApi.ChatterFeeds.likeFeedItem(null, feedId);
           
           List <UserFeed> likeList= [SELECT (SELECT fs.Id,InsertedById  FROM FeedLikes fs where CreatedById=:Userinfo.getUserid() and FeedItemId=:feedId)
                                     FROM UserFeed where Id=:feedId];
           return  likeList[0].FeedLikes[0].Id;
        }
        
        @RemoteAction   
        global static  string  feedComment(string feedId,string text)     
        {
        
        ConnectApi.ChatterFeeds.postComment(null, feedId,text);
         
         return 'success';  
        }
        
        @RemoteAction   
        global static  List<FeedComment>  feedloadComment(string feedId)     
        {
        
         List <FeedComment> commentList= [ SELECT CommentBody FROM FeedComment  WHERE FeedItemId=:feedId];
        return commentList;
        
        /*ConnectApi.ChatterFeeds.getCommentsForFeedItem(null, feedId);*/
           
        }
        @RemoteAction   
        global static  List<FeedItem>  feedloadlikeDislike()     
        {
        
         List <FeedItem> LikeList= [ SELECT Id,LikeCount   FROM FeedItem WHERE Type='TextPost' ];
        return LikeList;  
        }
        
        @RemoteAction   
        global static  List<FeedComment>  loadComment()  
        {
        
         List <FeedComment> commentList= [ SELECT FeedItemId,CommentBody FROM FeedComment];
        return commentList;
           
        }
        
         @RemoteAction   
        global static  List<User>  ViewLikes(string feedId)  
        {
        
         List <FeedItem> LikeList= [SELECT (SELECT InsertedById,FeedItemId FROM FeedLikes where FeedItemId =:feedId) FROM FeedItem where Id=:feedId];
        
        List<User> viewList =new List<User>();
       
        
        for (Integer i=0;i<LikeList[0].FeedLikes.size();i++)
        {
        
       viewList.add([SELECT Name from User where Id=:LikeList[0].FeedLikes[i].InsertedById]);
       
      
        }
        return viewList ;
       }
       
        @RemoteAction   
       global static    List<List<String>> LoadUserLikes()  
        {
        
                
                
                List <FeedItem> LikeList=[SELECT (SELECT InsertedById,FeedItemId FROM FeedLikes) FROM FeedItem ];
                
                List<User> viewList =new List<User>();
        

                 List<List<String>> finalList = new List<List<String>>();
       
        
      for (Integer i=0;i<LikeList.size();i++)
        {
        
            for (Integer j=0;j<LikeList[i].FeedLikes.size();j++)
            {            
                 viewList.add( [SELECT Id,Name from User where Id=:LikeList[i].FeedLikes[j].InsertedById]);
             
            }
        }
        
       
        
        for(Integer i=0;i<LikeList.size();i++ )
        {
           
         
            for(Integer j=0;j<LikeList[i].FeedLikes.size();j++)
            {
           
                for(Integer k=0;k<viewList.size();k++)
                {
                    if(LikeList[i].FeedLikes[j].InsertedById == viewList[k].Id)
                    {                                              
                       //create the 'columns'
                       List<string> columns = new List<string>();
                      
                       columns.add(LikeList[i].FeedLikes[j].FeedItemId);
                       columns.add(viewList[k].Name);
                      
                      finalList.add(columns);
                      break;
                     
                     }
                  }
               }
             }
         return finalList;
       }
       
        
        
        
         
}