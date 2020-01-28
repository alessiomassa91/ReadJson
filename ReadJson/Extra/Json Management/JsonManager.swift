//
//  JsonManager.swift
//  ReadJson
//
//  Created by Alessio Massa on 18/12/2019.
//  Copyright © 2019 Alessio Massa. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class JsonManager: NSObject {
    //
    // MARK: - Variables and Properties called in other classes.
    //
    static let shared = JsonManager()
    static weak var delegate: NetworkManagerDelegate?
}

//
// MARK: - JsonManager Methods
//
extension JsonManager {
    
    func readJson(url: String, setData: ((JSON) -> Void)?)  {
        DispatchQueue.main.async {
            Alamofire.request(url).responseJSON { (response) in
                if let httpCode = response.response?.statusCode{
                    switch httpCode{
                    case 200:
                        let json = JSON(response.result.value!)
                        HomeManager.shared.jsonHomeObject = JsonHomeModel(json: json)
                        setData!(json)
                        JsonManager.self.delegate?.networkFinishedWithData(
                        response: JsonTypeResponse.getNetworkResponse(networkResponse: .networkOK))
                    case 500..<600:
                        JsonManager.self.delegate?.networkFinishedWithError(
                            response: JsonTypeResponse.getNetworkResponse(networkResponse: .serverError))
                    default:
                        print("other")
                    }
                } else {
                    JsonManager.self.delegate?.networkFinishedWithError(
                        response: JsonTypeResponse.getNetworkResponse(networkResponse: .networkError))
                }
            }
        }
    }
}
