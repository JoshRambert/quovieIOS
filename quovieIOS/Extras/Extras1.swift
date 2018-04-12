//
//  Extras1.swift
//  quovieIOS
//
//  Created by Joshua  Rambert on 4/11/18.
//  Copyright © 2018 Joshua  Rambert. All rights reserved.
//

import Foundation
import UIKit

class Extras1: UIViewController{
    
    //create the function for the continue button
    @IBAction func continueButton(_ sender: Any){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ExtrasPage2")
        self.present(vc, animated: true, completion: nil)
    }
}
