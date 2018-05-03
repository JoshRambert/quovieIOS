//
//  QuovieMainPage.swift
//  quovieIOS
//
//  Created by Joshua  Rambert on 2/16/18.
//  Copyright © 2018 Joshua  Rambert. All rights reserved.
//

import Foundation
import UIKit

final class QuovieMainPage : UICollectionViewController {
    
    //Assign the images from the assests file
    var images = ["Sports", "Tech", "Lifestyle", "Finance", "BusinessInsider", "BuzzFeed"]
    var topicTitles = ["Sports", "Technology", "Lifestyle", "Finance", "", ""]
    
    //MARK -- Lifecycle
    override func viewDidLoad() {
        ParseSports.shared.getSports()
        ParseTech.shared.getTech()
        ParseLifestyle.shared.getLifeStyle()
        ParseBI.shared.getBusinessInsider()
        ParseBuzzFeed.shared.getBuzzFeed()
        ParseFinance.shared.getFinance()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NewsViewCells
        
        cell.NewsImage?.image = UIImage(named: images[indexPath.row])
        cell.layer.cornerRadius = 10
        cell.NewsTopic?.text = topicTitles[indexPath.row]
                
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Send the string over to the DisplayNews Page to get that news topic data
        performSegue(withIdentifier: "ToDisplayNews", sender: nil)
    }
    
    //Change this to use the override for segue method instead
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DisplayNews = segue.destination as? DisplayNewsArticles
        
        if let indexPath = self.collectionView?.indexPath(for: NewsViewCells()){
            let newsTopic = images[indexPath.row]
            DisplayNews?.NewsTopic = newsTopic
        }
    }
    
    
    
    
    //MARK: Outlets
    fileprivate let reuseIdentifier = "collection_cell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 30.0, left: 10.0, bottom: 30.0, right: 10.0)
    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate let itemsPerColumn: CGFloat = 3
    
    //MARK properties
    var newsTopic = String()
}

extension QuovieMainPage : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //add the padding for the colleciton view and the rows
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        let cellSizes = CGSize(width: widthPerItem, height: widthPerItem)
        
        return cellSizes
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
