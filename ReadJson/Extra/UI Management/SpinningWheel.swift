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
    var tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    /// This method is used to implement the refresh control and add the spin when you drag down the table in the meantime is refreshing the table
    func refreshControlImplementation() {
        ptr = UIRefreshControl()
        ptr.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(ptr)
    }
    
    /// This method is used to activate the spinner in the middle of the table
    /// - Parameter tableView: The table view in which you want to add the spin;
    func spinnerImplementation() {
        if spin == nil {
            spin = UIActivityIndicatorView(style: .large)
            spin.color = UIColor.darkGray
            spin.hidesWhenStopped = true
            spin.center = CGPoint(x: UIScreen.main.bounds.size.width / 2,
                                  y: (UIScreen.main.bounds.size.height / 2) - 44)
            tableView.addSubview(spin)
        }
        spin.startAnimating()
    }
    
    private func getData() {
        JsonManager().readJson(url: JsonHomeModel.url, setData: HomeManager.shared.loadData)
    }
    
    @objc private func refresh() {
        ptr.beginRefreshing()
        getData()
    }
    
    
    
    func reloadTable() {
        
        if ptr != nil && ptr.isRefreshing {
            ptr.endRefreshing()
        }
        
        if spin != nil {
            spin.stopAnimating()
        }
        self.tableView.reloadData()
    }
    
    func buttonRefreshPressed() {
        if spin != nil {
            spin.startAnimating()
        }
        getData()
    }
}
