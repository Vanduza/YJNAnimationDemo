//
//  MatrixMenuDemoController.swift
//  YJNAnimationDemo
//
//  Created by YangJing on 2017/11/14.
//  Copyright © 2017年 YangJing. All rights reserved.
//

import UIKit

class MatrixMenuDemoController: UIViewController {
    var bo:Bool = true
    var menu:YJNMatrixMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "MatrixMenu"
        menu = YJNMatrixMenu(frame: self.view.bounds)
        menu.menuTouched = {(index:Int) -> Void in
            print("第\(index)个按钮被点击")
            self.bo = true
        }
        self.view.addSubview(menu)
        let tips = UILabel.init(frame: CGRect(x: (UIScreen.main.bounds.width - 200)/2, y: UIScreen.main.bounds.height - 100, width: 200, height: 40))
        tips.text = "点击空白呼出Menu"
        tips.textAlignment = NSTextAlignment.center
        self.view.addSubview(tips)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(bo){
            bo = false
            menu.show()
        }
    }
}
