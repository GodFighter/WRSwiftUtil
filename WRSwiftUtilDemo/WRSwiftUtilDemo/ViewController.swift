//
//  ViewController.swift
//  WRSwiftUtilDemo
//
//  Created by xianghui on 2019/9/5.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit

class ViewController: WRBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("\("13948202341".isPhone)")
        
        let subview = UIView()
        subview.backgroundColor = .red
        subview.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        self.view.addSubview(subview)
    }


}

