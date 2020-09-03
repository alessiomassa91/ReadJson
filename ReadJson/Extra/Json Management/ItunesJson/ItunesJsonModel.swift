//
//  JsonHomeModel.swift
//  ReadJson
//
//  Created by Alessio Massa on 03/09/2020.
//  Copyright © 2020 Alessio Massa. All rights reserved.
//

import Foundation
import SwiftyJSON

fileprivate let URL = "https://itunes.apple.com/us/rss/toppaidapplications/limit=200/json"
//MARK: - First Level: Feed
fileprivate let FEED_OBJECT = "feed"
// MARK: - Second Level: Author - Feed
fileprivate let AUTHOR_OBJECT = "author"
/// Name
fileprivate let AUTHOR_NAME = ("name","label")
/// URI
fileprivate let AUTHOR_URI = ("uri","label")
// MARK: - Second Level: ID - Feed
fileprivate let ENTRY_ARRAY = "entry"
// MARK: - Third Level: Name - Entry - Feed
fileprivate let ENTRY_IM_NAME = ("im:name","label")
// MARK: - Third Level: Image - Entry - Feed
fileprivate let ENTRY_IM_IMAGE_ARRAY = "im:image"
fileprivate let ENTRY_IM_IMAGE_LABEL = ("label")
fileprivate let ENTRY_IM_IMAGE_HEIGHT = ("attributes","height")
// MARK: - Third Level: Summary - Entry - Feed
fileprivate let ENTRY_SUMMARY = ("summary","label")
// MARK: - Third Level: Price - Entry - Feed
fileprivate let ENTRY_IM_PRICE_OBJECT = "im:price"
fileprivate let ENTRY_IM_PRICE_LABEL = ("label")
fileprivate let ENTRY_IM_PRICE_AMOUNT = ("attributes","amount")
fileprivate let ENTRY_IM_PRICE_CURRENCY = ("attributes","currency")
// MARK: - Third Level: Content Type - Entry - Feed
fileprivate let ENTRY_IM_CONTENT_TYPE_OBJECT = "im:contentType"
fileprivate let ENTRY_IM_CONTENT_TYPE_TERM = ("attributes","term")
fileprivate let ENTRY_IM_CONTENT_TYPE_LABEL = ("attributes","label")
// MARK: - Third Level: Rights - Entry - Feed
fileprivate let ENTRY_RIGHTS = ("rights","label")
// MARK: - Third Level: Title - Entry - Feed
fileprivate let ENTRY_TITLE = ("title","label")
// MARK: - Third Level: Link - Entry - Feed
fileprivate let ENTRY_LINK_ARRAY = "link"
fileprivate let ENTRY_LINK_IM_DURATION = ("im:duration","label")
fileprivate let ENTRY_LINK_TITLE = ("attributes","title")
fileprivate let ENTRY_LINK_REL = ("attributes","rel")
fileprivate let ENTRY_LINK_TYPE = ("attributes","type")
fileprivate let ENTRY_LINK_HREF = ("attributes","href")
fileprivate let ENTRY_LINK_IM_ASSET_TYPE = ("attributes","im:assetType")
// MARK: - Third Level: ID - Entry - Feed
fileprivate let ENTRY_ID_OBJECT = "id"
fileprivate let ENTRY_ID_LABEL = ("label")
fileprivate let ENTRY_ID_IM_ID = ("attributes","im:id")
fileprivate let ENTRY_ID_IM_BUNDLE = ("attributes","im:bundleId")
// MARK: - Third Level: Artist - Entry - Feed
fileprivate let ENTRY_IM_ARTIST_OBJECT = "im:artist"
fileprivate let ENTRY_IM_ARTIST_LABEL = ("label")
fileprivate let ENTRY_IM_ARTIST_HREF = ("attributes","href")
// MARK: - Third Level: Category - Entry - Feed
fileprivate let ENTRY_CATEGORY_OBJECT = "category"
fileprivate let ENTRY_CATEGORY_IM_ID = ("attributes","im:id")
fileprivate let ENTRY_CATEGORY_TERM = ("attributes","term")
fileprivate let ENTRY_CATEGORY_SCHEME = ("attributes","scheme")
fileprivate let ENTRY_CATEGORY_LABEL = ("attributes","label")
// MARK: - Third Level: Release Date - Entry - Feed
fileprivate let ENTRY_IM_RELEASE_DATE_OBJECT = "im:releaseDate"
fileprivate let ENTRY_IM_RELEASE_DATE_LABEL = ("label")
fileprivate let ENTRY_IM_RELEASE_DATE_ATTRIBUTES = ("attributes","label")
// MARK: - Second Level: Updated - Feed
fileprivate let UPDATED_OBJECT = ("updated","label")
// MARK: - Second Level: Rights - Feed
fileprivate let RIGHTS_OBJECT = ("rights","label")
// MARK: - Second Level: Title - Feed
fileprivate let TITLE_OBJECT = ("title","label")
// MARK: - Second Level: Icon - Feed
fileprivate let ICON_OBJECT = ("icon","label")
// MARK: - Second Level: Link - Feed
fileprivate let LINK_ARRAY = "link"
fileprivate let LINK_REL = ("attributes","rel")
fileprivate let LINK_TYPE = ("attributes","type")
fileprivate let LINK_HREF = ("attributes","href")
// MARK: - Second Level: Id - Feed
fileprivate let ID_OBJECT = ("id","label")

class ItunesJsonModel {
    
    static let url = URL
    var feed: Feed?
    //MARK: - First Level: Feed
    struct Feed {
        // MARK: - Second Level: Author - Feed
        var author: Author?
        struct Author {
            // MARK: - Third Level: Name - Author - Feed
            var name :String?
            // MARK: - Third Level: URI - Author - Feed
            var uri: String?
            
            init(json: JSON) {
                self.name = json[AUTHOR_NAME.0][AUTHOR_NAME.1].string
                self.uri = json[AUTHOR_URI.0][AUTHOR_URI.1].string
            }
        }
        // MARK: - Second Level: Entry - Feed
        var entry: [Entry]?
        struct Entry {
            // MARK: - Third Level: Name - Entry - Feed
            var im_name: String?
            // MARK: - Third Level: Image - Entry - Feed
            var im_image: [ImImage]?
            struct ImImage {
                var label: String?
                var height: String?
                init(json: JSON) {
                    self.label = json[ENTRY_IM_IMAGE_LABEL].string
                    self.height = json[ENTRY_IM_IMAGE_HEIGHT.0][ENTRY_IM_IMAGE_HEIGHT.1].string
                }
            }
            // MARK: - Third Level: Summary - Entry - Feed
            var summary: String?
            // MARK: - Third Level: Price - Entry - Feed
            var im_price: ImPrice?
            struct ImPrice {
                var price: String?
                var amount: String?
                var currency: String?
                
                init(json: JSON) {
                    self.price = json[ENTRY_IM_PRICE_LABEL].string
                    self.amount = json[ENTRY_IM_PRICE_AMOUNT.0][ENTRY_IM_PRICE_AMOUNT.1].string
                    self.currency = json[ENTRY_IM_PRICE_CURRENCY.0][ENTRY_IM_PRICE_CURRENCY.1].string
                }
            }
            // MARK: - Third Level: Content Type - Entry - Feed
            var im_contentType: ImContentType?
            struct ImContentType {
                var term: String?
                var label: String?
                init(json: JSON) {
                    self.term = json[ENTRY_IM_CONTENT_TYPE_TERM.0][ENTRY_IM_CONTENT_TYPE_TERM.1].string
                    self.label = json[ENTRY_IM_CONTENT_TYPE_LABEL.0][ENTRY_IM_CONTENT_TYPE_LABEL.1].string
                }
            }
            // MARK: - Third Level: Rights - Entry - Feed
            var rights: String?
            // MARK: - Third Level: Title - Entry - Feed
            var title: String?
            // MARK: - Third Level: Link - Entry - Feed
            var link: [Link]?
            struct Link {
                var im_duration: String?
                var title: String?
                var rel: String?
                var type: String?
                var href: String?
                var im_assetType: String?
                
                init(json: JSON) {
                    self.im_duration = json[ENTRY_LINK_IM_DURATION.0][ENTRY_LINK_IM_DURATION.1].string
                    self.title = json[ENTRY_LINK_TITLE.0][ENTRY_LINK_TITLE.1].string
                    self.rel = json[ENTRY_LINK_REL.0][ENTRY_LINK_REL.1].string
                    self.type = json[ENTRY_LINK_TYPE.0][ENTRY_LINK_TYPE.1].string
                    self.href = json[ENTRY_LINK_HREF.0][ENTRY_LINK_HREF.1].string
                    self.im_assetType = json[ENTRY_LINK_IM_ASSET_TYPE.0][ENTRY_LINK_IM_ASSET_TYPE.1].string
                    
                }
            }
            // MARK: - Third Level: ID - Entry - Feed
            var id: Id?
            struct Id {
                
                var label: String?
                var im_id: String?
                var im_bundleId: String?
                
                init(json: JSON) {
                    self.label = json[ENTRY_ID_LABEL].string
                    self.im_id = json[ENTRY_ID_IM_ID.0][ENTRY_ID_IM_ID.1].string
                    self.im_bundleId = json[ENTRY_ID_IM_BUNDLE.0][ENTRY_ID_IM_BUNDLE.1].string
                }
            }
            // MARK: - Third Level: Artist - Entry - Feed
            var im_artist: ImArtist?
            struct ImArtist {
                var label: String?
                var href: String?
                
                init(json: JSON) {
                    self.label = json[ENTRY_IM_ARTIST_LABEL].string
                    self.href = json[ENTRY_IM_ARTIST_HREF.0][ENTRY_IM_ARTIST_HREF.1].string
                }
            }
            // MARK: - Third Level: Category - Entry - Feed
            var category: Category?
            struct Category {
                var im_id: String?
                var term: String?
                var scheme: String?
                var label: String?
                
                init(json: JSON) {
                    self.im_id = json[ENTRY_CATEGORY_IM_ID.0][ENTRY_CATEGORY_IM_ID.1].string
                    self.term = json[ENTRY_CATEGORY_TERM.0][ENTRY_CATEGORY_TERM.1].string
                    self.scheme = json[ENTRY_CATEGORY_SCHEME.0][ENTRY_CATEGORY_SCHEME.1].string
                    self.label = json[ENTRY_CATEGORY_LABEL.0][ENTRY_CATEGORY_LABEL.1].string
                }
            }
            // MARK: - Third Level: Release Date - Entry - Feed
            var im_releaseDate: ImReleaseDate?
            struct ImReleaseDate {
                let label: String?
                let attributes_label: String?
                
                init(json: JSON) {
                    self.label = json[ENTRY_IM_RELEASE_DATE_LABEL].string
                    self.attributes_label = json[ENTRY_IM_RELEASE_DATE_ATTRIBUTES.0][ENTRY_IM_RELEASE_DATE_ATTRIBUTES.1].string
                }
            }
            
            init(json: JSON) {
                /// Im:Name
                self.im_name = json[ENTRY_IM_NAME.0][ENTRY_IM_NAME.1].string
                /// Im:Image
                var imImageArray = [ImImage]()
                json[ENTRY_IM_IMAGE_ARRAY].forEach { (imImageElement) in
                    imImageArray.append(ImImage(json: imImageElement.1))
                    self.im_image?.append(ImImage(json: imImageElement.1))
                }
                self.im_image = imImageArray
                /// Summary
                self.summary = json[ENTRY_SUMMARY.0][ENTRY_SUMMARY.1].string
                /// Im:Price
                self.im_price = ImPrice(json: json[ENTRY_IM_PRICE_OBJECT])
                /// Im:ContentType
                self.im_contentType = ImContentType(json: json[ENTRY_IM_CONTENT_TYPE_OBJECT])
                /// Rights
                self.rights = json[ENTRY_RIGHTS.0][ENTRY_RIGHTS.1].string
                /// Title
                self.title = json[ENTRY_TITLE.0][ENTRY_TITLE.1].string
                /// Link
                var linkArray = [Link]()
                json[ENTRY_LINK_ARRAY].forEach { (linkElement) in
                    linkArray.append(Link(json: linkElement.1))
                }
                self.link = linkArray
                /// Id
                self.id = Id(json: json[ENTRY_ID_OBJECT])
                /// Im:Artist
                self.im_artist = ImArtist(json: json[ENTRY_IM_ARTIST_OBJECT])
                /// Category
                self.category = Category(json: json[ENTRY_CATEGORY_OBJECT])
                /// Im:ReleaseDate
                self.im_releaseDate = ImReleaseDate(json: json[ENTRY_IM_RELEASE_DATE_OBJECT])
            }
        }
        // MARK: - Second Level: Updated - Feed
        let updated: String?
        // MARK: - Second Level: Rights - Feed
        let rights: String?
        // MARK: - Second Level: Title - Feed
        let title: String?
        // MARK: - Second Level: Icon - Feed
        let icon: String?
        // MARK: - Second Level: Link - Feed
        var link: [Link]?
        struct Link {
            var rel: String?
            var type: String?
            var href: String?
            init(json: JSON) {
                
                self.rel = json[LINK_REL.0][LINK_REL.1].string
                self.type = json[LINK_TYPE.0][LINK_TYPE.1].string
                self.href = json[LINK_HREF.0][LINK_HREF.1].string
                
            }
        }
        // MARK: - Second Level: ID - Feed
        let id: String?
        
        init(json: JSON) {
            ///Author
            self.author = Author(json: json[AUTHOR_OBJECT])
            ///Entry
            var entryArray = [Entry]()
            json[ENTRY_ARRAY].forEach { (entryElement) in
                entryArray.append(Entry(json: entryElement.1))
            }
            self.entry = entryArray
            ///Updated
            self.updated = json[UPDATED_OBJECT.0][UPDATED_OBJECT.1].string
            ///Rights
            self.rights = json[RIGHTS_OBJECT.0][RIGHTS_OBJECT.1].string
            ///Title
            self.title = json[TITLE_OBJECT.0][TITLE_OBJECT.1].string
            ///Icon
            self.icon = json[ICON_OBJECT.0][ICON_OBJECT.1].string
            ///Link Array
            var linkArray = [Link]()
            json[LINK_ARRAY].forEach { (linkElement) in
                linkArray.append(Link(json: linkElement.1))
            }
            self.link = linkArray
            ///ID
            self.id = json[ID_OBJECT.0][ID_OBJECT.1].string
        }
    }
    
    init(json: JSON) {
        ///Feed
        self.feed = Feed(json: json[FEED_OBJECT])
    }
    
    
}


