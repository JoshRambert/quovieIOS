//
//  ConfigClass.swift
//  quovieIOS
//
//  Created by Joshua  Rambert on 2/16/18.
//  Copyright © 2018 Joshua  Rambert. All rights reserved.
//

import Foundation

public class ConfigClass {
    
    //Create the URLS to get parsed
    let BF_URL = "https://newsapi.org/v2/top-headlines?sources=buzzfeed&apiKey=b58181b5d3674ec38753867894405f2c"
    let SPORTS_URL = "https://newsapi.org/v2/top-headlines?sources=bbc-sport&apiKey=b58181b5d3674ec38753867894405f2c"
    let TECH_URL = "https://newsapi.org/v2/top-headlines?sources=the-next-web&apiKey=b58181b5d3674ec38753867894405f2c"
    let LS_URL = "https://newsapi.org/v2/top-headlines?sources=the-telegraph&apiKey=b58181b5d3674ec38753867894405f2c"
    let FINANCE_URL = "https://newsapi.org/v2/top-headlines?sources=the-hill&apiKey=b58181b5d3674ec38753867894405f2c"
    let BI_URL = "https://newsapi.org/v2/top-headlines?sources=business-insider&apiKey=b58181b5d3674ec38753867894405f2c"
    let FINANCE_URL2 = "https://newsapi.org/v2/top-headlines?sources=focus&apiKey=b58181b5d3674ec38753867894405f2c"
    
    let JSON_ARRAY = "articles"
    
    let JSON_IMAGES = "urlToImage"
    let JSON_TITLES = "title"
    let JSON_CONTENT = "description"
    let JSON_WESBITE = "url"
    let JSON_AUTHORS = "author"
    
    var dbTitles = [String]();
    var dbContent = [String]();
    var dbWebsites = [String]();
    var dbUrlImages = [String]();
    var dbAuthors = [String]();
    
    
    //Create the shared
    static let shared = ConfigClass();
}
