//
//  DisplayNewsCell.swift
//  quovieIOS
//
//  Created by Joshua  Rambert on 2/20/18.
//  Copyright © 2018 Joshua  Rambert. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class DisplayNewsCells : UITableViewCell {

    //Create the functions that will get and store the data into the news cell
    func getImage(forURL imageURL: String){
        //logic to parse URL image into the ImageView
        let newsPictureUrl = URL(string: imageURL)!
        
        let session = URLSession(configuration: .default)
        
        //define a download task that will get the image from the internet
        let downloadTask = session.dataTask(with: newsPictureUrl) {(data, response, error) in
            //the download has finished
            if let e = error {
                print("Error downloading news Picture \(e)")
            } else {
                DispatchQueue.main.async {
                    self.newsImage?.image = UIImage(data: data!)
                }
            }
        }
        downloadTask.resume()
    }
    
    func getTitle(forTitle title: String){
        newsTitleLabel?.text = title
    }
    
    func getContent(forContent content: String){
        newsContentLabel?.text = content
    }
    
    func getAuthors(forAuthor author: String){
        newsAuthor?.text = author
    }
    
    func getWebsites(forWebsite website: String){
        hiddenWebsiteUrl?.text = website
    }
    
    //add a button to the layout and whenever the button is clicked it will push the titles and content to the database
    @IBAction func saveButton(){
        let saveAlert = UIAlertController(title: "Would you like to save this article to your list of favorites?", message: nil, preferredStyle: .actionSheet)
        
        let saveAction = UIAlertAction(title: "Yes", style: .default){
            (alert: UIAlertAction!) -> Void in self.saveNewsArticles((self.newsTitleLabel.text)!, (self.newsContentLabel.text)!, (self.hiddenWebsiteUrl.text)!)
        }
        
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        //add the actions
        saveAlert.addAction(saveAction)
        saveAlert.addAction(cancelAction)
        
        UIApplication.shared.keyWindow?.rootViewController?.presentedViewController?.present(saveAlert, animated: true, completion: nil)
    }
    
    //MARK Database
    func saveNewsArticles(_ newsTitle: String, _ newsContent: String, _ newsWebsite: String){
        //First get the references to the database then push the values
        let mRootRef: DatabaseReference!
        mRootRef = Database.database().reference()
        let mUsersRef = mRootRef.child("Users")
        
        let userID = Auth.auth().currentUser?.uid
        let mCurrentUserRef = mUsersRef.child(userID!)
        let mArticlesRef = mCurrentUserRef.child("Articles")
        
        let savedArticles = UserArticles.init(title: newsTitle, content: newsContent, website: newsWebsite)
        
        let newPush = mArticlesRef.childByAutoId()
        newPush.child("title").setValue(savedArticles.title)
        newPush.child("content").setValue(savedArticles.content)
        newPush.child("website").setValue(savedArticles.website)
    }
    
    //Properties
    @IBOutlet public weak var hiddenWebsiteUrl: UILabel!
    @IBOutlet public weak var newsTitleLabel: UILabel!
    @IBOutlet public weak var newsContentLabel: UILabel!
    @IBOutlet public weak var newsAuthor: UILabel!
    @IBOutlet public weak var newsImage: UIImageView!
    
    //Shared class
    static let shared = DisplayNewsCells();
}
