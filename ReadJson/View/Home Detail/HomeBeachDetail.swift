//
//  HomeBeachDetail.swift
//  ReadJson
//
//  Created by Alessio Massa on 02/09/2020.
//  Copyright © 2020 Alessio Massa. All rights reserved.
//


import UIKit
import AlamofireImage

fileprivate let releaseTranslation = NSLocalizedString("RELEASE_LABEL", comment: "")
/*
enum HomeDetailControllerSection: Hashable {
    case main
}

struct HomeDetailControllerModel: Hashable {
   
    let homeModel: JsonHomeModel
    init(homeModel: JsonHomeModel) {
        self.homeModel = homeModel
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func ==(lhs: HomeDetailControllerModel, rhs: HomeDetailControllerModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    private let identifier = UUID()
}*/

class HomeDetailController: UIViewController {
    
    let appSelected: HomeControllerModel?
    
    var scrollView = UIScrollView()
    var imageApp = UIImageView()
    var releaseApp = UILabel()
    var descriptionApp = UILabel()
    var goToAppStoreButton: UIBarButtonItem!
    
    init(with appSelected: HomeControllerModel) {
        self.appSelected = appSelected
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        
        view.backgroundColor = .white
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.autoresizingMask = [.flexibleHeight]
        scrollView.bounces = false
        
        if let url_img = URL(string: appSelected?.image_app ?? "") {
            imageApp.af_setImage(withURL: url_img)
        }
        imageApp.contentMode = .scaleAspectFill
        imageApp.translatesAutoresizingMaskIntoConstraints = false
        
        releaseApp.text = "\(releaseTranslation): \(String(describing: appSelected?.release_data))"
        releaseApp.font = UIFont.systemFont(ofSize: 17)
        releaseApp.textAlignment = .center
        releaseApp.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionApp.text = appSelected?.description
        descriptionApp.font = UIFont.systemFont(ofSize: 14)
        descriptionApp.textAlignment = .left
        descriptionApp.numberOfLines = 1000
        descriptionApp.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageApp)
        scrollView.addSubview(releaseApp)
        scrollView.addSubview(descriptionApp)
        /*
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let statusBarHeight = Double(window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0)
        let navBar = Double(self.navigationController?.navigationBar.bounds.height ?? 0.0)
        let topDistance = CGFloat(statusBarHeight + navBar + 10)
        let tabBarHeight = Double(self.tabBarController?.tabBar.bounds.height ?? 0)
        let bottomDistance = CGFloat(tabBarHeight + 30)*/
        
        NSLayoutConstraint.activate([
            imageApp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageApp.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            imageApp.widthAnchor.constraint(equalToConstant: 100),
            imageApp.heightAnchor.constraint(equalToConstant: 100),
            
            releaseApp.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            releaseApp.topAnchor.constraint(equalTo: imageApp.bottomAnchor, constant: 10),
            releaseApp.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            releaseApp.heightAnchor.constraint(equalToConstant: 40),
            
            descriptionApp.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionApp.topAnchor.constraint(equalTo: releaseApp.bottomAnchor, constant: 10),
            descriptionApp.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            descriptionApp.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
    }
    
    func configureNavBar() {
        self.setNavBar(titleView: nil, title: appSelected?.name)
        goToAppStoreButton = UIBarButtonItem(image: UIImage(named: "appStore"), style: .plain, target: self,
                                        action: #selector(goToAppStore))
        self.navigationItem.setRightBarButton(goToAppStoreButton, animated: true)
    }
    
    @objc func goToAppStore(){
        let application = UIApplication.shared
        if let appURL = URL(string: appSelected?.link_app ?? "") {
            application.open(appURL)
        } else {
            print("Alert")
        }
    }
    
}


