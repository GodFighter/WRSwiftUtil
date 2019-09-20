//
//  WRNavigationBarProtocol.swift
//  WRSwiftUtilDemo
//
//  Created by xianghui on 2019/9/20.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit

@objc public protocol WRNavigationBarProtocol : class {
    
}

public extension WRNavigationBarProtocol where Self : UIViewController {
    
    var naviBarBackgroundView : UIView? {
        return (self.navigationController?.navigationBar as? WRNavigationBar)?.backgroundView
    }
    
    var naviBarBackgroundImageView : UIImageView? {
        return (self.navigationController?.navigationBar as? WRNavigationBar)?.backgroundImageView
    }

    // Only navigationBar.isTranslucent equals true and effective
    func setNaviBarImage(_ image: UIImage?){
        self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
    }

    // Only navigationBar.isTranslucent equals false and effective
    func setNaviBarColor(_ barColor: UIColor?){
        self.navigationController?.navigationBar.barTintColor = barColor
    }

    func setNaviTintColor(_ tintColor: UIColor){
        self.navigationController?.navigationBar.tintColor = tintColor
    }

    func setNaviTitleColor(_ titleColor: UIColor){
        
        var titleTextAttributes: [NSAttributedString.Key : AnyObject] =  [NSAttributedString.Key : AnyObject]()
        titleTextAttributes[NSAttributedString.Key.foregroundColor] = titleColor
        
        if #available(iOS 8.2, *) {
            titleTextAttributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
        } else {
            titleTextAttributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 17)
            // Fallback on earlier versions
        }
        self.navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
    }

    func setNaviShadowColor(_ shadowColor: UIColor){
        self.navigationController?.navigationBar.shadowImage = WRImage.color(CGSize(width: UIScreen.main.bounds.width, height: 1), shadowColor)
    }

    func setNaviBarTitleColor(_ tintColor: UIColor, titleColor: UIColor, shadowColor: UIColor? = nil){
        self.setNaviBarColor(tintColor)
        self.setNaviTitleColor(titleColor)
        if let shadowColor = shadowColor{
            self.setNaviShadowColor(shadowColor)
        }
    }

}

fileprivate typealias WRNavigationBarProtocol_BackTitle = WRNavigationBarProtocol
public extension WRNavigationBarProtocol_BackTitle where Self : UIViewController{
    
    @discardableResult
    func setNaviBackTitle(_ title: String) -> UIBarButtonItem{
        let titleItem = UIBarButtonItem(title: title, style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = titleItem
        return titleItem
    }
    
    @discardableResult
    func setNaviBackTitle(_ title: String, color: UIColor) -> UIBarButtonItem{
        let titleItem = UIBarButtonItem(title: title, style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        titleItem.tintColor = color
        self.navigationItem.backBarButtonItem = titleItem
        return titleItem
    }
    
    @discardableResult
    func setNaviBackTitle(_ title: String, color: UIColor, image : UIImage?) -> UIBarButtonItem{
        
        self.navigationController?.navigationBar.backIndicatorImage = image
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = image
        
        let titleItem = UIBarButtonItem(title: title, style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        titleItem.tintColor = color
        self.navigationItem.backBarButtonItem = titleItem
        return titleItem
    }
}

fileprivate typealias WRNavigationBarProtocol_Item = WRNavigationBarProtocol
public extension WRNavigationBarProtocol_Item where Self : UIViewController{
    
    @discardableResult
    func setNaviLeftItem(_ title : String, attributes: [NSAttributedString.Key : Any]? = nil, target: Any?, selector: Selector?) -> UIBarButtonItem{
        let barButtonItem = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)
        barButtonItem.tintColor = UIColor(fromHexString: "#333333")
        barButtonItem.setTitleTextAttributes(attributes, for: .normal)
        self.navigationItem.leftBarButtonItem = barButtonItem
        return barButtonItem
    }
    
    @discardableResult
    func setNaviRightItem(_ title : String, attributes: [NSAttributedString.Key : Any]? = nil, target: Any?, selector: Selector?) -> UIBarButtonItem{
        let barButtonItem = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)
        barButtonItem.tintColor = UIColor(fromHexString: "#333333")
        barButtonItem.setTitleTextAttributes(attributes, for: .normal)
        self.navigationItem.rightBarButtonItem = barButtonItem
        return barButtonItem
    }
}
