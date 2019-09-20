//
//  WRIndicatorViewProtocol.swift
//  WRSwiftUtilDemo
//
//  Created by xianghui on 2019/9/20.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

public protocol WRIndicatorViewProtocol {

}

//MARK:- UIView
extension WRIndicatorViewProtocol where Self : UIView{
    
    var toastView : UIView? {
        return self.viewWithTag(WRIndicatorView.Const.toast)
    }
    
    func hideIndicator(){
        WRIndicatorView.hideIndicator(superView: self)
    }
    
    func showIndicator(style : WRIndicatorView.Style? = nil){
        WRIndicatorView.showIndicator(superView: self, style: style ?? WRIndicatorView.defaultStyle)
    }
}

//MARK:- UIViewController
public extension WRIndicatorViewProtocol where Self : UIViewController{
    
    var toastView : UIView? {
        return self.view.viewWithTag(WRIndicatorView.Const.toast)
    }
    
    func hideIndicator(){
        WRIndicatorView.hideIndicator(superView: self.view)
    }
    
    func showIndicator(style : WRIndicatorView.Style? = nil){
        WRIndicatorView.showIndicator(superView: self.view, style: style ?? WRIndicatorView.defaultStyle)
    }
}

public struct WRIndicatorView{
    
    public struct Style{
        
        public let type : NVActivityIndicatorType
        
        public let size          : CGSize
        public let padding       : CGFloat
        public let maskColor     : UIColor
        public let toastColor    : UIColor
        public let activityColor : UIColor
    }
    
    fileprivate struct Const{
        
        fileprivate init(){}
        
        fileprivate static let toast    = 20000
        fileprivate static let activity = 20001
    }
    
    private init() {}
    
    public static var defaultStyle = WRIndicatorView.Style(type: .ballSpinFadeLoader,              //类型
        size: CGSize(width:32.0, height: 32.0), //ToastView Size
        padding: 0.0,                           //loading Size white Toast UIEdge
        maskColor:     UIColor.clear,
        toastColor:    UIColor.clear,
        activityColor: UIColor(fromHexString: "#5ED18F"))
    
    public static func showIndicator(superView : UIView, style : WRIndicatorView.Style){
        
        if let _ = superView.viewWithTag(WRIndicatorView.Const.toast){
            return
        }
        
        let toastView = UIView(frame: superView.bounds)
        toastView.tag = WRIndicatorView.Const.toast
        toastView.backgroundColor = style.maskColor
        toastView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: style.size.width, height: style.size.height),
                                                            type: style.type, color: style.activityColor, padding: style.padding)
        
        activityIndicatorView.tag = WRIndicatorView.Const.activity
        activityIndicatorView.backgroundColor = style.toastColor
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        superView.addSubview(toastView)
        toastView.addSubview(activityIndicatorView)
        
        toastView.addConstraints([
            NSLayoutConstraint(item: activityIndicatorView, attribute: .centerX, relatedBy: .equal, toItem: toastView, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: activityIndicatorView, attribute: .centerY, relatedBy: .equal, toItem: toastView, attribute: .centerY, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: activityIndicatorView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: style.size.width),
            NSLayoutConstraint(item: activityIndicatorView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: style.size.height)])
        
        activityIndicatorView.startAnimating()
    }
    
    public static func hideIndicator(superView : UIView){
        
        if let toastView = superView.viewWithTag(WRIndicatorView.Const.toast) {
            toastView.removeFromSuperview()
        }
        
        if let activityIndicatorView = superView.viewWithTag(WRIndicatorView.Const.activity) as? NVActivityIndicatorView{
            
            activityIndicatorView.stopAnimating()
            activityIndicatorView.removeFromSuperview()
        }
    }
}
