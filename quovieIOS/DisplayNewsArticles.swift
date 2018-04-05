//
//  DisplayNewsArticles.swift
//  quovieIOS
//
//  Created by Joshua  Rambert on 2/16/18.
//  Copyright © 2018 Joshua  Rambert. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseCore
import FirebaseDatabase

class DisplayNewsArticles : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK Lifecycle
    override func viewDidLoad() {
        //Call the read news data
        readNewsTopic()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        //Clear the arryas for hopefully a smoother transition between news topics
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ConfigClass.shared.dbTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DisplayNewsCells") as! DisplayNewsCells
        
        //Get the array of news data from the Shared configuration class
        let newsTitles = ConfigClass.shared.dbTitles
        let newsContent = ConfigClass.shared.dbContent
        let newsAuthors = ConfigClass.shared.dbAuthors
        let newsImages = ConfigClass.shared.dbUrlImages
        let newsWebsites = ConfigClass.shared.dbWebsites
        
        cell.getTitle(forTitle: newsTitles[indexPath.row])
        cell.getContent(forContent: newsContent[indexPath.row])
        cell.getWebsites(forWebsite: newsWebsites[indexPath.row])
        cell.getAuthors(forAuthor: newsAuthors[indexPath.row])
        cell.getImage(forURL: newsImages[indexPath.row])
        
        //edit the desin of the cell
        cell.layer.cornerRadius = 15
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Here we will instantiate the webArticle ViewController and send the Url from within that cell
        let cell = self.DisplayNewsTable.dequeueReusableCell(withIdentifier: "DisplayNewsCells") as! DisplayNewsCells
        webArticleUrl = cell.hiddenWebsiteUrl.text!
        
        //Send the URL string to the webView
        performSegue(withIdentifier: "ToWebArticle", sender: webArticleUrl)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let webNewsArticle = segue.destination as? WebArticle {
            webNewsArticle.UrlString = sender as! String
        }
    }
    
    //Create a method that will read from the database
    func readNewsTopic(){
        //The database references
        let mRootRef: DatabaseReference!
        mRootRef = Database.database().reference();
        let mNewsRef = mRootRef.child("News IOS");
        let mNewsTopic = mNewsRef.child(NewsTopic)
        
        
        mNewsTopic.observeSingleEvent(of: .value, with: {(snapshot) in
        //Get the values then send it into the config class db
            let values = snapshot.value as? NSDictionary
            let titles = values?["Titles"] as? Array<String> ?? [String]();
            ConfigClass.shared.dbTitles = titles
        }) {(error) in
            print(error.localizedDescription)
        }
        
        mNewsTopic.observeSingleEvent(of: .value, with: {(snapshot) in
            let values = snapshot.value as? NSDictionary
            let content = values?["Content"] as? Array<String> ?? [String]();
            ConfigClass.shared.dbContent = content
        }) {(error) in
            print(error.localizedDescription)
        }
        
        mNewsTopic.observeSingleEvent(of: .value, with: {(snapshot) in
            let values = snapshot.value as? NSDictionary
            let authors = values?["Authors"] as? Array<String> ?? [String]();
            ConfigClass.shared.dbAuthors = authors
        }) {(error) in
            print(error.localizedDescription)
        }
        
        mNewsTopic.observeSingleEvent(of: .value, with: {(snapshot) in
            let values = snapshot.value as? NSDictionary
            let websites = values?["Websites"] as? Array<String> ?? [String]();
            ConfigClass.shared.dbWebsites = websites
        }) {(error) in
            print(error.localizedDescription)
        }
        
        mNewsTopic.observeSingleEvent(of: .value, with: {(snapshot) in
            let values = snapshot.value as? NSDictionary
            let images = values?["Url Images"] as? Array<String> ?? [String]();
            ConfigClass.shared.dbUrlImages = images
        }) {(error) in
            print(error.localizedDescription)
        }
    }
    
    func clearArrays(){
        ConfigClass.shared.dbTitles.removeAll()
        ConfigClass.shared.dbAuthors.removeAll()
        ConfigClass.shared.dbContent.removeAll()
        ConfigClass.shared.dbWebsites.removeAll()
        ConfigClass.shared.dbUrlImages.removeAll()
    }
    
    //MARK -- Properties
    var NewsTopic = String()
    var webArticleUrl = String()
    @IBOutlet private weak var DisplayNewsTable: UITableView!
    let cellSpacingHeight: CGFloat = 5
}
