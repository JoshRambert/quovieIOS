//
//  ParseSports.swift
//  quovieIOS
//
//  Created by Joshua  Rambert on 2/16/18.
//  Copyright © 2018 Joshua  Rambert. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase
import FirebaseCore

//Parse the data from off of the internet
public class ParseSports {
    
    //The arrays to store the strings in 
    var sportsTitles = [String]();
    var sportsUrlImages = [String]();
    var sportsContent = [String]();
    var sportsWebsite = [String]();
    var sportsAuthors = [String]();
    
    func getSports(){
        //assign the URL
        let url = NSURL(string: ConfigClass.shared.SPORTS_URL);
        
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
                //Getting the array and converting it into the local array
                if let articlesArray = jsonObj!.value(forKey: ConfigClass.shared.JSON_ARRAY) as? NSArray {
                    //Looping through the elements
                    for info in articlesArray {
                        //convert the elements to a dictionary then get their values that way
                        if let infoDict = info as? NSDictionary {
                            //Get the titles and and the other values
                            if let title = infoDict.value(forKey: ConfigClass.shared.JSON_TITLES){
                                //add them to the local array
                                self.sportsTitles.append((self.nullToNil(value: title as AnyObject) as? String)!)
                            }
                            if let urlImages = infoDict.value(forKey: ConfigClass.shared.JSON_IMAGES){
                                self.sportsUrlImages.append((self.nullToNil(value: urlImages as AnyObject) as? String)!)
                            }
                            if let content = infoDict.value(forKey: ConfigClass.shared.JSON_CONTENT){
                                self.sportsContent.append((self.nullToNil(value: content as AnyObject) as? String)!)
                            }
                            if let websites = infoDict.value(forKey: ConfigClass.shared.JSON_WESBITE){
                                self.sportsWebsite.append((self.nullToNil(value: websites as AnyObject) as? String)!)
                            }
                            if let authors = infoDict.value(forKey: ConfigClass.shared.JSON_AUTHORS){
                                self.sportsAuthors.append((self.nullToNil(value: authors as AnyObject) as? String)!)
                            }
                        }
                    }
                }
                OperationQueue.main.addOperation({
                    //Call a function here that will add all the data to the database
                    self.writeSports()
                    //Clear the arryas after writing the data
                    self.clearSports()
                })
            }
        }).resume()
    }
    //Create the function that will add it to the database
    func writeSports(){
        //The database references
        let mRootRef: DatabaseReference!
        mRootRef = Database.database().reference();
        
        let mNewsRef = mRootRef.child("News IOS");
        let mSportsRef = mNewsRef.child("Sports")
        let mTitles = mSportsRef.child("Titles")
        mTitles.setValue(self.sportsTitles);
        
        let mContent = mSportsRef.child("Content")
        mContent.setValue(self.sportsContent)
        
        let mAuthors = mSportsRef.child("Authors")
        mAuthors.setValue(self.sportsAuthors)
        
        let mUrlImages = mSportsRef.child("Url Images")
        mUrlImages.setValue(self.sportsUrlImages)
        
        let mWebsites = mSportsRef.child("Websites")
        mWebsites.setValue(self.sportsWebsite)
    }
    
    func clearSports(){
        self.sportsTitles.removeAll()
        self.sportsAuthors.removeAll()
        self.sportsContent.removeAll()
        self.sportsWebsite.removeAll()
        self.sportsUrlImages.removeAll()
    }
    
    func nullToNil(value: AnyObject?) -> AnyObject? {
        if value is NSNull{
            return nil
        } else {
            return value
        }
    }
    
    //MARK -- Shared class
    static let shared = ParseSports();
}
