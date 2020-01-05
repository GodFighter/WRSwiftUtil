//
//  WRTimeInterval.swift
//  WRSwiftUtilDemo
//
//  Created by 项辉 on 2020/1/5.
//  Copyright © 2020 xianghui. All rights reserved.
//

import UIKit

extension TimeInterval : WRTimeIntervalProtocol {
    public var wr: WRTimeIntervalExtension {
        return WRTimeIntervalExtension(self)
    }
}

public protocol WRTimeIntervalProtocol{
    var wr: WRTimeIntervalExtension { get }
}

public struct WRTimeIntervalExtension{
    fileprivate let value: TimeInterval

    fileprivate init(_ value: TimeInterval){
        self.value = value
    }
    
    public func durationString(_ unit : NSCalendar.Unit) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = unit
        formatter.zeroFormattingBehavior = .pad
        if self.value.isNaN {
            return ""
        }
        return formatter.string(from: self.value)!
    }

}
