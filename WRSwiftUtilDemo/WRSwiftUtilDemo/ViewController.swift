//
//  ViewController.swift
//  WRSwiftUtilDemo
//
//  Created by xianghui on 2019/9/5.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit

extension UIButton : WRActivityIndicatorProtocol {
    
}

class ViewController: WRBaseViewController, WRActivityIndicatorProtocol {
    
    var button = UIButton.init(type: .custom)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white


//        self.wr.startAnimating(size, message: "Loading...", type: .springCircle, backgroundColor: .red, fadeInAnimation: nil)
                
        let size = CGSize(width: 40, height: 40)
        
        
        self.wr.indicator.removeWhileStop = false
        self.wr.indicator.startAnimating(size, message: "Loading...", type: .ballRotateChase)
//        self.WR.indicator(self).startAnimating(size, message: "Loading...", type: .springCircle, backgroundColor: .red, fadeInAnimation: nil)
//        self.WR.indicator(self).sta

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.button.setTitle("12345", for: .normal)
            self.button.setTitleColor(.black, for: .highlighted)
            self.view.addSubview(self.button)
            self.button.backgroundColor = .green
            self.button.frame = CGRect(x: 0, y: 100, width: 50, height: 100)
            
            self.button.wr.event(.touchDown) { (button, event) in
                if self.wr.indicator.isAnimating {
                    self.wr.indicator.stopAnimating()
                } else {
                    self.wr.indicator.startAnimating(size, message: "Loading...", type: .ringSpring)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                    self.view.bringSubviewToFront(self.button)
                    }
                }
            }
        }

        button.wr.event(.touchDown) { (sender, event)  in
            
            }?.wr.event(.touchUpInside) { (sender, event)  in
                print("\(event)")
            }?.wr.event(.valueChanged, handler: { (sender, event) in
                print("\(event)")
            })
        
        
    }
    


}

