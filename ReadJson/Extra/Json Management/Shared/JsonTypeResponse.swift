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
    static func getNetworkResponse(networkResponse: JsonTypeResponse) -> (JsonTypeResponse, String, String, String, String) {
 
        switch networkResponse {
         
            ///No alert, no labelNoConnection
        case .networkOK:
    
            let alertTitle = ""
            let alertContext = ""
            let alertButton = ""
            let labelContext = ""
            return(.networkOK, alertTitle, alertContext, alertButton, labelContext)
            
            ///Prepare the text inside the labelNoConnection and the alert.
        case .networkError:
            
            let alertTitle = serverErrorTitleTranslation
            let alertContext = serverErrorContextTranslation
            let alertButton = serverErrorButtonTranslation
            let labelContext = networkErrorContextTranslation
            return(.networkError, alertTitle, alertContext, alertButton, labelContext)
            
            ///Prepare the text inside the labelNoConnection and the alert.
        case .serverError:
            let alertTitle = serverErrorTitleTranslation
            let alertContext = serverErrorContextTranslation
            let alertButton = serverErrorButtonTranslation
            let labelContext = networkErrorContextTranslation
            return(.serverError, alertTitle, alertContext, alertButton, labelContext)
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
