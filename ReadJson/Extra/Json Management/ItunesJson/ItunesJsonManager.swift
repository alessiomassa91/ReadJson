//
//  ItunesJsonManager.swift
//  ReadJson
//
//  Created by Alessio Massa on 03/09/2020.
//  Copyright © 2020 Alessio Massa. All rights reserved.
//

import Foundation
import SwiftyJSON

class ItunesJsonManager {
    
    static let shared = ItunesJsonManager()
    var itunesJson: ItunesJsonModel?
    let homeViewModel = HomeViewModel.shared

    func readJson(json: JSON){
        itunesJson = ItunesJsonModel(json: json)
        guard let itunesJson = itunesJson else {return}
        homeViewModel.applySnapshot(json: itunesJson)
    }

}
