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
    
    //MARK -- Properties
    var NewsTopic: String! = nil
    @IBOutlet private weak var DisplayNewsTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    //Get the database references
    override func viewDidLoad() {
        
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
}
