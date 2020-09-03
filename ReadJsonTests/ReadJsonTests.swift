//
//  ReadJsonTests.swift
//  ReadJsonTests
//
//  Created by Alessio Massa on 18/12/2019.
//  Copyright © 2019 Alessio Massa. All rights reserved.
//

import XCTest
@testable import ReadJson

class ReadJsonTests: XCTestCase {

    let itunesJsonManager = ItunesJsonManager.shared
    
    private func setExpectation() {
        let expectation = self.expectation(description: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    
    private func initializationJson() -> ItunesJsonModel?{
        ParseJson().readJson(url: ItunesJsonModel.url, setData: itunesJsonManager.readJson)
        setExpectation()
        return itunesJsonManager.itunesJson
    }
    
    func testDataIsNotNil(){
        let dataFromJson = initializationJson()
        XCTAssertNotNil(dataFromJson)
    }
    
    func testAuthorData(){
        let dataFromJson = initializationJson()
        // MARK: - Third Level: Name - Author - Feed
        XCTAssertNotNil(dataFromJson?.feed?.author?.name)
        // MARK: - Third Level: URI - Author - Feed
        XCTAssertNotNil(dataFromJson?.feed?.author?.uri)
    }
    func testEntryData() {
        let dataFromJson = initializationJson()
        // MARK: - Second Level: Entry - Feed
        let entryArray = dataFromJson?.feed?.entry
        for entryElement in entryArray!{
            // MARK: - Third Level: Name - Entry - Feed
            XCTAssertNotNil(entryElement.im_name)
            // MARK: - Third Level: Image - Entry - Feed
            let imImageArray = entryElement.im_image
            for imImageElement in imImageArray!{
                XCTAssertNotNil(imImageElement.label)
                XCTAssertNotNil(imImageElement.height)
            }
            // MARK: - Third Level: Summary - Entry - Feed
            XCTAssertNotNil(entryElement.summary)
            // MARK: - Third Level: Price - Entry - Feed
            XCTAssertNotNil(entryElement.im_price?.price)
            XCTAssertNotNil(entryElement.im_price?.amount)
            XCTAssertNotNil(entryElement.im_price?.currency)
            // MARK: - Third Level: Content Type - Entry - Feed
            XCTAssertNotNil(entryElement.im_contentType?.term)
            XCTAssertNotNil(entryElement.im_contentType?.label)
            // MARK: - Third Level: Rights - Entry - Feed
            XCTAssertNotNil(entryElement.rights)
            // MARK: - Third Level: Title - Entry - Feed
            XCTAssertNotNil(entryElement.title)
            // MARK: - Third Level: Link - Entry - Feed
            let linkArray = entryElement.link
            for i in 0..<linkArray!.count{
                ///This filter depends on the Json structure, for i == 0 this parameters will be always nil
                if i>0 {
                 XCTAssertNotNil(entryElement.link?[i].im_duration)
                 XCTAssertNotNil(entryElement.link?[i].title)
                 XCTAssertNotNil(entryElement.link?[i].im_assetType)
                 }
                XCTAssertNotNil(entryElement.link?[i].rel)
                XCTAssertNotNil(entryElement.link?[i].type)
                XCTAssertNotNil(entryElement.link?[i].href)
            }
            // MARK: - Third Level: ID - Entry - Feed
            XCTAssertNotNil(entryElement.id?.label)
            XCTAssertNotNil(entryElement.id?.im_id)
            XCTAssertNotNil(entryElement.id?.im_bundleId)
            // MARK: - Third Level: Artist - Entry - Feed
            XCTAssertNotNil(entryElement.im_artist?.label)
            XCTAssertNotNil(entryElement.im_artist?.href)
            // MARK: - Third Level: Category - Entry - Feed
            XCTAssertNotNil(entryElement.category?.im_id)
            XCTAssertNotNil(entryElement.category?.term)
            XCTAssertNotNil(entryElement.category?.scheme)
            XCTAssertNotNil(entryElement.category?.label)
            // MARK: - Third Level: Release Date - Entry - Feed
            XCTAssertNotNil(entryElement.im_releaseDate?.label)
            XCTAssertNotNil(entryElement.im_releaseDate?.attributes_label)
        }
        
    }
    
    func testOthers() {
        let dataFromJson = initializationJson()
        // MARK: - Second Level: Updated - Feed
        XCTAssertNotNil(dataFromJson?.feed?.updated)
        // MARK: - Second Level: Rights - Feed
        XCTAssertNotNil(dataFromJson?.feed?.rights)
        // MARK: - Second Level: Title - Feed
        XCTAssertNotNil(dataFromJson?.feed?.title)
        // MARK: - Second Level: Icon - Feed
        XCTAssertNotNil(dataFromJson?.feed?.icon)
        // MARK: - Second Level: Link - Feed
        let arrayLink = dataFromJson?.feed?.link
        for i in 0..<arrayLink!.count {
            ///This filter depends on the Json structure, for i == 1 arrayLink.type will be always nil
            if i == 0 {
                XCTAssertNotNil(arrayLink![i].type)
            }
            XCTAssertNotNil(arrayLink![i].rel)
            XCTAssertNotNil(arrayLink![i].href)
        }
        // MARK: - Second Level: ID - Feed
        XCTAssertNotNil(dataFromJson?.feed?.id)
    }

}
