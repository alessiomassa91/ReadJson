//
//  HomeControllerNew.swift
//  ReadJson
//
//  Created by Alessio Massa on 02/09/2020.
//  Copyright © 2020 Alessio Massa. All rights reserved.
//

import UIKit


enum HomeControllerSection: Hashable {
    case main
}

struct HomeControllerModel: Hashable {
    var name: String?
    var image_app: String?
    var description: String?
    var price: String?
    var link_app: String?
    var artist_name: String?
    var category_name: String?
    var release_data: String?
    
    
    init(entryArray: ItunesJsonModel.Feed.Entry) {
        self.name = entryArray.im_name ?? ""
        self.image_app = entryArray.im_image?[0].label ?? ""
        self.description = entryArray.summary ?? ""
        self.price = entryArray.im_price?.price ?? ""
        self.link_app = entryArray.link?[0].href ?? ""
        self.artist_name = entryArray.im_artist?.label ?? ""
        self.category_name = entryArray.category?.label ?? ""
        self.release_data = entryArray.im_releaseDate?.attributes_label ?? ""
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func ==(lhs: HomeControllerModel, rhs: HomeControllerModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    private let identifier = UUID()
}

class HomeController: UIViewController {
    
    let viewModel = HomeViewModel.shared
    
    var labelNoConnection: UILabel?
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<HomeControllerSection, HomeControllerModel>?
    var spinner: SpinningWheel?
    var ptr: RefreshPTR?
    private var refreshButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.homeController = self
        configureNavBar()
        configureHierarchy()
        initManager()
        configureDataSource()
    }
    
    func initManager() {
        /// Spinner Initialization
        spinner = SpinningWheel(view: collectionView, refreshData: viewModel.refreshDataSpinner)
        spinner?.spinnerImplementation(xPosition: collectionView.bounds.size.width / 2,
                                       yPosition: collectionView.bounds.size.height / 2,
                                       color: UIColor.darkGray)
        ptr = RefreshPTR(collectionView: collectionView, refreshData: viewModel.refreshDataSpinner)
        ptr?.refreshControlImplementation()
        
        /// Json Response Exstension Connection
        ParseJson.delegate = self
        if !InitAppManager.online {
            spinner?.stopAnimation()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = self.collectionView.indexPathsForSelectedItems?.first {
            if let coordinator = self.transitionCoordinator {
                coordinator.animate(alongsideTransition: { context in
                    self.collectionView.deselectItem(at: indexPath, animated: true)
                }) { (context) in
                    if context.isCancelled {
                        self.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
                    }
                }
            } else {
                self.collectionView.deselectItem(at: indexPath, animated: animated)
            }
        }
    }
}

extension HomeController {
    
    func configureNavBar() {
        
        self.setNavBar(titleView: nil, title: viewModel.titleHome)
        refreshButton = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .plain, target: self,
                                        action: #selector(refreshAction))
        self.navigationItem.setRightBarButton(refreshButton, animated: true)
    }
    
    @objc func refreshAction(sender: UIButton!){
        guard let spin = spinner?.spin, let refreshData = spinner?.refreshData else {return}
        spin.startAnimating()
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        refreshData()
    }
    
    func createLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .sidebarPlain)
        config.showsSeparators = true
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        layout.configuration.interSectionSpacing = 0
        return layout
    }
    
    func configureHierarchy(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = UIColor(named: "HomeScreen")
        
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.estimatedItemSize = CGSize(width: width, height: 130)
        collectionView.collectionViewLayout = layout
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    
    private func configureListCell() -> UICollectionView.CellRegistration<HomeCell, HomeControllerModel> {
        return UICollectionView.CellRegistration<HomeCell, HomeControllerModel> {
            (cell, indexPath, item) in
            cell.setItems(item: item, indexPath: indexPath)
        }
    }
    
    func configureDataSource() {
        
        dataSource = UICollectionViewDiffableDataSource<HomeControllerSection, HomeControllerModel>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: HomeControllerModel) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: self.configureListCell(), for: indexPath, item: item)
        }
        viewModel.updateView()
    }
}

extension HomeController: NetworkManagerDelegate {
    
    func networkFinishedWithData(response: (JsonTypeResponse, String, String, String, String)) {
        spinner?.stopAnimation()
        ptr?.stopAnimation()
        if let labelNoConnection = labelNoConnection {
            labelNoConnection.isHidden = true
        }
    }
    
    func networkFinishedWithError(response: (JsonTypeResponse, String, String, String, String)) {
        ///Stop spinner && ptr
        spinner?.stopAnimation()
        ptr?.stopAnimation()
        if self.viewModel.snapshot.items.isEmpty {
            labelNoConnection = UILabel()
            labelNoConnection?.numberOfLines = 10
            labelNoConnection!.backgroundColor = .white
            labelNoConnection!.textColor = .black
            labelNoConnection!.textAlignment = .center
            labelNoConnection?.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(labelNoConnection!)
            labelNoConnection!.text = response.2
            NSLayoutConstraint.activate([
                labelNoConnection!.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                labelNoConnection!.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                labelNoConnection!.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                labelNoConnection!.heightAnchor.constraint(equalToConstant: 100)
            ])
        } else {
            let alert = UIAlertController(title: response.1,
                                          message: response.2,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: response.3, style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            spinner?.stopAnimation()
        }
    }
    
}


extension HomeController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource?.itemIdentifier(for: indexPath) else {return}
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
        let detailController = HomeDetailController(with: item)
        self.navigationController?.pushViewController(detailController, animated: true)
    }
}

