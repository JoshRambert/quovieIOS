//
//  ParseBuzzFeed.swift
//  quovieIOS
//
//  Created by Joshua  Rambert on 2/17/18.
//  Copyright © 2018 Joshua  Rambert. All rights reserved.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseDatabase

public class ParseBuzzFeed {
    
    //the arrays to store the strings in
    var buzzTitles = [String]();
    var buzzUrlImages = [String]();
    var buzzContent = [String]();
    var buzzWebsite = [String]();
    var buzzAuthors = [String]();
    
    func getBuzzFeed(){
        //assing the URL
        let url = NSURL(string: ConfigClass.shared.BF_URL);
        
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary{
                
                //Printing the JSON to the console
                print(jsonObj!.value(forKey: ConfigClass.shared.JSON_ARRAY)!)
                
                //getting the array and converting it into the local array
                if let articlesArray = jsonObj!.value(forKey: ConfigClass.shared.JSON_ARRAY) as? NSArray {
                    //Looping through the elements
                    for info in articlesArray{
                        //convert the elemtns to a dictinoary then get their values that way
                        if let infoDict = info as? NSDictionary{
                            
                            //get the titles and the other values
                            if let title = infoDict.value(forKey: ConfigClass.shared.JSON_TITLES){
                                //add them to the local array
                                self.buzzTitles.append((title as? String)!)
                            }
                            if let urlImages = infoDict.value(forKey: ConfigClass.shared.JSON_IMAGES){
                                self.buzzUrlImages.append((urlImages as? String)!)
                            }
                            if let content = infoDict.value(forKey: ConfigClass.shared.JSON_CONTENT){
                                self.buzzContent.append((content as? String)!)
                            }
                            if let websites = infoDict.value(forKey: ConfigClass.shared.JSON_WESBITE){
                                self.buzzWebsite.append((websites as? String)!)
                            }
                            if let authors = infoDict.value(forKey: ConfigClass.shared.JSON_AUTHORS){
                                self.buzzAuthors.append((authors as? String)!)
                            }
                        }
                    }
                }
                OperationQueue.main.addOperation({
                    //Call a function here that will add all the data to the database
                    self.writeBuzzFeed()
                })
            }
        }).resume()
    }
    //Create the function that will add it to the database
    func writeBuzzFeed(){
        //The database references
        let mRootRef: DatabaseReference!
        mRootRef = Database.database().reference();
        
        let mNewsRef = mRootRef.child("News IOS");
        let mBuzzRef = mNewsRef.child("BuzzFeed");
        let mTitles = mBuzzRef.child("Titles")
        mTitles.setValue(self.buzzTitles)
        
        let mContent = mBuzzRef.child("Content")
        mContent.setValue(self.buzzContent)
        
        let mAuthors = mBuzzRef.child("Authors")
        mAuthors.setValue(self.buzzAuthors)
        
        let mUrlImages = mBuzzRef.child("Url Images")
        mUrlImages.setValue(self.buzzUrlImages)
        
        let mWebsites = mBuzzRef.child("Websites")
        mWebsites.setValue(self.buzzWebsite)
    }
    
    //MARK -- shared class
    static let shared = ParseBuzzFeed();
}
