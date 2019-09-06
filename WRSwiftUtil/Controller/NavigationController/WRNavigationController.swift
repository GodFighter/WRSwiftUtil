//
//  WRNavigationController.swift
//  WRSwiftUtilDemo
//
//  Created by xianghui on 2019/9/6.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit


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
