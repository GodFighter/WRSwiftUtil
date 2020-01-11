//
//  WRView.swift
//  WRSwiftUtilDemo
//
//  Created by 项辉 on 2020/1/5.
//  Copyright © 2020 xianghui. All rights reserved.
//

import UIKit

//MARK:-
@objc extension UIView : WRViewProtocol {
    
    public override var wr: WRViewExtension {
        return WRViewExtension(self)
    }
}

@objc public protocol WRViewProtocol{
    var wr: WRViewExtension { get }
}

@objc public class WRViewExtension: WRObjectExtension{
    internal init(_ value: UIView){
        super.init(value)
        self.value = value
    }
    
    @objc public func clipCorner(_ corners: UIRectCorner, cornerRadius: CGSize) {
        if let view = self.value as? UIView {
            let maskBezier = UIBezierPath.init(roundedRect: CGRect.init(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), byRoundingCorners: corners, cornerRadii: cornerRadius)
            let maskLayer = CAShapeLayer.init()
            maskLayer.frame = CGRect.init(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
            maskLayer.path = maskBezier.cgPath
            view.layer.mask = maskLayer
        }
    }

}
