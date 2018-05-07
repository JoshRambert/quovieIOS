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
    }
    
    //MARK TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileNewsCells") as! ProfileNewsCells
        
        let article : NSDictionary?
        article = self.articlesArray[indexPath.row]
        
        //get the title and the content of the profile saved news
        cell.getTitle(forTitle: article?["title"] as? String ?? "")
        cell.getContent(forContent: article?["content"] as? String ?? "")
        
        cell.layer.cornerRadius = 12
        return cell
    }

    //MARK Database
    func readProfileNews(){
        let mRootRef: DatabaseReference!
        mRootRef = Database.database().reference()
        let mUserRef = mRootRef.child("Users")
        let mCurrentUser = mUserRef.child((Auth.auth().currentUser?.uid)!)
        let mUserArticles = mCurrentUser.child("Articles")
        
        mUserArticles.observe(.childAdded, with: {(snapshot) in
            let snapshot = snapshot.value as? NSDictionary
            
            //add the snapshot to an array of NSDicitonaries
            self.articlesArray.append(snapshot)
            
            //insert the rows into the tableView
            self.ProfileNewsTable.insertRows(at: [IndexPath(row: self.articlesArray.count-1, section: 0)], with: UITableViewRowAnimation.automatic)
        })
    }
    
    //Create the logout function
    func logout(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyBoard.instantiateViewController(withIdentifier: "LoginPage")
        present(loginViewController, animated: true, completion: nil)
    }
    
    @IBAction func logoutButtonClick(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            logout()
        } catch let signOutError as NSError {
            print("Could not sign user out due to \(signOutError)")
        }
    }
    
    //MARK properties
    @IBOutlet private weak var ProfileNewsTable: UITableView!
    var articlesArray = [NSDictionary?]()
}
