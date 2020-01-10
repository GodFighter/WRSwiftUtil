//
//  WRColor.swift
//  WRSwiftUtilDemo
//
//  Created by xianghui on 2019/9/26.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit

@objc extension UIColor : UIColorProtocol {
    public override var wr: UIColorExtension {
        return UIColorExtension(self)
    }
}

@objc public protocol UIColorProtocol{
    var wr: UIColorExtension { get }
}

@objc public class UIColorExtension : WRObjectExtension {
    init(_ value: UIColor){
        super.init(value)
        self.value = value
    }
    
    @objc public var randomColor : UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(256)) / 255.0, green: CGFloat(arc4random_uniform(256)) / 255.0, blue: CGFloat(arc4random_uniform(256)) / 255.0, alpha: 1.0)
    }
}
