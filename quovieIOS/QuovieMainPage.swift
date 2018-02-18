//
//  QuovieMainPage.swift
//  quovieIOS
//
//  Created by Joshua  Rambert on 2/16/18.
//  Copyright © 2018 Joshua  Rambert. All rights reserved.
//

import Foundation
import UIKit

class QuovieMainPage : UIViewController {
    //Call the parse data classes
    override func viewDidLoad() {
        ParseSports.shared.getSports()
        ParseTech.shared.getTech()
        ParseFinance.shared.getFinance()
        ParseLifestyle.shared.getLifeStyle()
        ParseBI.shared.getBusinessInsider()
        ParseBuzzFeed.shared.getBuzzFeed()
    }
}
