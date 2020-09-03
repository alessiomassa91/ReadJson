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

    let homeViewModel = HomeViewModel.shared
    
    private func setExpectation(){
        let expectation = self.expectation(description: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testElementJsonHomeNotEmpty(){
        ParseJson().readJson(url: ItunesJsonModel.url, setData: ItunesJsonManager.shared.readJson)
        setExpectation()
        
    }
    
    func testLoadData(){
        setExpectation()
        ///To be sure that homeManager.storage is not empty
       // XCTAssertTrue(homeManager.storage.count > 0)
        let snapshotArray = homeViewModel.snapshot.items
        for item in snapshotArray {
            XCTAssertTrue(item.name != "")
            XCTAssertTrue(item.image_app != "")
            XCTAssertTrue(item.description != "")
            XCTAssertTrue(item.price != "")
            XCTAssertTrue(item.link_app != "")
            XCTAssertTrue(item.artist_name != "")
            XCTAssertTrue(item.category_name != "")
            XCTAssertTrue(item.release_data != "")
        }
    }
}
