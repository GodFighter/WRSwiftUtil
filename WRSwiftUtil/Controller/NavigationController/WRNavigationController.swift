//
//  WRNavigationController.swift
//  WRSwiftUtilDemo
//
//  Created by xianghui on 2019/9/6.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit

@_exported import Colours

// MARK:-
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
        
        public static var tintColor : UIColor = .white                               //按钮颜色
        
        public static var shadowColor : UIColor = .clear                             //阴影颜色
        
        public static var barTintColor : UIColor? = nil                              //背景颜色
        
        public static var barTintImage : UIImage? = {                                //背景图片
            let colors : [UIColor] = [UIColor(fromHexString: "#009CFF"), UIColor(fromHexString: "#1671EF")]
            return WRImage.color(size:CGSize(width: UIScreen.main.bounds.width, height: 64), colors: colors,
                                 start: CGPoint(x:0.5, y: 0.0), end: CGPoint(x:1.0, y: 1.0))
            
        }()
        
        public static func customBarTintImage(_ beginColor : UIColor, endColor : UIColor) -> () {
            let colors : [UIColor] = [beginColor, endColor]
            WRConfigStyle.NavigationBar.barTintImage = WRImage.color(size:CGSize(width: UIScreen.main.bounds.width, height: 64), colors: colors,
                                                                     start: CGPoint(x:0.5, y: 0.0), end: CGPoint(x:1.0, y: 1.0))
        }
        public static func customBarTintImage(_ image : UIImage?) -> () {
            if image != nil {
                WRConfigStyle.NavigationBar.barTintImage = image
            }
        }

        public static var mnBarTintImage : UIImage? = {                                //背景图片
            let colors : [UIColor] = [UIColor(fromHexString: "#009CFF"), UIColor(fromHexString: "#1671EF")]
            return WRImage.color(size:CGSize(width: 44, height: UIScreen.main.bounds.height), colors: colors,
                                 start: CGPoint(x:0.5, y: 0.0), end: CGPoint(x:1.0, y: 1.0))
            
        }()
        
        public static var titleAttributes : [NSAttributedString.Key : Any] = {        //标题属性
            return [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular),
                    NSAttributedString.Key.foregroundColor : WRConfigStyle.NavigationBar.tintColor]
        }()
        
        public static var backImage : UIImage? = UIImage(named: "navigationBar_Back")    //返回图标
        
        public static var backColor : UIColor = .white                               //返回颜色
        
        public static var backTitleAttributes : [NSAttributedString.Key : Any] = {    //返回字体
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
        
    }
    
}

// MARK:-
@objc public protocol WRNavigationControllerProtocol: class {
    @objc optional func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool
}

public class WRNavigationBar : UINavigationBar{
    
    public var backgroundView : UIView = UIView()
    
    public var backgroundImageView : UIImageView = UIImageView()
    
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = nil
        
        self.backgroundView.frame = CGRect(x: 0,
                                           y: -UIApplication.shared.statusBarFrame.height,
                                           width: self.frame.width,
                                           height: self.frame.height + UIApplication.shared.statusBarFrame.height)
        
        self.backgroundView.isUserInteractionEnabled = false
        
        self.backgroundView.backgroundColor = nil
        self.backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.backgroundImageView.backgroundColor = nil
        self.backgroundImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.backgroundImageView.frame = CGRect(origin: .zero, size: self.backgroundView.frame.size)
        self.backgroundView.addSubview(self.backgroundImageView)
        
        self.addSubview(self.backgroundView)
        
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.sendSubviewToBack(self.backgroundView)
    }
    
}

public class WRNavigationController: UINavigationController {

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public override init(rootViewController: UIViewController) {
        super.init(navigationBarClass: WRNavigationBar.classForCoder(), toolbarClass: nil)
        self.viewControllers = [rootViewController]
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        WRConfigStyle.reset(self.navigationBar)
    }
    
    public override var prefersStatusBarHidden : Bool {
        return self.topViewController?.prefersStatusBarHidden ?? WRConfigStyle.StatusBar.isHidden
    }
    
    public override var preferredStatusBarStyle : UIStatusBarStyle {
        return self.topViewController?.preferredStatusBarStyle ?? WRConfigStyle.StatusBar.barStyle
    }
    
    public override var preferredStatusBarUpdateAnimation : UIStatusBarAnimation {
        return self.topViewController?.preferredStatusBarUpdateAnimation ?? WRConfigStyle.StatusBar.updateAnimation
    }
    
    open override var shouldAutorotate : Bool {
        return self.topViewController?.shouldAutorotate ?? super.shouldAutorotate
    }
    
    open override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return self.topViewController?.supportedInterfaceOrientations ?? super.supportedInterfaceOrientations
    }
    
    override open func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }

}
