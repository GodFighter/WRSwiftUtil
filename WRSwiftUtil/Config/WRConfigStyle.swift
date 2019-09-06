//
//  WRConfigStyle.swift
//  WRSwiftUtilDemo
//
//  Created by xianghui on 2019/9/6.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit

@_exported import Colours

public struct WRConfigStyle {
    
    //状态栏 主题 样式
    public struct StatusBar{
        
        private init() {}
        
        public static let isHidden : Bool = false
        
        public static let barStyle : UIStatusBarStyle = UIStatusBarStyle.lightContent
        
        public static let updateAnimation : UIStatusBarAnimation = UIStatusBarAnimation.slide
    }
    
    //导航栏 主题 样式
    public struct NavigationBar{
        
        private init() {}
        
        public static let tintColor : UIColor = .white                               //按钮颜色
        
        public static let shadowColor : UIColor = .clear                             //阴影颜色
        
        public static let barTintColor : UIColor? = nil                              //背景颜色
        
        public static let barTintImage : UIImage? = {                                //背景图片
            let colors : [UIColor] = [UIColor(fromHexString: "#009CFF"), UIColor(fromHexString: "#1671EF")]
            return WRImage.color(size:CGSize(width: UIScreen.main.bounds.width, height: 64), colors: colors,
                                 start: CGPoint(x:0.5, y: 0.0), end: CGPoint(x:1.0, y: 1.0))
            
        }()
        public static let mnBarTintImage : UIImage? = {                                //背景图片
            let colors : [UIColor] = [UIColor(fromHexString: "#009CFF"), UIColor(fromHexString: "#1671EF")]
            return WRImage.color(size:CGSize(width: 44, height: UIScreen.main.bounds.height), colors: colors,
                                 start: CGPoint(x:0.5, y: 0.0), end: CGPoint(x:1.0, y: 1.0))

        }()
        
        public static let titleAttributes : [NSAttributedString.Key : Any] = {        //标题属性
            return [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular),
                    NSAttributedString.Key.foregroundColor : WRConfigStyle.NavigationBar.tintColor]
        }()
        
        public static let backImage : UIImage? = UIImage(named: "navigationBar_Back")    //返回图标
        
        public static let backColor : UIColor = .white                               //返回颜色
        
        public static let backTitleAttributes : [NSAttributedString.Key : Any] = {    //返回字体
            return [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]
        }()
    }
    
    private init() {}
    
    public static func initialization(){
        
        //未测试
        //ConfigStyle.shared.initToolBar()
        WRConfigStyle.initNavigationBar()
    }
    
}

fileprivate typealias ConfigStyle_NavigationBar = WRConfigStyle
extension ConfigStyle_NavigationBar{
    
    fileprivate static func initNavigationBar(){
//                self.reset(UINavigationBar.appearance())
    }
    
    public static func addPopAnimation(_ navigationController : UINavigationController?){
        
        let transition = CATransition()
        transition.duration = 0.35
        transition.type = CATransitionType(rawValue: "reveal")
        transition.subtype = CATransitionSubtype.fromLeft
        navigationController?.view.layer.add(transition, forKey: nil)
    }
    
    public static func addPushAnimation(_ navigationController : UINavigationController?){
        
        let transition = CATransition()
        transition.duration = 0.35
        transition.type = CATransitionType(rawValue: "moveIn")
        transition.subtype = CATransitionSubtype.fromRight
        navigationController?.view.layer.add(transition, forKey: nil)
    }
    
    public static func reset(_ navigationBar: UINavigationBar?){
        
        navigationBar?.isTranslucent = true
        
        navigationBar?.tintColor = WRConfigStyle.NavigationBar.tintColor
        
        navigationBar?.titleTextAttributes = WRConfigStyle.NavigationBar.titleAttributes
        
        
        navigationBar?.barTintColor = nil
        
        navigationBar?.backgroundColor = nil
        
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
        
        (navigationBar as? WRNavigationBar)?.backgroundView.alpha = 1.0
        (navigationBar as? WRNavigationBar)?.backgroundImageView.alpha = 1.0
        (navigationBar as? WRNavigationBar)?.backgroundImageView.image = WRConfigStyle.NavigationBar.barTintImage
        
        
        navigationBar?.shadowImage = WRImage.color(CGSize(width: UIScreen.main.bounds.width, height: 1), WRConfigStyle.NavigationBar.shadowColor)
        
        
        navigationBar?.backIndicatorImage = WRConfigStyle.NavigationBar.backImage
        
        navigationBar?.backIndicatorTransitionMaskImage = WRConfigStyle.NavigationBar.backImage
        
        UIBarButtonItem.appearance().setTitleTextAttributes(WRConfigStyle.NavigationBar.backTitleAttributes, for: .normal)
        
    }
    
    public static func setTransparent(_ navigationBar: UINavigationBar?){
        
        navigationBar?.isTranslucent = true
        navigationBar?.barTintColor = nil
        navigationBar?.backgroundColor = nil
        navigationBar?.shadowImage = UIImage()
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
        
        (navigationBar as? WRNavigationBar)?.backgroundView.alpha = 1.0
        (navigationBar as? WRNavigationBar)?.backgroundImageView.alpha = 1.0
        (navigationBar as? WRNavigationBar)?.backgroundImageView.image = nil
    }
    
    
}


fileprivate typealias ConfigStyle_ToolBar = WRConfigStyle
fileprivate extension ConfigStyle_ToolBar{
    
    func initToolBar(){
        
        let appearance = UIToolbar.appearance()
        
        appearance.isTranslucent = false
        
        appearance.tintColor = WRConfigStyle.NavigationBar.tintColor
        appearance.barTintColor = WRConfigStyle.NavigationBar.barTintColor

        appearance.setShadowImage(WRImage.color(CGSize(width: UIScreen.main.bounds.width, height: 44),
                                                WRConfigStyle.NavigationBar.shadowColor), forToolbarPosition: UIBarPosition.bottom)
        
        //隐藏 UINavigationBar 背景颜色
        //appearance.isTranslucent = true
        //appearance.barTintColor = nil
        //appearance.setShadowImage(J0Image.color(CGSize(width: UIScreen.main.bounds.width, height: 44), .clear), forToolbarPosition: UIBarPosition.bottom)
        //appearance.setBackgroundImage(J0Image.color(CGSize(width: UIScreen.main.bounds.width, height: 64), .clear), forToolbarPosition: .any, barMetrics: UIBarMetrics.default)
    }

}
