//
//  InterfaceMethods.swift
//  ReadJson
//
//  Created by Alessio Massa on 18/12/2019.
//  Copyright © 2019 Alessio Massa. All rights reserved.
//

import UIKit

class InterfaceMethods {
    
    func goToTopTableView(tableView: UITableView){
        let indexPath = NSIndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
    }
    
}
