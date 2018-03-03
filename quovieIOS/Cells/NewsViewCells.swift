//
//  NewsViewCells.swift
//  quovieIOS
//
//  Created by Joshua  Rambert on 2/18/18.
//  Copyright © 2018 Joshua  Rambert. All rights reserved.
//

import Foundation
import UIKit

class NewsViewCells: UICollectionViewCell {
    
    //MARK -- The image outlet
    @IBOutlet public weak var NewsImage: UIImageView!
    @IBOutlet public weak var NewsTopic: UILabel!
    
    static let shared = NewsViewCells();
}
