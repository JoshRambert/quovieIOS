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
import FirebaseAuth

class LoginPageViewController: UIViewController {
    
    //MARK Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //Store the logo into the ImageView
        logoImage.image = #imageLiteral(resourceName: "Q Solid")
    }
    
    //MARK Login logic
    @IBAction func loginUser(_ sender: Any) {
        //Do some form validation on the password and the email
        if let mEmail = emailText.text, let mPassword = passwordText.text{
            //Sign in with their credentials
            Auth.auth().signIn(withEmail: mEmail, password: mPassword, completion: { (user, error) in
                //Check to see that the user is not nil
                if let u = user {
                    //User does exist go to the home screen
                    self.performSegue(withIdentifier: "ToHomePage", sender: self)
                } else{
                    //Create an error pop u message. Stating that they do not exist
                }
            })
        }
    }
    
    @IBAction func createAccountButton(_ sender: Any) {
        //Do some form validaiton on the password and the Email
        if let mEmail = emailText.text, let mPassword = passwordText.text{
            //Create the account for the user here
            Auth.auth().createUser(withEmail: mEmail, password: mPassword, completion: { (user, error) in
                //check to see that the user does not already exist
                if let u = user {
                    //Create a pop up message telling them to login
                    self.performSegue(withIdentifier: "ToHomePage", sender: self)
                } else {
                    //Create a pop up message telling them that the user already exists
                }
            })
        }
    }
    
    
    
    //MARK Properties
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var logoImage: UIImageView!
}
