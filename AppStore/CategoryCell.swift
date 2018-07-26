//
//  CategoryCell.swift
//  AppStore
//
//  Created by Hamada Mouhamed on 2/13/18.
//  Copyright © 2018 Hamada Mouhamed. All rights reserved.
//

import UIKit

class CategoryCell:UICollectionViewCell,UICollectionViewDelegateFlowLayout
,UICollectionViewDelegate,UICollectionViewDataSource{
    var appcategory : AppCategory? {
        didSet{
            if let name = appcategory?.name{
            namelabel.text = name
            }
        }
    }
  let cellId = "appsCellId"
    let appsCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.backgroundColor = UIColor.clear
        
        collectionview.translatesAutoresizingMaskIntoConstraints = false
       return collectionview
    }()
    let DividerLineView : UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let namelabel : UILabel = {
       let name = UILabel()
        name.text = "Best New Apps"
        name.font = UIFont.systemFont(ofSize: 16)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count =  appcategory?.apps?.count{
        return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = appsCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppCell
        cell.app = self.appcategory?.apps?[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100  , height: frame.height-32)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        SetupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
      func SetupViews(){
        backgroundColor = UIColor.white
        addSubview(appsCollectionView)
        addSubview(DividerLineView)
        addSubview(namelabel)
       appsCollectionView.delegate = self
        appsCollectionView.dataSource = self
        

       appsCollectionView.register(AppCell.self, forCellWithReuseIdentifier: cellId)
       
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": namelabel]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": appsCollectionView]))
       

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": appsCollectionView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[namelabel(30)][v0][v1(0.5)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": appsCollectionView,"v1":DividerLineView,"namelabel":namelabel]))
    }
}
class AppCell:UICollectionViewCell{
    var app:Apps?{
        didSet{
            if let name = app?.Name{
            namelabel.text = name
            }
            if let category = app?.Category{
            CategoryLabel.text = category            }
            if let price = app?.Price{
                PriceLabel.text = "$\(price)"
            }
            else{
                PriceLabel.text = ""
            }
            if let image = app?.ImageName{
                imageView.image = UIImage(named:image)
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        SetupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let imageView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named:"rio")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 16
        image.layer.masksToBounds = true
        return image
    }()
    let namelabel : UILabel = {
        let name = UILabel()
        name.text = "AngryBirds is Game Master"
        name.font = UIFont.systemFont(ofSize: 12)
        name.numberOfLines = 2
        return name
    }()
    let CategoryLabel : UILabel = {
       let label = UILabel()
        label.text = "Entertainment"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.darkGray
        return label
    }()
    let PriceLabel : UILabel = {
        let Price = UILabel()
        Price.text = "99$"
        Price.font = UIFont.systemFont(ofSize: 13)
        Price.textColor = UIColor.red
        return Price
    }()
    func SetupViews(){
        backgroundColor = UIColor.white
        addSubview(imageView)
        addSubview(namelabel)
        addSubview(CategoryLabel)
        addSubview(PriceLabel)
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        namelabel.frame = CGRect(x: 0, y: frame.width + 2, width: frame.width, height: 40)
        CategoryLabel.frame = CGRect(x: 0, y: frame.width + 38, width: frame.width, height: 20)
        PriceLabel.frame = CGRect(x: 0, y: frame.width + 56, width: frame.width, height: 20 )
    }
}
