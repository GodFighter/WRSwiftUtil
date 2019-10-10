//
//  String+Regular.swift
//  WRSwiftUtilDemo
//
//  Created by 项辉 on 2019/10/10.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit

public extension String {
    
    fileprivate static func validate(_ text: String, pattern: String) -> Bool {
        
        do {
            let regex: NSRegularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let matches = regex.matches(in: text, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, text.count))
            return matches.count > 0
        }
        catch {
            return false
        }
    }
    var isIP : Bool {
        return String.validate(self, pattern: "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
    }
    var isUrl : Bool {
        return String.validate(self, pattern:  "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$")
    }
    var isEmail : Bool {
        return String.validate(self, pattern: "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$")
    }
    var isPhone : Bool {
        return String.validate(self, pattern: "^(1)\\d{10}$")
    }
    var isCar: Bool {
        return String.validate(self, pattern: "^[A-Za-z]{1}[A-Za-z_0-9]{5}$")
    }
    
    
}
