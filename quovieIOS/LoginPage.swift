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
import QuartzCore

class LoginPageViewController: UIViewController {
    
    //MARK Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //Store the logo into the ImageView
        logoImage.image = #imageLiteral(resourceName: "Q Solid")
        
        emailText.layer.borderWidth = 1
        emailText.layer.borderColor = UIColor.gray.cgColor
        
        passwordText.layer.borderWidth = 1
        passwordText.layer.borderColor = UIColor.gray.cgColor
    }
    
    //MARK Login logic
    @IBAction func loginUser(_ sender: Any) {
        //Do some form validation on the password and the email
        if let mEmail = emailText.text, let mPassword = passwordText.text{
            //Sign in with their credentials
            Auth.auth().signIn(withEmail: mEmail, password: mPassword, completion: { (user, error) in
                //Check to see that the user is not nil
                if let _ = user {
                    //User does exist go to the home screen
                    self.performSegue(withIdentifier: "ToHomePage", sender: self)
                } else{
                    //Create an error pop u message. Stating that they do not exist
                    let newUser = UIAlertController(title: "This account does not yet exist..Create it by clicking the create account button then try loggin in again", message: nil, preferredStyle: .actionSheet)
                    let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    //add the actions to the alertView controller
                    newUser.addAction(okAction)
                    
                    self.present(newUser, animated: true, completion: nil)
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
                if let _ = user {
                    //Create a pop up message telling them to login
                    self.performSegue(withIdentifier: "ToHomePage", sender: self)
                } else {
                    //Create a pop up message telling them that the user already exists
                    let existingUser = UIAlertController(title: "This account already exists... try logging in with it", message: nil, preferredStyle: .actionSheet)
                    let doneAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    //add the actions to the alertview
                    existingUser.addAction(doneAction)
                    
                    self.present(existingUser, animated: true, completion: nil)
                }
            })
        }
    }
    
    @IBAction func extrasButton(_ sender: Any) {
        //Instantiate the other view controller
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ExtrasPage1")
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK Properties
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var logoImage: UIImageView!
}
