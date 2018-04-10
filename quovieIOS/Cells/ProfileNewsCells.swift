//
//  ProfileNewsCells.swift
//  quovieIOS
//
//  Created by Joshua  Rambert on 4/10/18.
//  Copyright © 2018 Joshua  Rambert. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ProfileNewsCells: UITableViewCell {
    
    //Create the functons that will get the data from the database
    func getTitle(forTitle title: String){
        titleLabel?.text = title
    }
    
    func getContent(forContent content: String){
        contentLabel?.text = content
    }
    
    //MARL Properties
    @IBOutlet public weak var titleLabel: UILabel!
    @IBOutlet public weak var contentLabel: UILabel!
    
    //Shared class
    static let shared = ProfileNewsCells();
}

