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

        print("\("13948202341".wr.isPhone)")
        self.view.backgroundColor = .white
        
        let subview = UIView()
        subview.backgroundColor = .red
        subview.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        self.view.addSubview(subview)

        let image = UIImage(named: "audio_list_pause")?.wr.imageTintColor(UIColor.green)
        let imageView = UIImageView(image: image)
        self.view.addSubview(imageView)
        imageView.frame = CGRect(x: 200, y: 200, width: image?.size.width ?? 0, height: image?.size.height ?? 0)
    }
    


}

