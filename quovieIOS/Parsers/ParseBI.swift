//
//  ParseBI.swift
//  quovieIOS
//
//  Created by Joshua  Rambert on 2/17/18.
//  Copyright © 2018 Joshua  Rambert. All rights reserved.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseDatabase

public class ParseBI {
    
    //The arrays to store the strings in
    var biTitles = [String]();
    var biContent = [String]();
    var biUrlImages = [String]();
    var biWebsites = [String]();
    var biAuthors = [String]();
    
    func getBusinessInsider(){
        //assing the URL
        let url = NSURL(string: ConfigClass.shared.BI_URL);
        
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary{
                
                //Getting the array and converting it into the local array
                if let articlesArray = jsonObj!.value(forKey: ConfigClass.shared.JSON_ARRAY) as? NSArray {
                    //looping through the elemnts
                    for info in articlesArray{
                        //convert the elements to a dictinoary then get their values that way
                        if let infoDict = info as? NSDictionary {
                            
                            //get the title and the other values
                            if let title = infoDict.value(forKey: ConfigClass.shared.JSON_TITLES){
                                //add them to the array
                                self.biTitles.append((title as? String)!)
                            }
                            if let urlImages = infoDict.value(forKey: ConfigClass.shared.JSON_IMAGES){
                                self.biUrlImages.append((urlImages as? String)!)
                            }
                            if let content = infoDict.value(forKey: ConfigClass.shared.JSON_CONTENT){
                                self.biContent.append((content as? String)!)
                            }
                            if let websites = infoDict.value(forKey: ConfigClass.shared.JSON_WESBITE){
                                self.biWebsites.append((websites as? String)!)
                            }
                            if let authors = infoDict.value(forKey: ConfigClass.shared.JSON_AUTHORS){
                                self.biAuthors.append((authors as? String)!)
                            }
                        }
                    }
                }
                OperationQueue.main.addOperation ({
                    //Call the function here that wll add all the data to the database
                    self.writeBusinessInsider()
                    //Cleat the BI Arrays
                    self.clearBI()
                })
            }
        }).resume()
    }
    //create the functon that will add it to the database
    func writeBusinessInsider(){
        //The database reference
        let mRootRef: DatabaseReference!
        mRootRef = Database.database().reference();
        
        let mNewsRef = mRootRef.child("News IOS");
        let mBiRef = mNewsRef.child("BusinessInsider")
        let mTitles = mBiRef.child("Titles")
        mTitles.setValue(self.biTitles);
        
        let mContent = mBiRef.child("Content")
        mContent.setValue(self.biContent)
        
        let mAuthors = mBiRef.child("Authors")
        mAuthors.setValue(self.biAuthors)
        
        let mUrlImages = mBiRef.child("Url Images")
        mUrlImages.setValue(self.biUrlImages)
        
        let mWebsites = mBiRef.child("Websites")
        mWebsites.setValue(self.biWebsites)
    }
    
    func clearBI(){
        self.biAuthors.removeAll()
        self.biTitles.removeAll()
        self.biContent.removeAll()
        self.biUrlImages.removeAll()
        self.biWebsites.removeAll()
    }
    
    //MARK -- Shared class
    static let shared = ParseBI();
}
