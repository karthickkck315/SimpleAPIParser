//
//  UIFont+CustomFont.swift
//  Hoovene
//
//  Created by Karthick on 12/06/17.
//  Copyright © 2017 Technoduce. All rights reserved.
//

import UIKit

//MARK: - Set Font Name
enum FontName: String {
  
  case regular      = "AraHamahHoms-Regular"
  
}

//MARK: - Set Font Size
enum FontSize: CGFloat {
    case size10 = 10
    case size12 = 12
    case size14 = 14
    case size16 = 16
    case size18 = 18
    case size20 = 20
    case size22 = 22
    case size25 = 25
    case size28 = 28
}

extension UIFont {
    
  
    //MARK: - Regular Font
  class var regularFont10: UIFont {
        return UIFont(name: FontName.regular.rawValue, size: FontSize.size10.rawValue)!
    }
  class var regularFont12: UIFont {
        return UIFont(name: FontName.regular.rawValue, size: FontSize.size12.rawValue)!
    }
  class var regularFont14: UIFont {
        return UIFont(name: FontName.regular.rawValue, size: FontSize.size14.rawValue)!
    }
  class var regularFont16: UIFont {
        return UIFont(name: FontName.regular.rawValue, size: FontSize.size16.rawValue)!
    }
  class var regularFont18: UIFont {
    return UIFont(name: FontName.regular.rawValue, size: FontSize.size18.rawValue)!
  }
  class var regularFont20: UIFont {
        return UIFont(name: FontName.regular.rawValue, size: FontSize.size20.rawValue)!
    }
  class var regularFont22: UIFont {
        return UIFont(name: FontName.regular.rawValue, size: FontSize.size22.rawValue)!
    }
  class var regularFont25: UIFont {
    return UIFont(name: FontName.regular.rawValue, size: FontSize.size25.rawValue)!
  }
  class var regularFont28: UIFont {
    return UIFont(name: FontName.regular.rawValue, size: FontSize.size28.rawValue)!
  }
}

