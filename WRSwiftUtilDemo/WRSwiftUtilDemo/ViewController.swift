//
//  ViewController.swift
//  WRSwiftUtilDemo
//
//  Created by xianghui on 2019/9/5.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit

class ViewController: WRBaseViewController, WRActivityIndicatorProtocol {
    
    var button = UIButton.init(type: .custom)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        button.setTitle("12345", for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        self.view.addSubview(button)
        button.backgroundColor = .red
        button.frame = CGRect(x: 0, y: 100, width: 50, height: 100)
        
        let size = CGSize(width: 80, height: 80)

        self.wr.startAnimating(size, message: "Loading...", type: .system, fadeInAnimation: nil)
        
        button.wr.event(.touchDown) { (sender, event)  in
            print("\(event)")
            }?.wr.event(.touchUpInside) { (sender, event)  in
                print("\(event)")
            }?.wr.event(.valueChanged, handler: { (sender, event) in
                print("\(event)")
            })
        
        
    }
    


}

