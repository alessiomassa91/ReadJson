//
//  HomeDetailController.swift
//  ReadJson
//
//  Created by Alessio Massa on 18/12/2019.
//  Copyright © 2019 Alessio Massa. All rights reserved.
//

import UIKit
import AlamofireImage

class HomeDetailController: UIViewController {
    
    //
    // MARK: - IBOutlets
    //
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewToScroll: UIView!
    @IBOutlet weak var imageApp: UIImageView!
    @IBOutlet weak var releaseApp: UILabel!
    @IBOutlet weak var descriptionApp: UILabel!
    @IBOutlet weak var viewAppleStoreItem: UIBarButtonItem!
    
    //
    // MARK: - Variables and Properties
    //
    var dataFromMain : HomeModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///Pick up data from previous View
        guard let homeModel = dataFromMain else {return }
        title = homeModel.name
        let url_img = URL(string: homeModel.image_app)!
        imageApp.af_setImage(withURL: url_img)
        releaseApp.text = "\(releaseTranslation): \(homeModel.release_data)"
        descriptionApp.text = homeModel.description
    }
    
    //
    // MARK: - IBActions
    //
    @IBAction func viewAppleStoreAction(_ sender: UIBarButtonItem) {
        guard let mainModel = dataFromMain else {return}
        let application = UIApplication.shared
        if let appURL = URL(string: mainModel.link_app) {
            application.open(appURL)
        }
    }
    
}


fileprivate let releaseTranslation = NSLocalizedString("RELEASE_LABEL", comment: "")

