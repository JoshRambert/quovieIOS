//
//  ParseTech.swift
//  quovieIOS
//
//  Created by Joshua  Rambert on 2/17/18.
//  Copyright © 2018 Joshua  Rambert. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase
import FirebaseCore

//Parse the technology from off the internet
public class ParseTech {
    
    //The arrays to store the strings in
    var techTitles = [String]();
    var techUrlImages = [String]();
    var techContent = [String]();
    var techWebsites = [String]();
    var techAuthors = [String]();
    
    func getTech(){
        //assign the URL
        let url = NSURL(string: ConfigClass.shared.TECH_URL);
        
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary{
                
                //Getting the array and converting it into the loacl array
                if let articlesArray = jsonObj!.value(forKey: ConfigClass.shared.JSON_ARRAY) as? NSArray{
                    //Looping through all the elements
                    for info in articlesArray {
                        //Converting the elements to a dictionary then get their values that way
                        if let infoDict = info as? NSDictionary {
                            
                            //get the titles and the other values
                            if let title = infoDict.value(forKey: ConfigClass.shared.JSON_TITLES){
                                //add them to the local arrays at the top
                                self.techTitles.append((self.nullToNill(value: title as AnyObject) as? String)!)
                            }
                            if let urlImages = infoDict.value(forKey: ConfigClass.shared.JSON_IMAGES){
                                //add them to the local array
                                self.techUrlImages.append((self.nullToNill(value: urlImages as AnyObject) as? String)!)
                            }
                            if let content = infoDict.value(forKey: ConfigClass.shared.JSON_CONTENT){
                                self.techContent.append((self.nullToNill(value: content as AnyObject) as? String)!)
                            }
                            if let websites = infoDict.value(forKey: ConfigClass.shared.JSON_WESBITE){
                                self.techWebsites.append((self.nullToNill(value: websites as AnyObject) as? String)!)
                            }
                            if let authors = infoDict.value(forKey: ConfigClass.shared.JSON_AUTHORS){
                                self.techAuthors.append((self.nullToNill(value: authors as AnyObject) as? String)!)
                            }
                        }
                    }
                }
                OperationQueue.main.addOperation({
                    //call the function here that will add all the data to the database
                    self.writeTech()
                    //Clear the tech arrays
                    self.clearTech()
                })
            }
        }).resume()
    }
    func writeTech(){
        //The database references
        let mRootRef: DatabaseReference!
        mRootRef = Database.database().reference();
        
        let mNewsRef = mRootRef.child("News IOS");
        let mTechRef = mNewsRef.child("Tech");
        let mTitles = mTechRef.child("Titles");
        mTitles.setValue(self.techTitles);
        
        let mContent = mTechRef.child("Content")
        mContent.setValue(self.techContent)
        
        let mAuthors = mTechRef.child("Authors")
        mAuthors.setValue(self.techAuthors)
        
        let mUrlImages = mTechRef.child("Url Images")
        mUrlImages.setValue(self.techUrlImages)
        
        let mWebsite = mTechRef.child("Websites")
        mWebsite.setValue(self.techWebsites)
    }
    
    func clearTech(){
        self.techTitles.removeAll()
        self.techAuthors.removeAll()
        self.techContent.removeAll()
        self.techWebsites.removeAll()
        self.techUrlImages.removeAll()
    }
    
    func nullToNill(value: AnyObject?) -> AnyObject? {
        if value is NSNull{
            return "null" as AnyObject
        } else {
            return value
        }
    }
    
    //MARK -- shared class
    static let shared = ParseTech();
}
