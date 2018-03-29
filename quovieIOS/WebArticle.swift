//
//  WebArticle.swift
//  quovieIOS
//
//  Created by Joshua  Rambert on 3/28/18.
//  Copyright © 2018 Joshua  Rambert. All rights reserved.
//

import Foundation
import UIKit

class WebArticle: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: UrlString)
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
    }
    
    //MARK - Properties
    var UrlString = String()
    @IBOutlet weak var webView: UIWebView!
    
}
