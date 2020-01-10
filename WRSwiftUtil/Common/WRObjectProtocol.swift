//
//  WRObjectProtocol.swift
//  WRSwiftUtilDemo
//
//  Created by 项辉 on 2020/1/10.
//  Copyright © 2020 xianghui. All rights reserved.
//

import UIKit

@objc extension NSObject : WRObjectProtocol {
    public var wr: WRObjectExtension {
        return WRObjectExtension(self)
    }
}

@objc public protocol WRObjectProtocol{
    var wr: WRObjectExtension { get }
}

@objc public class WRObjectExtension : NSObject {
    var value: NSObject

    init(_ value: NSObject){
        self.value = value
    }
}
