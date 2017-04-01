//
//  PhotoInfo.swift
//  CatsOnMap
//
//  Created by Nikolay Shubenkov on 01/04/2017.
//  Copyright © 2017 Nikolay Shubenkov. All rights reserved.
//

import Foundation

struct PhotoInfo {
//    "title": "African Lion",
    let title:String?
    
    let longitude:Double
    let latitude:Double
    
    var iconLink:String
    var fullPhotoLink:String
    
    init?(json:[String:Any])
    {
        guard let lat = json["latitude"] as? String,
              let doubleLat = Double(lat),
            
              let lon = json["longitude"] as? String,
              let doubleLon = Double(lon),
            
              let icon = json["url_s"] as? String,
              let fullPhoto = json["url_l"] as? String
            else {
                return nil
        }
        self.longitude = doubleLon
        self.latitude = doubleLat
        self.iconLink = icon
        self.fullPhotoLink = fullPhoto
        //если фото без заголовка - ничего страшного
        self.title = json["title"] as? String
    }
}
