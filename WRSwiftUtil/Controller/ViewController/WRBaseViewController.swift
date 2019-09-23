//
//  WRBaseViewController.swift
//  WRSwiftUtilDemo
//
//  Created by xianghui on 2019/9/23.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit

public class WRBaseViewController: UIViewController, WRNavigationBarProtocol {

    deinit{
        debugPrint("deinit:\(self.classForCoder)")
    }

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        //默认去除返回按钮标题
        self.setNaviBackTitle("")
    }
        
    public override var prefersStatusBarHidden : Bool {
        return WRConfigStyle.StatusBar.isHidden
    }
        
    public override var preferredStatusBarStyle : UIStatusBarStyle {
        return WRConfigStyle.StatusBar.barStyle
    }
        
    public override var preferredStatusBarUpdateAnimation : UIStatusBarAnimation {
        return WRConfigStyle.StatusBar.updateAnimation
    }
        
    public  func topViewController() -> UIViewController?{
        
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController{
            return self.topViewControllerWithRootViewController(rootViewController: rootViewController)
        }
        return nil
    }
        
    public  func topViewControllerWithRootViewController(rootViewController : UIViewController) -> UIViewController{
        
        if let tabBarController = rootViewController as? UITabBarController, let selectedViewController = tabBarController.selectedViewController{
            return self.topViewControllerWithRootViewController(rootViewController: selectedViewController)
        }
        else if let navigationController = rootViewController as? UINavigationController, let visibleViewController = navigationController.visibleViewController{
            return self.topViewControllerWithRootViewController(rootViewController: visibleViewController)
            
        }
        else if let presentedViewController = rootViewController.presentedViewController{
            return self.topViewControllerWithRootViewController(rootViewController: presentedViewController)
        }
        else{
            return rootViewController
        }
    }
}


extension String {
    func stringHeightWithBold(_ fontSize: CGFloat, width: CGFloat) -> CGFloat {
        
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        
        let size = CGSize(width: width,height: CGFloat.greatestFiniteMagnitude)
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineBreakMode = .byWordWrapping;
        
        let attributes = [NSAttributedString.Key.font:font, NSAttributedString.Key.paragraphStyle:paragraphStyle.copy()]
        
        let text = self as NSString
        
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context:nil)
        
        return rect.size.height
    }
    func stringHeightWith(_ fontSize: CGFloat, width: CGFloat) -> CGFloat {
        
        let font = UIFont.systemFont(ofSize: fontSize)
        
        let size = CGSize(width: width,height: CGFloat(MAXFLOAT))
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineBreakMode = .byWordWrapping;
        
        let attributes = [NSAttributedString.Key.font:font, NSAttributedString.Key.paragraphStyle:paragraphStyle.copy()]
        
        let text = self as NSString
        
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context:nil)
        
        return rect.size.height
    }
    
    func stringHeightWith(_ fontSize: CGFloat, width: CGFloat, lineSpace:CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        
        let size = CGSize(width: width,height: CGFloat(MAXFLOAT))
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        if lineSpace > 0 {
            paragraphStyle.lineSpacing = lineSpace
        }
        
        let attributes = [NSAttributedString.Key.font:font, NSAttributedString.Key.paragraphStyle:paragraphStyle.copy()]
        
        let text = self as NSString
        
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context:nil)
        
        return rect.size.height
    }
    
    func stringWidthWith(_ fontSize:CGFloat) -> CGFloat {
        let text = self as NSString
        let size: CGSize = text.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)])
        return size.width
    }


}
