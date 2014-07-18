global class FeedItemPoster {

  global static ConnectApi.FeedItem postTextFeedItem(String feedItemText) {
    ConnectApi.FeedItemInput feedItemInput = FeedBodyParser.convertToFeedItemInput(feedItemText);       
    return ConnectApi.ChatterFeeds.postFeedItem(null, ConnectApi.FeedType.News, 'me', feedItemInput, null);
  }
        
  global static ConnectApi.FeedItem postFileFeedItem(String feedItemText, Blob fileBlob, String title, String description, String filename) {
      ConnectApi.FeedItemInput feedItemInput = FeedBodyParser.convertToFeedItemInput(feedItemText);

      // file attachment
      ConnectApi.NewFileAttachmentInput fileIn = new ConnectApi.NewFileAttachmentInput();
      fileIn.title = title; // user-given "name" is set using the title
      fileIn.description = description;

      feedItemInput.attachment = fileIn;

      ConnectApi.BinaryInput feedBinary = new ConnectApi.BinaryInput(fileBlob, null, filename);

      return ConnectApi.ChatterFeeds.postFeedItem(null, ConnectApi.FeedType.News, 'me', feedItemInput, feedBinary);
  }

  global ConnectApi.FeedItem postLinkFeedItem(String feedItemText, String linkName, String linkUrl) {
      ConnectApi.FeedItemInput feedItemInput = FeedBodyParser.convertToFeedItemInput(feedItemText);

      ConnectApi.LinkAttachmentInput linkIn = new ConnectApi.LinkAttachmentInput();
      linkIn.urlName = linkName;
      linkIn.url = linkUrl;

      feedItemInput.attachment = linkIn; 

      return ConnectApi.ChatterFeeds.postFeedItem(null, ConnectApi.FeedType.News, 'me', feedItemInput, null);
    }
}