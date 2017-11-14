//
//  YJNMatrixMenuComponent.swift
//  FunctionTestSwift
//
//  Created by YangJing on 2017/11/14.
//  Copyright © 2017年 YangJing. All rights reserved.
//

import UIKit

class YJNMatrixMenuComponent: UIView {
    
    private var imageView:UIImageView!
    var image:UIImage?{
        set{
            imageView.image = newValue
        }
        get{
            return imageView.image
        }
    }
    var control:UIControl!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: self.bounds)
        self.addSubview(imageView)
        
        control = UIControl(frame: self.bounds)
        self.addSubview(control)
    }
    
    func addTarget(target:AnyObject?,action:Selector,forControlEvents:UIControlEvents) -> Void {
        control.addTarget(target, action: action, for: forControlEvents)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
