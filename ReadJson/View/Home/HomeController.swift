//
//  HomeController.swift
//  ReadJson
//
//  Created by Alessio Massa on 18/12/2019.
//  Copyright © 2019 Alessio Massa. All rights reserved.
//

import UIKit
import AlamofireImage

class HomeController: UIViewController {
    
    //
    // MARK: - IBOutlets
    //
    @IBOutlet weak var homeTableView: UITableView!
    
    //
    // MARK: - Variables and Properties
    //
    let homeManager = HomeManager.shared
    var spinner : SpinningWheel?
    var labelNoConnection: UILabel!
    var errorFound = false
    
    override func viewDidLoad() {
        
        /// HomeManager Connection
        homeManager.homeController = self
        
        /// Spinner Initialization
        spinner = SpinningWheel(tableView: homeTableView)
        spinner?.spinnerImplementation()
        spinner?.refreshControlImplementation()
        
        /// Json Response Exstension Connection
        JsonManager.delegate = self
        
        /// Table View Exstension Connection
        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self
        
        /// Title
        navigationItem.title = titleHomeTranslation
        
    }
    
    //
    // MARK: - IBActions
    //
    @IBAction func refreshAction(_ sender: UIBarButtonItem) {
        if homeManager.storage.count > 1 {
            InterfaceMethods().goToTopTableView(tableView: self.homeTableView)
        }
        spinner?.buttonRefreshPressed()
    }
    
    //
    // MARK: - Prepare for segue
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailController" {
            if let indexPath = homeTableView.indexPathForSelectedRow {
                let controller = segue.destination as! HomeDetailController
                controller.dataFromMain = homeManager.storage[(indexPath as NSIndexPath).row]
            }
        }
    }
}

//
// MARK: - Extension ViewController for TableView Methods
//
extension HomeController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeManager.storage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeCell
        let url_img = URL(string: homeManager.storage[indexPath.row].image_app)!
        cell.imageApp.af_setImage(withURL: url_img)
        cell.nameApp.text = homeManager.storage[indexPath.row].name
        cell.artistApp.text = homeManager.storage[indexPath.row].artist_name
        cell.categoryApp.text = homeManager.storage[indexPath.row].category_name
        cell.priceApp.text = homeManager.storage[indexPath.row].price
        cell.rank.text = ("# \(homeManager.storage[indexPath.row].position)")
        
        return cell
    }
    
    
}

//
// MARK: - Extension ViewController for handle the Network response
//
extension HomeController: NetworkManagerDelegate {
   
    
    func networkFinishedWithData(response: (JsonTypeResponse, String, String, String)) {
        DispatchQueue.main.async {
            if self.errorFound {
                self.errorFound = false
                self.labelNoConnection?.isHidden = true
            }
        }
    }
    
    func networkFinishedWithError(response: (JsonTypeResponse, String, String, String)) {
        ///Stop spinner
        spinner?.spin.stopAnimating()
        
        DispatchQueue.main.async {
            
            switch response.0 {
            case .networkError:
                if !self.errorFound {
                    self.labelNoConnection = UILabel(frame: CGRect(x: 0,
                                                                   y: self.view.bounds.size.height -  50,
                                                                   width: self.homeTableView.bounds.size.width,
                                                                   height: 50))
                    self.labelNoConnection!.backgroundColor = .black
                    self.labelNoConnection!.textColor = .white
                    self.labelNoConnection!.textAlignment = .center
                    self.labelNoConnection!.text = response.2
                    self.view.addSubview(self.labelNoConnection!)
                }
                self.errorFound = true
                
            case .serverError:
                if !self.errorFound {
                    let alert = UIAlertController(title: response.1,
                                                  message: response.2,
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: response.3, style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                self.errorFound = true
            case .networkOK:
                print("other")
            }
        }
    }
    
}

fileprivate let titleHomeTranslation = NSLocalizedString("HOME_TITLE", comment: "")
