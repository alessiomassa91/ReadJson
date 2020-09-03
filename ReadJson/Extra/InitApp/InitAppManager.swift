//
//  InitAppManager.swift
//  ReadJson
//
//  Created by Alessio Massa on 02/09/2020.
//  Copyright © 2020 Alessio Massa. All rights reserved.
//

import Foundation

class InitAppManager: NSObject {
    //
    // MARK: - Variables and Properties called in other classes.
    //
    static let shared = InitAppManager()
    let jsonManager = ParseJson.shared
    static var online = false
    
    func startApp(jsonOnline: Bool) {
        if jsonOnline {
            InitAppManager.online = true
            ParseJson().readJson(url: ItunesJsonModel.url, setData: ItunesJsonManager.shared.readJson)
        } else {
            InitAppManager.online = false
            ParseJson().readOfflineJson(setData: ItunesJsonManager.shared.readJson)
        }
    }
    
}
