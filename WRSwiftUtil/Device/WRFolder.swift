//
//  WRFolder.swift
//  WRSwiftUtilDemo
//
//  Created by xianghui-iMac on 2019/12/27.
//  Copyright © 2019 moni. All rights reserved.
//

import UIKit

//
//  WRFolder.swift
//  WRSwiftUtilDemo
//
//  Created by xianghui-iMac on 2019/12/27.
//  Copyright © 2019 moni. All rights reserved.
//

import UIKit

@objc public class WRFolder: NSObject {
    
    public static var cacheUrl : URL?
    
    public static var cacheFolderSize : String {
        guard let cacheUrl = self.cacheUrl else {
            return "0 KB"
        }
        let folderSize = self.folderSize(cacheUrl)
        return ByteCountFormatter.string(fromByteCount: folderSize, countStyle: .file)
    }

    public static func removeCacheFolder() {
        guard let cacheUrl = self.cacheUrl else {
            return
        }
        do {
            try FileManager.default.removeItem(atPath: cacheUrl.absoluteString)
        } catch {
            debugPrint("\(error)")
        }
    }

    public static func folderSize(_ url : URL) -> Int64 {
    
        let contents: [URL]
        do {
            contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: [.fileSizeKey, .isDirectoryKey])
        } catch {
            return 0
        }

        var size: Int64 = 0

        for url in contents {
            let isDirectoryResourceValue: URLResourceValues
            do {
                isDirectoryResourceValue = try url.resourceValues(forKeys: [.isDirectoryKey])
            } catch {
                continue
            }

            if isDirectoryResourceValue.isDirectory == true {
                size += WRFolder.folderSize(url)
            } else {
                let fileSizeResourceValue: URLResourceValues
                do {
                    fileSizeResourceValue = try url.resourceValues(forKeys: [.fileSizeKey])
                } catch {
                    continue
                }

                size += Int64(fileSizeResourceValue.fileSize ?? 0)
            }
        }
        return size
    }
    
    public static func removeFolder(_ url : URL) {
        do {
            try FileManager.default.removeItem(atPath: url.absoluteString)
        } catch {
            debugPrint("\(error)")
        }
    }
}
