//
//  ViewController.swift
//  AppStore
//
//  Created by Hamada Mouhamed on 2/13/18.
//  Copyright © 2018 Hamada Mouhamed. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
let CellId = "CellId"
    var appCategory : [AppCategory]?
    override func viewDidLoad() {
        super.viewDidLoad()
        appCategory = AppCategory.SampleAppCategory()
        AppCategory.FetchFeaturedApp { (appcat) in
            self.appCategory = appcat
            self.collectionView?.reloadData()
        }
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: CellId)
      
    }
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appCategory?.count{
            return count
        }
        return 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId, for: indexPath) as! CategoryCell
        cell.appcategory = appCategory?[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }
}
    



