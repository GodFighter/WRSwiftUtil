//
//  WRProgressHUDProtocol.swift
//  WRSwiftUtilDemo
//
//  Created by xianghui on 2019/9/20.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit
import MBProgressHUD

public protocol WRProgressHUDProtocol{
    
}

public extension WRProgressHUDProtocol where Self : UIViewController{
    
    func showProgressHUD(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func hideProgressHUD(){
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}
