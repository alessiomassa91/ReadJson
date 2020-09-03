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


class ParseJson: NSObject {
    static let shared = ParseJson()
    static weak var delegate: NetworkManagerDelegate?
}

extension ParseJson {
    
    func readJson(url: String, setData: ((JSON) -> Void)?)  {
        DispatchQueue.main.async {
            Alamofire.request(url).responseJSON { (response) in
                if let httpCode = response.response?.statusCode{
                    switch httpCode{
                    case 200:
                        guard let json = response.result.value, let setData = setData else { return }
                        setData(JSON(json))
                        ParseJson.self.delegate?.networkFinishedWithData(
                        response: JsonTypeResponse.getNetworkResponse(networkResponse: .networkOK))
                    case 500..<600:
                        ParseJson.self.delegate?.networkFinishedWithError(
                            response: JsonTypeResponse.getNetworkResponse(networkResponse: .serverError))
                    default:
                        print("other HTTP \(httpCode)")
                        ParseJson.self.delegate?.networkFinishedWithError(
                            response: JsonTypeResponse.getNetworkResponse(networkResponse: .serverError))
                    }
                } else {
                    ParseJson.self.delegate?.networkFinishedWithError(
                        response: JsonTypeResponse.getNetworkResponse(networkResponse: .networkError))
                }
            }
        }
    }
    
    func readOfflineJson(setData: ((JSON) -> Void)?) {
        let jsonURL = Bundle.main.url(forResource: "json", withExtension: "json")!
        let jsonData = try! Data(contentsOf: jsonURL)
        guard let json = try? JSON(data: jsonData, options: [.allowFragments]), let setData = setData else {return}
        setData(JSON(json))
        ParseJson.self.delegate?.networkFinishedWithData(
            response: JsonTypeResponse.getNetworkResponse(networkResponse: .networkOK))
    }
}
