//
//  WRColor.swift
//  WRSwiftUtilDemo
//
//  Created by xianghui on 2019/9/26.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit

public struct WRColor {

    private init(){}

    public static func randomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(256)) / 255.0, green: CGFloat(arc4random_uniform(256)) / 255.0, blue: CGFloat(arc4random_uniform(256)) / 255.0, alpha: 1.0)
    }
}
