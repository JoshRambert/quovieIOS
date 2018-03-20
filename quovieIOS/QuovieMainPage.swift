//
//  QuovieMainPage.swift
//  quovieIOS
//
//  Created by Joshua  Rambert on 2/16/18.
//  Copyright © 2018 Joshua  Rambert. All rights reserved.
//

import Foundation
import UIKit

class QuovieMainPage : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //Assign the images from the assests file
    var images = ["Sports", "Tech", "Lifestyle", "Finance", "BusinessInsider", "BuzzFeed"]
    var topicTitles = ["Sports", "Technology", "Lifestyle", "Finance", "Business Insider", "BuzzFeed"]
    
    //MARK -- Lifecycle... Call the parse data classes
    override func viewDidLoad() {
        ParseSports.shared.getSports()
        ParseTech.shared.getTech()
        ParseLifestyle.shared.getLifeStyle()
        ParseBI.shared.getBusinessInsider()
        ParseBuzzFeed.shared.getBuzzFeed()
        ParseFinance.shared.getFinance()
        
        //Call the layout cells function
        layoutCells()
    }
    
    func layoutCells(){
        let layout = self.NewsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (self.NewsCollectionView.frame.size.width - 20)/2.0, height: (self.NewsCollectionView.frame.size.height - 20)/3.0)
        
        self.NewsCollectionView.delegate = self
        self.NewsCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection_cell", for: indexPath) as! NewsViewCells
        
        cell.NewsImage.image = UIImage(named: images[indexPath.row])
        cell.layer.cornerRadius = 10
        cell.NewsTopic.text? = topicTitles[indexPath.row]
        
        //Add labels to the Cells and add place the
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected item is", images[indexPath.row])
        
        //Send the string over to the DisplayNews Page to get that news topic data
        
    }
    
    //MARK: Outlets
    @IBOutlet weak var NewsCollectionView: UICollectionView!
}
