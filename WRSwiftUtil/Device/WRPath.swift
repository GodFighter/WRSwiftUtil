//
//  WRPath.swift
//  WRSwiftUtilDemo
//
//  Created by xianghui on 2019/9/16.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit

/// 路径
public struct WRPath {

    private init(){}

    public static let temp     = NSTemporaryDirectory()
    public static let libCache = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
    public static let document = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

    public static var database : String {
        return WRPath.document + "/\(WRDevice.Info.appName).db"
    }
    public static func createDirectory(_ folderName : String) -> String {
        let directory = WRPath.document + "/\(folderName)"
        if !FileManager.default.fileExists(atPath: directory) {
            try? FileManager.default.createDirectory(atPath: directory, withIntermediateDirectories: true, attributes: nil)
        }
        return directory
    }
}
