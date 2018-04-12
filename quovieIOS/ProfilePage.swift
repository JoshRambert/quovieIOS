//
//  ProfilePage.swift
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


class ProfilePage: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK lifecycle
    override func viewDidLoad() {
        readProfileNews()
        
        self.ProfileNewsTable.delegate = self
        self.ProfileNewsTable.dataSource = self
    }
    
    //MARK TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ConfigClass.shared.userTitles.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileNewsCells") as! ProfileNewsCells
        
        //get the title and the content of the profile saved news
        cell.getTitle(forTitle: ConfigClass.shared.userTitles[indexPath.row])
        cell.getContent(forContent: ConfigClass.shared.userContent[indexPath.row])
        
        cell.layer.cornerRadius = 12
        return cell
    }

    //MARK Database
    func readProfileNews(){
        //First get the reference to the current user from the database and then get all of their
        let mRootRef: DatabaseReference!
        mRootRef = Database.database().reference();
        let mUserRef = mRootRef.child("Users")
        let mCurrentUser = mUserRef.child((Auth.auth().currentUser?.uid)!)
        let mUserArticles = mCurrentUser.child("Articles")
        
        //Get the data from the database
        mUserArticles.observe(.value , with: {snapshot in
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshots {
                    if let articlesDict = snap.value as? NSDictionary{
                        if let title = articlesDict.value(forKey: "title"){
                            ConfigClass.shared.userTitles.append(title as! String)
                        }
                        if let content = articlesDict.value(forKey: "content"){
                            ConfigClass.shared.userContent.append(content as! String)
                        }
                    }
                }
            }
        })
    }
    
    //MARK properties
    @IBOutlet private weak var ProfileNewsTable: UITableView!
}
