//
//  SpinningWheel.swift
//  ReadJson
//
//  Created by Alessio Massa on 18/12/2019.
//  Copyright © 2019 Alessio Massa. All rights reserved.
//

import UIKit

class SpinningWheel {
    
    var spin : UIActivityIndicatorView!
    var view: UIView
    var refreshData: (()->Void)?
    
    
    init(view: UIView, refreshData: @escaping () -> Void ) {
        self.view = view
        self.refreshData = refreshData
    }
    
    init(view: UIView) {
        self.view = view
    }
}

extension SpinningWheel {
    
    /// This method is used to activate the spinner in the middle of the table
    func spinnerImplementation(xPosition: CGFloat, yPosition: CGFloat, color: UIColor) {
        if spin == nil {
            spin = UIActivityIndicatorView(style: .large)
            spin.color = color
            spin.hidesWhenStopped = true
            spin.center = CGPoint(x: xPosition, y: yPosition)
            view.addSubview(spin)
        }
        spin.startAnimating()
    }
    
    func stopAnimation() {
        
        if spin != nil {
            spin.stopAnimating()
        }
    }
    
}

class RefreshPTR {
    
    var ptr : UIRefreshControl?
    var collectionView: UICollectionView
    var refreshData: (()->Void)?
    
    
    init(collectionView: UICollectionView, refreshData: @escaping () -> Void ) {
        self.collectionView = collectionView
        self.refreshData = refreshData
    }
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    /// This method is used to implement the refresh control and add the spin when you drag down the table in the meantime is refreshing the table
    func refreshControlImplementation() {
        guard refreshData != nil else { return }
        ptr = UIRefreshControl()
        ptr!.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.addSubview(ptr!)
    }
    
    @objc private func refresh() {
        guard let refreshData = refreshData else { return }
        ptr!.beginRefreshing()
        refreshData()
    }
    
    func stopAnimation() {
        guard let ptr = ptr, ptr.isRefreshing else { return }
        ptr.endRefreshing()
    }
}

