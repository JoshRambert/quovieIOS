//
//  TabBarController.swift
//  quovieIOS
//
//  Created by Joshua  Rambert on 5/7/18.
//  Copyright © 2018 Joshua  Rambert. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class TabBarController: UITabBarController {
    
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
    
}
