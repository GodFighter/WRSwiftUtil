//
//  WRView.swift
//  WRSwiftUtilDemo
//
//  Created by 项辉 on 2020/1/5.
//  Copyright © 2020 xianghui. All rights reserved.
//

import UIKit

@objc extension UIView : WRViewProtocol {
    public var wr: WRViewExtension {
        return WRViewExtension(self)
    }
}

@objc public protocol WRViewProtocol{
    var wr: WRViewExtension { get }
}

@objc public class WRViewExtension : NSObject{
    fileprivate let value: UIView

    fileprivate init(_ value: UIView){
        self.value = value
    }
    
    @objc public func clipCorner(_ corners: UIRectCorner, cornerRadius: CGSize) {
        let maskBezier = UIBezierPath.init(roundedRect: CGRect.init(x: 0, y: 0, width: self.value.bounds.width, height: self.value.bounds.height), byRoundingCorners: corners, cornerRadii: cornerRadius)
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = CGRect.init(x: 0, y: 0, width: self.value.bounds.width, height: self.value.bounds.height)
        maskLayer.path = maskBezier.cgPath
        self.value.layer.mask = maskLayer
    }

}
