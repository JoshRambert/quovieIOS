//
//  QuovieMainPage.swift
//  quovieIOS
//
//  Created by Joshua  Rambert on 2/16/18.
//  Copyright © 2018 Joshua  Rambert. All rights reserved.
//

import Foundation
import UIKit

class QuovieMainPage : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    //Assign the images from the assests file
    var images = ["sports_image3", "tech_image3", "lifestyleImage2", "financeImage2", "business_insider_image", "buzz_feed_image"]
    
    //MARK -- Lifecycle... Call the parse data classes
    override func viewDidLoad() {
        ParseSports.shared.getSports()
        ParseTech.shared.getTech()
        ParseLifestyle.shared.getLifeStyle()
        ParseBI.shared.getBusinessInsider()
        ParseBuzzFeed.shared.getBuzzFeed()
        ParseFinance.shared.getFinance()
        
        self.NewsCollectionView.delegate = self
        self.NewsCollectionView.dataSource = self
        
        var layout = self.NewsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5)
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (self.NewsCollectionView.frame.size.width - 20)/2, height: (self.NewsCollectionView.frame.size.height - 20)/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection_cell", for: indexPath) as! NewsViewCells
        
        cell.NewsImage.image = UIImage(named: images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //Get the height and width of the screen
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        //set the width and height of the collection view
        return CGSize(width: (screenWidth-20)/2, height: (screenHeight-20)/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected item is", images[indexPath.row])
    }
    
    //MARK: Outlets
    @IBOutlet weak var NewsCollectionView: UICollectionView!
}
