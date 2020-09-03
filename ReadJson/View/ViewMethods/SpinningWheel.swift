//
//  SpinningWheel.swift
//  ReadJson
//
//  Created by Alessio Massa on 18/12/2019.
//  Copyright © 2019 Alessio Massa. All rights reserved.
//

import UIKit

class SpinningWheel {
    
    var ptr : UIRefreshControl!
    var spin : UIActivityIndicatorView!
    var collectionView: UICollectionView
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    /// This method is used to implement the refresh control and add the spin when you drag down the table in the meantime is refreshing the table
    func refreshControlImplementation() {
        ptr = UIRefreshControl()
        ptr.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.addSubview(ptr)
    }
    
    /// This method is used to activate the spinner in the middle of the table
    func spinnerImplementation() {
        if spin == nil {
            spin = UIActivityIndicatorView(style: .large)
            spin.color = UIColor.darkGray
            spin.hidesWhenStopped = true
            spin.center = CGPoint(x: UIScreen.main.bounds.size.width / 2,
                                  y: (UIScreen.main.bounds.size.height / 2) - 44)
            collectionView.addSubview(spin)
        }
        spin.startAnimating()
    }
    
    /// Reload data
    private func getData() {
        if InitAppManager.online {
            ParseJson().readJson(url: ItunesJsonModel.url, setData: ItunesJsonManager.shared.readJson)
        } else {
            ParseJson().readOfflineJson(setData: ItunesJsonManager.shared.readJson)
        }
        
    }
    
    /// Scroll refresh
    @objc private func refresh() {
        ptr.beginRefreshing()
        getData()
    }
    
    /// Button refresh
    func buttonRefreshPressed() {
        if spin != nil {
            spin.startAnimating()
        }
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        getData()
    }
    
    func stopAnimation() {
        
        if ptr != nil && ptr.isRefreshing {
            ptr.endRefreshing()
        }
        if spin != nil {
            spin.stopAnimating()
        }
    }
}
