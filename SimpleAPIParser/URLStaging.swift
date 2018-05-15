//
//  URLStaging.swift
//  HalfFrame
//
//  Created by Karthick on 1/30/18.
//  Copyright © 2018 Karthick. All rights reserved.
//

import Foundation
import UIKit

extension URL {
 
  //http://192.168.1.106:1003/api/v1/home?date=1524658510
  // MARK:- HomeApi api
  static var HomeApi: String {
    let domain = "\(UserDefaults.standard.object(forKey: Key.UserDefaults.stagingURL) ?? "")"
    let api = domain + Route.api.rawValue
    return api + "home?"
  }
  
}

