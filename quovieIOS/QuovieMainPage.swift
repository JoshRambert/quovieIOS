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
        let width = UIScreen.main.bounds.width
        return CGSize(width: (width - 10)/3, height: (width - 10)/3) // width & height are the same to make a square cell
    }
    //MARK: Outlets
    @IBOutlet weak var NewsCollectionView: UICollectionView!
}
