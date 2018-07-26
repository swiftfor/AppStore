//
//  Models.swift
//  AppStore
//
//  Created by Hamada Mouhamed on 2/15/18.
//  Copyright © 2018 Hamada Mouhamed. All rights reserved.
//

import UIKit

class AppCategory : NSObject{
    var name:String?
    var apps:[Apps]?
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "apps"{
            apps = [Apps]()
            for dict in value as! [[String:AnyObject]]{
              let app = Apps()
                app.setValuesForKeys(dict)
                apps?.append(app)
                
            }
        }else{
            super.setValue(value, forKey: key)
        }
    }
    
    static func FetchFeaturedApp(completionHandler: @escaping ([AppCategory]) -> ()){
        let SString = "http://www.statsallday.com/appstore/featured"
        let url = URL(string:SString)
        let request = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                print(error)
                return
            }
            do{
                let json = try (JSONSerialization.jsonObject(with: data!, options: .mutableContainers)) as! [String:AnyObject]
                var AppCat = [AppCategory]()
                for dict in json["categories"] as! [[String:Any]]{
                    let appCategory = AppCategory()
                    appCategory.setValuesForKeys(dict)
                    AppCat.append(appCategory)
                }
                DispatchQueue.main.async {
                    completionHandler(AppCat)
                }
                print(AppCat)
            }
            catch let err{
                print(err)
            }
      }.resume()
  }
    static func SampleAppCategory() -> [AppCategory]{
       var bestNewApp = AppCategory()
        bestNewApp.name = "Best New Apps"
        var BestApps = [Apps]()
        
        let AngryApp = Apps()
        AngryApp.Name = "AngryBirds is Game Master"
        AngryApp.Category = "Entertainment"
        AngryApp.Price = NSNumber(floatLiteral: 3.99)
        AngryApp.ImageName = "angry"
        BestApps.append(AngryApp)
        
        var bestNewGames = AppCategory()
        bestNewGames.name = "Best New Games"
        var GameApps = [Apps]()
        let photos = Apps()
        photos.Name = "Friends For Ever"
        photos.Category = "Games"
        photos.Price = NSNumber(floatLiteral: 5.99)
        photos.ImageName = "photo"
        GameApps.append(photos)
        
        bestNewGames.apps = GameApps
        bestNewApp.apps = BestApps
        return [bestNewApp,bestNewGames]
    }
}
class Apps : NSObject{
    var Id : NSNumber?
    var Name : String?
    var Category : String?
    var ImageName : String?
    var Price : NSNumber?
    
    
}
