//
//  WRNotifyProtocol.swift
//  WRSwiftUtilDemo
//
//  Created by 项辉 on 2019/11/13.
//  Copyright © 2019 xianghui. All rights reserved.
//

import Foundation

public protocol WRNotifyProtocol {
    
    var key : String { get }
    var rawValue : String { get }
    
    var name : Notification.Name    { get }
    var failed : Notification.Name  { get }
    var success : Notification.Name { get }
}

extension WRNotifyProtocol{
   
    internal var name : Notification.Name {
        return Notification.Name("\(self.key)_Notify_\(self.rawValue)")
    }
    
    internal var failed : Notification.Name {
        return Notification.Name("\(self.key)_Notify_\(self.rawValue)_Failed")
    }
    
    internal var success : Notification.Name {
        return Notification.Name("\(self.key)_Notify_\(self.rawValue)_Success")
    }
}
