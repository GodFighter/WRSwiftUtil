//
//  WRString.swift
//  WRSwiftUtilDemo
//
//  Created by 项辉 on 2020/1/5.
//  Copyright © 2020 xianghui. All rights reserved.
//

import UIKit

extension String : WRStringProtocol {
    public var wr: WRStringExtension {
        return WRStringExtension(self)
    }
}

public protocol WRStringProtocol{
    var wr: WRStringExtension { get }
}

public struct WRStringExtension{
    fileprivate let value: String

    fileprivate init(_ value: String){
        self.value = value
    }
    
    //MARK:-  path
    public var pathExtension: String {
        return (self.value as NSString).pathExtension
    }
    
    public var lastPathComponent: String {
        return (self.value as NSString).lastPathComponent
    }
    
    public var deletingLastPathComponent: String {
        return (self.value as NSString).deletingLastPathComponent
    }
    
    public var deletingPathExtension: String {
        return (self.value as NSString).deletingPathExtension
    }
    
    public var abbreviatingWithTildeInPath: String {
        return (self.value as NSString).abbreviatingWithTildeInPath
    }
    
    public func appendingPathComponent(_ pathComponent: String) -> String {
        return (self.value as NSString).appendingPathComponent(pathComponent)
    }
    
    public func appendingPathExtension(_ pathExtension: String) -> String {
        return (self.value as NSString).appendingPathExtension(pathExtension) ?? self.value + "." + pathExtension
    }
    
    //MARK:-  Regular
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
        return WRStringExtension.validate(self.value, pattern: "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
    }
    var isUrl : Bool {
        return WRStringExtension.validate(self.value, pattern:  "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$")
    }
    var isEmail : Bool {
        return WRStringExtension.validate(self.value, pattern: "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$")
    }
    var isPhone : Bool {
        return WRStringExtension.validate(self.value, pattern: "^(1)\\d{10}$")
    }
    var isCar: Bool {
        return WRStringExtension.validate(self.value, pattern: "^[A-Za-z]{1}[A-Za-z_0-9]{5}$")
    }

    //MARK:-  Conversion
    var htmlString : String? {
        guard let data = self.value.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString(
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType:
                NSAttributedString.DocumentType.html],
            documentAttributes: nil) else { return nil }
        return html.string
    }
    
    var stripXml: String {
        // we need to make sure "&" is escaped first. Not doing this may break escaping the other characters
        var escaped = self.value.replacingOccurrences(of: "&", with: "&amp;", options: .literal)
        
        // replace the other four special characters
        let escapeChars = ["<" : "&lt;", ">" : "&gt;", "'" : "&apos;", "\"" : "&quot;"]
        for (char, echar) in escapeChars {
            escaped = escaped.replacingOccurrences(of: char, with: echar, options: .literal)
        }
        
        return escaped
    }

    var stripHtml: String {
        return self.value.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }

    var stripLineBreaks: String {
        return self.value.replacingOccurrences(of: "\n", with: "", options: .regularExpression)
    }

    //MARK:-  Size
    func width(_ font : UIFont) -> CGFloat {
        return self.value.boundingRect(with: CGSize(), options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : font], context: nil).width
    }

    func height(width : CGFloat, font : UIFont) -> CGFloat {
        return self.value.boundingRect(with: CGSize(width: width, height: 0), options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : font], context: nil).height
    }
    


}
