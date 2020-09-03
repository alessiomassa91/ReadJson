//
//  ViewMethods.swift
//  ReadJson
//
//  Created by Alessio Massa on 02/09/2020.
//  Copyright © 2020 Alessio Massa. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setNavBar(titleView: UIView?, title: String?){
        
        self.navigationController?.navigationBar.barTintColor = .systemBlue
        self.navigationController?.navigationBar.isTranslucent = true
        if let titleView = titleView {
            self.navigationController?.navigationBar.topItem?.titleView = titleView
        } else if let title = title {
            navigationItem.title = title
        }
        
        self.navigationController?.navigationBar.tintColor = .white
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}
