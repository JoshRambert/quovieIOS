//
//  ParseFinance.swift
//  quovieIOS
//
//  Created by Joshua  Rambert on 2/17/18.
//  Copyright © 2018 Joshua  Rambert. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseCore

public class ParseFinance {
    
    //Create the arrays to store the strings in
    var financeTitles = [String]();
    var fincanceUrlImages = [String]();
    var financeContent = [String]();
    var financeWebsite = [String]();
    var financeAuthors = [String]();
    
    func getFinance(){
        //assign the URL
        let url = NSURL(string: ConfigClass.shared.FINANCE_URL2);
        
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary{
                
                //gettingt he array and converting it into the local array
                if let articlesArray = jsonObj!.value(forKey: ConfigClass.shared.JSON_ARRAY) as? NSArray {
                    //looping through the elements
                    for info in articlesArray {
                        //convert the elements to a dictionary
                        if let infoDict = info as? NSDictionary{
                            
                            //Get the titles and the other values
                            if let title = infoDict.value(forKey: ConfigClass.shared.JSON_TITLES){
                                //add them to the local array
                                self.financeTitles.append((title as? String)!)
                            }
                            if let urlImages = infoDict.value(forKey: ConfigClass.shared.JSON_IMAGES){
                                self.fincanceUrlImages.append((urlImages as? String)!)
                            }
                            if let content = infoDict.value(forKey: ConfigClass.shared.JSON_CONTENT){
                                self.financeContent.append((content as? String)!)
                            }
                            if let websites = infoDict.value(forKey: ConfigClass.shared.JSON_WESBITE){
                                self.financeWebsite.append((websites as? String)!)
                            }
                            if let authors = infoDict.value(forKey: ConfigClass.shared.JSON_AUTHORS){
                                self.financeAuthors.append((authors as? String)!)
                            }
                        }
                    }
                }
                OperationQueue.main.addOperation ({
                    //call the function here that will add all the data to the database
                    self.writeFinance()
                    //Clear the arrays after writing the data
                    self.clearFinance()
                })
            }
        }).resume()
    }
    
    func writeFinance(){
        //The database reference
        let mRootRef: DatabaseReference!
        mRootRef = Database.database().reference();
        
        let mNewsRef = mRootRef.child("News IOS");
        let mFinanceRef = mNewsRef.child("Finance")
        let mTitles = mFinanceRef.child("Titles")
        mTitles.setValue(self.financeTitles);
        
        let mContent = mFinanceRef.child("Content")
        mContent.setValue(self.financeContent)
        
        let mAuthors = mFinanceRef.child("Authors")
        mAuthors.setValue(self.financeAuthors)
        
        let mUrlImages = mFinanceRef.child("Url Images")
        mUrlImages.setValue(self.fincanceUrlImages)
        
        let mWebsites = mFinanceRef.child("Websites")
        mWebsites.setValue(self.financeWebsite)
    }
    
    //Clear arrays after writing the data
    func clearFinance(){
        self.financeTitles.removeAll()
        self.financeAuthors.removeAll()
        self.financeContent.removeAll()
        self.financeWebsite.removeAll()
        self.fincanceUrlImages.removeAll()
    }
    
    //MARK -- Shared class
    static let shared = ParseFinance();
}
