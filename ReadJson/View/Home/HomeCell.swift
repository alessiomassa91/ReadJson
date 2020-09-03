//
//  HomeCellNew.swift
//  ReadJson
//
//  Created by Alessio Massa on 02/09/2020.
//  Copyright © 2020 Alessio Massa. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewListCell {
    
    var imageApp = UIImageView()
    var nameApp = UILabel()
    var artistApp = UILabel()
    var categoryApp = UILabel()
    var priceApp = UILabel()
    var rank = UILabel()
    var viewSeparator = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
}


extension HomeCell {
    func configure() {
        contentView.backgroundColor = UIColor(named: "HomeScreen")
        imageApp.contentMode = .scaleAspectFill
        imageApp.translatesAutoresizingMaskIntoConstraints = false
        
        nameApp.font = UIFont.boldSystemFont(ofSize: 18)
        nameApp.textAlignment = .left
        nameApp.translatesAutoresizingMaskIntoConstraints = false
        
        artistApp.font = UIFont.systemFont(ofSize: 13)
        artistApp.textAlignment = .left
        artistApp.translatesAutoresizingMaskIntoConstraints = false
        
        categoryApp.font = UIFont.systemFont(ofSize: 12)
        categoryApp.textAlignment = .left
        categoryApp.translatesAutoresizingMaskIntoConstraints = false
        
        priceApp.font = UIFont.boldSystemFont(ofSize: 10)
        priceApp.textAlignment = .left
        priceApp.translatesAutoresizingMaskIntoConstraints = false
        
        rank.font = UIFont.systemFont(ofSize: 15)
        rank.textAlignment = .center
        rank.backgroundColor = UIColor.systemTeal
        rank.translatesAutoresizingMaskIntoConstraints = false
        
        viewSeparator.layer.borderWidth = 1.0
        viewSeparator.layer.borderColor = UIColor.black.cgColor
        viewSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageApp)
        contentView.addSubview(nameApp)
        contentView.addSubview(artistApp)
        contentView.addSubview(categoryApp)
        contentView.addSubview(priceApp)
        contentView.addSubview(rank)
        contentView.addSubview(viewSeparator)
        
        NSLayoutConstraint.activate([
            
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            contentView.widthAnchor.constraint(equalToConstant: self.bounds.width),
            contentView.heightAnchor.constraint(equalToConstant: 130),
            
            imageApp.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageApp.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageApp.widthAnchor.constraint(equalToConstant: 100),
            imageApp.heightAnchor.constraint(equalToConstant: 100),
            
            nameApp.leadingAnchor.constraint(equalTo: imageApp.trailingAnchor, constant: 10),
            nameApp.topAnchor.constraint(equalTo: imageApp.topAnchor),
            nameApp.trailingAnchor.constraint(equalTo: rank.leadingAnchor),
            nameApp.heightAnchor.constraint(equalTo: imageApp.heightAnchor, multiplier: 1/4),
            
            artistApp.leadingAnchor.constraint(equalTo: imageApp.trailingAnchor, constant: 10),
            artistApp.topAnchor.constraint(equalTo: nameApp.bottomAnchor),
            artistApp.trailingAnchor.constraint(equalTo: rank.leadingAnchor),
            artistApp.heightAnchor.constraint(equalTo: imageApp.heightAnchor, multiplier: 1/4),
            
            categoryApp.leadingAnchor.constraint(equalTo: imageApp.trailingAnchor, constant: 10),
            categoryApp.topAnchor.constraint(equalTo: artistApp.bottomAnchor),
            categoryApp.trailingAnchor.constraint(equalTo: rank.leadingAnchor),
            categoryApp.heightAnchor.constraint(equalTo: imageApp.heightAnchor, multiplier: 1/4),
            
            priceApp.leadingAnchor.constraint(equalTo: imageApp.trailingAnchor, constant: 10),
            priceApp.topAnchor.constraint(equalTo: categoryApp.bottomAnchor),
            priceApp.trailingAnchor.constraint(equalTo: rank.leadingAnchor),
            priceApp.bottomAnchor.constraint(equalTo: imageApp.bottomAnchor),
            priceApp.heightAnchor.constraint(equalTo: imageApp.heightAnchor, multiplier: 1/4),
            
            rank.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            rank.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rank.widthAnchor.constraint(equalToConstant: 45),
            rank.heightAnchor.constraint(equalToConstant: 45),
            
            viewSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            viewSeparator.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            viewSeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            viewSeparator.heightAnchor.constraint(equalToConstant: 1)
            
        ])
    }
    
    func setItems(item: HomeControllerModel, indexPath: IndexPath) {
        if let url_img = URL(string: item.image_app ?? "") {
            imageApp.af_setImage(withURL: url_img)
        }
        nameApp.text = item.name
        artistApp.text = item.artist_name
        categoryApp.text = item.category_name
        priceApp.text = item.price
        rank.text = ("# \(indexPath.row)")
    }
}
