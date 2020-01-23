//
//  HomeManagerTest.swift
//  ReadJsonTests
//
//  Created by Alessio Massa on 23/12/2019.
//  Copyright © 2019 Alessio Massa. All rights reserved.
//

import XCTest
@testable import ReadJson

class HomeManagerTest: XCTestCase {

    let homeManager = HomeManager.shared
    
    private func setExpectation(){
        let expectation = self.expectation(description: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testElementJsonHomeNotEmpty(){
        JsonManager().readJson(url: JsonHomeModel.url, setData: HomeManager.shared.loadData)
        setExpectation()
        XCTAssertNotNil(homeManager.jsonHomeObject)
        
    }
    
    func testLoadData(){
        setExpectation()
        ///To be sure that homeManager.storage is not empty
        XCTAssertTrue(homeManager.storage.count > 0)
        let storage = homeManager.storage
        for storageElement in storage {
            XCTAssertTrue(storageElement.name != "")
            XCTAssertTrue(storageElement.image_app != "")
            XCTAssertTrue(storageElement.description != "")
            XCTAssertTrue(storageElement.price != "")
            XCTAssertTrue(storageElement.link_app != "")
            XCTAssertTrue(storageElement.artist_name != "")
            XCTAssertTrue(storageElement.category_name != "")
            XCTAssertTrue(storageElement.release_data != "")
        }
    }
}
