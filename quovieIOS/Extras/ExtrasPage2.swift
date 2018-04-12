//
//  ExtrasPage3.swift
//  quovieIOS
//
//  Created by Joshua  Rambert on 4/11/18.
//  Copyright © 2018 Joshua  Rambert. All rights reserved.
//

import Foundation
import UIKit

class ExtrasPage2: UIViewController{
    
    @IBAction func oneMorePageButton(_ sender: Any){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ExtrasPage3")
        self.present(vc, animated: true, completion: nil)
    }
}
