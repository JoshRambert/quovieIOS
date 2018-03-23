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
    func getImage(forURL imageURL: String){
        //logic to parse URL image into the ImageView
        let newsPictureUrl = URL(string: imageURL)!
        
        let session = URLSession(configuration: .default)
        
        //define a download task that will get the image from the internet
        let downloadTask = session.dataTask(with: newsPictureUrl) {(data, response, error) in
            //the download has finished
            if let e = error {
                print("Error downloading news Picture \(e)")
            } else {
                //No errors found
                //It would be weird if we didnt have a response so check for that too
                if let res = response as? HTTPURLResponse {
                    print("Downloaded news picture with response code \(res.statusCode)")
                    if let imageData = data {
                        //finally convert the data into an image and finish the process
                        let image = UIImage(data: imageData)
                        //store the image into the imageView
                        self.newsImage?.image = image
                    } else{
                        print("Couldnt get image...image is nil")
                    }
                } else{
                    print("Couldnt get response code for some reaso")
                }
            }
        }
        downloadTask.resume()
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
    
    //Properties
    @IBOutlet public weak var hiddenWebsiteUrl: UILabel!
    @IBOutlet public weak var newsTitle: UILabel!
    @IBOutlet public weak var newsContent: UILabel!
    @IBOutlet public weak var newsAuthor: UILabel!
    @IBOutlet public weak var newsImage: UIImageView!

    //Shared class
    static let shared = DisplayNewsCells();
}
