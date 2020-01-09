//
//  ViewController.swift
//  WRSwiftUtilDemo
//
//  Created by xianghui on 2019/9/5.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit

class ViewController: WRBaseViewController {
    
    var button = UIButton.init(type: .custom)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        button.setTitle("12345", for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        self.view.addSubview(button)
        button.backgroundColor = .red
        button.frame = CGRect(x: 0, y: 100, width: 50, height: 100)
        
//        button.wr.touchUpInside { (sender) in
//           print("touch up inside")
//        }
        button.wr.touchDown { (sender) in
            print("touch down")
        }

        
    }
    


}

