//
//  WRToastView.swift
//  WRSwiftUtilDemo
//
//  Created by xianghui on 2019/9/20.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit

public protocol WRToastViewProtocol{
    
}

public extension WRToastViewProtocol where Self : UIViewController{
    func showToastMessage(_ message:String, duration: TimeInterval = 2.0){
        self.view.makeToast(message, duration: duration, position: ToastPosition.center)
    }
    
    func showToastMessageOnWindow(_ message:String, duration: TimeInterval = 2.0){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.makeToast(message, duration: duration, position: ToastPosition.center)
    }
}
