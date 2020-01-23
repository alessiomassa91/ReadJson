//
//  JsonTypeResponse.swift
//  ReadJson
//
//  Created by Alessio Massa on 18/12/2019.
//  Copyright © 2019 Alessio Massa. All rights reserved.
//

import Foundation

enum JsonTypeResponse: String {
 
    case networkOK
    case networkError
    case serverError
    
    /// The purpose of this method is to catch how the Json reading project goes.
    /// - Parameters:
    ///   - networkResponse: Type response: networkOK, networkError or networkError are available.
    ///   - data: Data from the completionHandler in the Task
    ///   - error: Error  from the completionHandler in the Task
    static func getNetworkResponse(networkResponse: JsonTypeResponse) -> (JsonTypeResponse, String, String, String) {
 
        switch networkResponse {
         
            ///No alert.
        case .networkOK:
    
            let alertTitle = ""
            let alertContext = ""
            let alertButton = ""
            return(.networkOK, alertTitle, alertContext, alertButton)
            
            ///Prepare the text inside the labelNoConnection.
        case .networkError:
            
            let alertTitle = ""
            let alertContext = networkErrorContextTranslation
            let alertButton = ""
            return(.networkError, alertTitle, alertContext, alertButton)
            
            ///Server error, prepare the alert.
        case .serverError:
            let alertTitle = serverErrorTitleTranslation
            let alertContext = serverErrorContextTranslation
            let alertButton = serverErrorButtonTranslation
            return(.serverError, alertTitle, alertContext, alertButton)
        }
 
    }
}

//
// MARK: - Constant Localized String
//
fileprivate let serverErrorTitleTranslation = NSLocalizedString("SERVER_ERROR_ALERT_TITLE", comment: "")
fileprivate let serverErrorContextTranslation = NSLocalizedString("SERVER_ERROR_ALERT_CONTEXT", comment: "")
fileprivate let serverErrorButtonTranslation = NSLocalizedString("SERVER_ERROR_ALERT_BUTTON", comment: "")
fileprivate let networkErrorContextTranslation = NSLocalizedString("NETWORK_ERROR_ALERT_CONTEXT", comment: "")
