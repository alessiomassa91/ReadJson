//
//  HomeManager.swift
//  ReadJson
//
//  Created by Alessio Massa on 23/12/2019.
//  Copyright © 2019 Alessio Massa. All rights reserved.
//

import Foundation
import SwiftyJSON

class HomeManager {
    
    static let shared = HomeManager()
    var storage: [HomeModel] = []
    var homeController: HomeController!
    var jsonHomeObject: JsonHomeModel?
    
    func loadData(json: JSON){
        jsonHomeObject = JsonHomeModel(json: json)
        var position = 0
        jsonHomeObject?.feed?.entry?.forEach({ (entryArray) in
            let name = entryArray.im_name ?? ""
            let image_app = entryArray.im_image?[0].label ?? ""
            let description = entryArray.summary ?? ""
            let price = entryArray.im_price?.price ?? ""
            let link_app = entryArray.link?[0].href ?? ""
            let artist_name = entryArray.im_artist?.label ?? ""
            let category_name = entryArray.category?.label ?? ""
            let release_data = entryArray.im_releaseDate?.attributes_label ?? ""
            position = position + 1
            let homeModel = HomeModel(name: name,
                                      image_app: image_app,
                                      description: description,
                                      price: price,
                                      link_app: link_app,
                                      artist_name: artist_name,
                                      category_name: category_name,
                                      release_data: release_data,
                                      position: position)
            storage.append(homeModel)
            self.homeController.spinner?.reloadTable()
        })
        
        
    }
}
