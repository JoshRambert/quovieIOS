//
//  ParseLifeStyle.swift
//  quovieIOS
//
//  Created by Joshua  Rambert on 2/17/18.
//  Copyright © 2018 Joshua  Rambert. All rights reserved.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseDatabase

public class ParseLifestyle {
    
    //The arrays to the store strings in
    var lsTitles = [String]();
    var lsUrlImages = [String]();
    var lsContent = [String]();
    var lsWebsite = [String]();
    var lsAuthors = [String]();
    
    func getLifeStyle(){
        //assing the URL
        let url = NSURL(string: ConfigClass.shared.LS_URL);
        
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary{
                
                //Printing the JSON to the console
                print(jsonObj!.value(forKey: ConfigClass.shared.JSON_ARRAY)!)
                
                //Getting the array and converting it into the local array
                if let articlesArray = jsonObj!.value(forKey: ConfigClass.shared.JSON_ARRAY) as? NSArray {
                    //Looping through the elemnts
                    for info in articlesArray {
                        //convert the elements to a dicitonary then get their values that way
                        if let infoDict = info as? NSDictionary {
                            
                            //get the titles and the other values
                            if let title = infoDict.value(forKey: ConfigClass.shared.JSON_TITLES){
                                //add them to the local array
                                self.lsTitles.append((title as? String)!)
                            }
                            if let urlImages = infoDict.value(forKey: ConfigClass.shared.JSON_IMAGES){
                                self.lsUrlImages.append((urlImages as? String)!)
                            }
                            if let websites = infoDict.value(forKey: ConfigClass.shared.JSON_WESBITE){
                                self.lsWebsite.append((websites as? String)!)
                            }
                            if let authors = infoDict.value(forKey: ConfigClass.shared.JSON_AUTHORS){
                                self.lsAuthors.append((authors as? String)!)
                            }
                        }
                    }
                }
                OperationQueue.main.addOperation ({
                    //call the function here that will add all the data to the database
                    self.writeLS()
                })
            }
        }).resume()
    }
    //Create the function that will add it to the database
    func writeLS(){
        //The database references
        let mRootRef: DatabaseReference!
        mRootRef = Database.database().reference();
        
        let mNewsRef = mRootRef.child("News IOS");
        let mLsRef = mNewsRef.child("Lifestyle");
        let mTitles = mLsRef.child("Titles");
        mTitles.setValue(self.lsTitles);
        
        let mContent = mLsRef.child("Content");
        mContent.setValue(self.lsContent);
        
        let mAuthors = mLsRef.child("Authors");
        mAuthors.setValue(self.lsAuthors);
        
        let mUrlImages = mLsRef.child("Url Images")
        mUrlImages.setValue(self.lsUrlImages)
        
        let mWebsites = mLsRef.child("Websites");
        mWebsites.setValue(self.lsWebsite)
    }
    
    //MARK -- Shared class
    static let shared = ParseLifestyle();
}
