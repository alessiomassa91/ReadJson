//
//  NetworkManagerDelegate.swift
//  ReadJson
//
//  Created by Alessio Massa on 18/12/2019.
//  Copyright © 2019 Alessio Massa. All rights reserved.
//

import Foundation

protocol NetworkManagerDelegate: class {
    
    /// The reading Json process has been successfully completed.
    /// - Parameter response: The parameter response contain:
    /// - response.0 : The type of the Json Response, in this case the response type will be .networkOK;
    /// - response.1 : Title Text Alert. It was setted with an empty value, because is not necessary an alert. Check JsonTypeResponse.swift file;
    /// - response.2 : Context Text Alert. It was setted with an empty value, because is not necessary an alert. Check JsonTypeResponse.swift file;
    /// - response.3 : Button Text Alert. It was setted with an empty value, because is not necessary an alert. Check JsonTypeResponse.swift file;
    /// - response.3 : Label Text Context. It was setted with an empty value, because is not necessary an alert. Check JsonTypeResponse.swift file;
    func networkFinishedWithData(response: (JsonTypeResponse, String, String, String, String))
    
    ///  The reading Json process has been completed in failure
    /// - Parameter response: The parameter response contain:
    /// - response.0 : The type of the Json Response. n this case the response type will be .networkError or .serverError;
    /// - response.1 : Title Text Alert. Check JsonTypeResponse.swift file;
    /// - response.2 : Context Text Alert. Check JsonTypeResponse.swift file;
    /// - response.3 : Button Text Alert. Check JsonTypeResponse.swift file;
    /// - response.3 : Label Text Context. Check JsonTypeResponse.swift file;
    func networkFinishedWithError(response: (JsonTypeResponse, String, String, String, String))
}
