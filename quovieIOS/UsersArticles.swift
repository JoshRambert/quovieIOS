//
//  UsersArticles.swift
//  quovieIOS
//
//  Created by Joshua  Rambert on 3/20/18.
//  Copyright © 2018 Joshua  Rambert. All rights reserved.
//

import Foundation

class UserArticles {
    //Create the getters and setters for the User articles class
    
    var title: String {
        willSet(newValue){
            print("\(self.title) is going to be the value \(newValue)")
        }
        didSet(oldValue){
            print("\(oldValue) is now \(self.title)")
        }
    }
    
    var content: String {
        willSet(newValue){
            print("\(self.content) is going to be the value \(newValue)")
        }
        didSet(oldValue){
            print("\(oldValue) is now \(self.content)")
        }
    }
    
    var website: String {
        willSet(newValue){
            print("\(self.website) is going to be te value \(newValue)")
        }
        didSet(oldValue){
            print("\(oldValue) is now \(self.website)")
        }
    }
    
    init(title: String, content: String, website: String){
        self.title = title;
        self.content = content;
        self.website = website;
    }
}
