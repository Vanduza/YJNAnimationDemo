//
//  DripControlViewController.swift
//  YJNAnimationDemo
//
//  Created by YangJing on 2017/12/5.
//  Copyright © 2017年 YangJing. All rights reserved.
//

import UIKit

class DripControlViewController: UIViewController {
    var dripLayer:YJNDripLayer!
    var slider:UISlider!
    let screen_width = UIScreen.main.bounds.size.width
    let screen_height = UIScreen.main.bounds.size.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "DripControl"
        let view = UIView.init(frame: CGRect(x: (screen_width-150)/2, y: 200, width: 150, height: 150))
        dripLayer = YJNDripLayer.init()
        dripLayer.frame = view.bounds
        dripLayer.progress = 0.5
        view.layer.addSublayer(dripLayer)
        self.view.addSubview(view)
        
        slider = UISlider.init(frame: CGRect(x: 20, y: screen_height - 150, width: screen_width - 40, height: 10))
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.tintColor = UIColor.lightGray
        slider.backgroundColor = UIColor.white
        slider.addTarget(self, action: #selector(sliderSlide), for: UIControlEvents.valueChanged)
        slider.setValue(0.5, animated: false)
        self.view.addSubview(slider)
    }
    
    @objc func sliderSlide() -> Void {
        dripLayer.progress = CGFloat(slider.value)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
