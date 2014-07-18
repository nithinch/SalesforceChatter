public with sharing class FileUploadController {
public String partsglobal{get;set;}
public Document document {
    get {
      if (document == null)
        document = new Document();
      return document;
    }
    set;
  }
 
  public PageReference upload() {
 
    document.AuthorId = UserInfo.getUserId();
    document.FolderId = UserInfo.getUserId(); // put it in running user's folder
 
    try {
      insert document;
      User u = [SELECT id FROM User WHERE id = :UserInfo.getUserId()];
      
      FeedItem post = new FeedItem();
post.ParentId = u.id; //eg. Opportunity id, custom object id..
post.Body = document.description;
post.ContentData = document.body;
/*post.ContentFileName =document.name + '.jpg';*/
String contentype=document.contentType;
List<String> parts =contentype.split('/',0);
        partsglobal= document.contentType;
        contentype= parts[parts.size()-1];
        post.ContentFileName =document.name + '.' + contentype;
       

insert post;



    } catch (DMLException e) {

   
      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading file'));
      return null;
    } finally {
      document.body = null; // clears the viewstate
      document = new Document();
    }
 
    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'File uploaded successfully'));
    return null;
  }
 
}