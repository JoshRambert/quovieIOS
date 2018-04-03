//
//  LoginPage.swift
//  quovieIOS
//
//  Created by Joshua  Rambert on 4/3/18.
//  Copyright © 2018 Joshua  Rambert. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseCore

class LoginPageViewController: UIViewController {
    
    //MARK Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //Store the logo into the ImageView
        logoImage.image = #imageLiteral(resourceName: "Q Solid")
    }
    
    //MARK Login logic
    
    
    //MARK Properties
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
}
