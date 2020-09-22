//
//  HomeViewModel.swift
//  ReadJson
//
//  Created by Alessio Massa on 02/09/2020.
//  Copyright © 2020 Alessio Massa. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeViewModel {
    
    static var shared = HomeViewModel()
    
    var homeController: HomeController?
    var snapshot = NSDiffableDataSourceSectionSnapshot<HomeControllerModel>()
    let titleHome = NSLocalizedString("HOME_TITLE", comment: "")
    
    func applySnapshot(json: ItunesJsonModel){
        guard let entryArray = json.feed?.entry else { return }
        snapshot = NSDiffableDataSourceSectionSnapshot<HomeControllerModel>()
        let items = entryArray.map{HomeControllerModel(entryArray: $0)}
        snapshot.append(items)
        self.homeController?.spinner?.stopAnimation()
        updateView()
    }
    
    func refreshDataSpinner() {
        InitAppManager.shared.startApp(jsonOnline: true)
    }
    
    func updateView() {
        guard let homeController = homeController, let dataSource = homeController.dataSource else { return }
        dataSource.apply(self.snapshot, to: .main, animatingDifferences: true)
    }
}

