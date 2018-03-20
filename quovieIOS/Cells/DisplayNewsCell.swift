//
//  DisplayNewsCell.swift
//  quovieIOS
//
//  Created by Joshua  Rambert on 2/20/18.
//  Copyright © 2018 Joshua  Rambert. All rights reserved.
//

import Foundation
import UIKit

class DisplayNewsCells : UITableViewCell {
    //Create te function s that will get and store the data into the news cell
    func getImage(forURL image: String){
        //logic to parse URL image into the ImageView
    }
    
    func getTitle(forTitle title: String){
        newsTitle?.text = title
    }
    
    func getContent(forContent content: String){
        newsContent?.text = content
    }
    
    func getAuthors(forAuthor author: String){
        newsAuthor?.text = author
    }
    
    func getWebsites(forWebsite website: String){
        hiddenWebsiteUrl?.text = website
    }
    
    func
    //Properties
    @IBOutlet public weak var newsImage: UIImageView!
    @IBOutlet public weak var hiddenWebsiteUrl: UILabel!
    @IBOutlet public weak var newsTitle: UILabel!
    @IBOutlet public weak var newsContent: UILabel!
    @IBOutlet public weak var newsAuthor: UILabel!
    
    //Shared class
    static let shared = DisplayNewsCells();
}
