//
//  YJNMatrixMenu.swift
//  FunctionTestSwift
//
//  Created by YangJing on 2017/11/14.
//  Copyright © 2017年 YangJing. All rights reserved.
//

import UIKit
import QuartzCore

class YJNMatrixMenu: UIView {
        private var menus:[YJNMatrixMenuComponent] = []
        private var menuLines:[CAShapeLayer] = []
        private var showMenuLineAnimation:CABasicAnimation!
        
        private var horizontalLines:[CAShapeLayer] = []
        private var verticalLines:[CAShapeLayer] = []
        
        private var hideHorizontalLineAnimation:CABasicAnimation!
        private var showHorizontalLineAnimation:CABasicAnimation!
        
        private var rectLine:CAShapeLayer!
        
        var menuTouched:((_ index:Int)-> Void)?
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            let bgImageView:UIImageView = UIImageView(image: UIImage(named: "bg"))
            bgImageView.frame = self.bounds
            self.addSubview(bgImageView)
            
            let rowSize:CGFloat = frame.size.width / 3
            for i in 0 ..< 6{
                let menu:YJNMatrixMenuComponent = YJNMatrixMenuComponent(frame: CGRect(x: 0, y: 0, width: rowSize, height: rowSize))
                menu.image = UIImage(named: ("\(i + 1)"))
                menu.addTarget(target: self, action: #selector(onMenuTouch(control:)), forControlEvents: .touchUpInside)
                menus.append(menu)
            }
            showMenuLineAnimation = CABasicAnimation(keyPath: "strokeEnd")
            showMenuLineAnimation.duration = 1
            showMenuLineAnimation.fromValue = 0
            showMenuLineAnimation.toValue = 1
            showMenuLineAnimation.isRemovedOnCompletion = true
            showMenuLineAnimation.fillMode = kCAFillModeForwards
            
            hideHorizontalLineAnimation = CABasicAnimation(keyPath: "strokeStart")
            hideHorizontalLineAnimation.duration = 0.5
            hideHorizontalLineAnimation.fromValue = 0
            hideHorizontalLineAnimation.toValue = 1
            hideHorizontalLineAnimation.isRemovedOnCompletion = false
            hideHorizontalLineAnimation.fillMode = kCAFillModeForwards
            
            showHorizontalLineAnimation = CABasicAnimation(keyPath: "strokeEnd")
            showHorizontalLineAnimation.duration = 0.5
            showHorizontalLineAnimation.fromValue = 0
            showHorizontalLineAnimation.toValue = 1
            showHorizontalLineAnimation.isRemovedOnCompletion = false
            showHorizontalLineAnimation.fillMode = kCAFillModeForwards
            //排列按钮
            for i in 0 ..< menus.count{
                self.addSubview(menus[i])
                let cel:CGFloat = floor(CGFloat(i) / 2)
                let y:CGFloat = cel * (rowSize + 2) + frame.size.height / 2 - rowSize * 1.5 - 3
                let temp: CGFloat = CGFloat(i).truncatingRemainder(dividingBy: 2)
                
                menus[i].frame = CGRect(x: rowSize / 2 - 1 + temp * (rowSize + 2), y: y, width: rowSize, height: rowSize)
                menus[i].layer.zPosition = 400
                self.menus[i].layer.transform = CATransform3DMakeRotation(CGFloat(CGFloat.pi / 2), 1, 1, 0)
            }
            
            rectLine = CAShapeLayer()
            rectLine.strokeColor = UIColor.red.cgColor
            rectLine.fillColor = UIColor.clear.cgColor
            rectLine.strokeEnd = 0
            let rectPath:UIBezierPath = UIBezierPath()
            
            rectPath.move(to: CGPoint(x: menus[0].frame.origin.x - 1 , y: menus[0].frame.origin.y - 1))
            rectPath.addLine(to: CGPoint(x: menus[1].frame.origin.x + menus[1].frame.size.width + 1, y: menus[1].frame.origin.y - 1))
            rectPath.addLine(to: CGPoint(x: menus[5].frame.origin.x + menus[5].frame.size.width + 1, y: menus[5].frame.origin.y + menus[5].frame.size.height + 1))
            rectPath.addLine(to: CGPoint(x: menus[4].frame.origin.x - 1, y: menus[4].frame.origin.y + menus[5].frame.size.height + 1))
            rectPath.addLine(to: CGPoint(x: menus[0].frame.origin.x - 1, y: menus[0].frame.origin.y - 1))
            rectPath.addLine(to: CGPoint(x: menus[1].frame.origin.x + menus[1].frame.size.width + 1, y: menus[1].frame.origin.y - 1))
            rectPath.addLine(to: CGPoint(x: menus[5].frame.origin.x + menus[5].frame.size.width + 1, y: menus[5].frame.origin.y + menus[5].frame.size.height + 1))
            rectPath.addLine(to: CGPoint(x: menus[4].frame.origin.x - 1, y: menus[4].frame.origin.y + menus[5].frame.size.height + 1))
            rectPath.addLine(to: CGPoint(x: menus[0].frame.origin.x - 1, y: menus[0].frame.origin.y - 1))
            
            rectLine.path = rectPath.cgPath
            self.layer.addSublayer(rectLine)
            
            //竖向三根线
            for i in 0 ..< 3{
                let verticalLineLayer:CAShapeLayer = CAShapeLayer()
                verticalLineLayer.strokeColor = UIColor.red.cgColor
                verticalLineLayer.fillColor = UIColor.white.cgColor
                let verticalLinePath:UIBezierPath = UIBezierPath()
                verticalLinePath.move(to: CGPoint(x:menus[0].frame.origin.x - 1 + CGFloat(i) * (rowSize + 2), y:0))
                verticalLinePath.addLine(to: CGPoint(x:menus[0].frame.origin.x - 1 + CGFloat(i) * (rowSize + 2), y:self.frame.size.height))
                verticalLinePath.lineWidth = 1.5
                verticalLineLayer.path = verticalLinePath.cgPath
                verticalLineLayer.strokeEnd = 0
                self.layer.addSublayer(verticalLineLayer)
                horizontalLines.append(verticalLineLayer)
            }
            //横向四根线
            for i in 0 ..< 4{
                let horizontalLineLayer:CAShapeLayer = CAShapeLayer()
                horizontalLineLayer.strokeColor = UIColor.red.cgColor
                horizontalLineLayer.fillColor = UIColor.white.cgColor
                let horizontalLinePath:UIBezierPath = UIBezierPath()
                horizontalLinePath.move(to: CGPoint(x: 0,y: menus[0].frame.origin.y - 1 + CGFloat(i) * (rowSize + 2)))
                horizontalLinePath.addLine(to: CGPoint(x: self.frame.size.width, y: menus[0].frame.origin.y - 1 + CGFloat(i) * (rowSize + 2)))
                horizontalLinePath.lineWidth = 1.5
                horizontalLineLayer.path = horizontalLinePath.cgPath
                horizontalLineLayer.strokeEnd = 0
                self.layer.addSublayer(horizontalLineLayer)
                horizontalLines.append(horizontalLineLayer)
            }
            //斜向四根线
            for i in 0 ..< 4{
                let menuLineLayer:CAShapeLayer = CAShapeLayer()
                menuLineLayer.strokeColor = UIColor.red.cgColor
                menuLineLayer.fillColor = UIColor.white.cgColor
                let menuLinePath:UIBezierPath = UIBezierPath()
                if(i==0){
                    menuLinePath.move(to: menus[1].frame.origin)
                    menuLinePath.addLine(to: CGPoint(x: menus[1].frame.origin.x + menus[1].frame.size.width, y: menus[1].frame.origin.y + menus[1].frame.size.height))
                }
                else if(i==1){
                    menuLinePath.move(to: menus[0].frame.origin)
                    menuLinePath.addLine(to: CGPoint(x: menus[3].frame.origin.x + menus[3].frame.size.width, y: menus[3].frame.origin.y + menus[3].frame.size.height))
                }
                else if(i==2){
                    menuLinePath.move(to: menus[2].frame.origin)
                    menuLinePath.addLine(to: CGPoint(x: menus[5].frame.origin.x + menus[5].frame.size.width, y: menus[5].frame.origin.y + menus[5].frame.size.height))
                }
                else if(i==3){
                    menuLinePath.move(to:menus[4].frame.origin)
                    menuLinePath.addLine(to: CGPoint(x: menus[4].frame.origin.x + menus[4].frame.size.width, y: menus[4].frame.origin.y + menus[4].frame.size.height))
                }
                menuLinePath.lineWidth = 1.5
                
                menuLineLayer.path = menuLinePath.cgPath
                menuLineLayer.strokeEnd = 0
                self.layer.addSublayer(menuLineLayer)
                menuLines.append(menuLineLayer)
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        @objc func showHorizontalLine(line:CAShapeLayer){
            line.add(showHorizontalLineAnimation, forKey: nil)
            let showColorAnimation:CABasicAnimation = CABasicAnimation(keyPath: "strokeColor")
            showColorAnimation.duration = 1.5
            showColorAnimation.fromValue = UIColor(red: CGFloat(arc4random_uniform(255))/255, green: CGFloat(arc4random_uniform(255))/255, blue: CGFloat(arc4random_uniform(255))/255, alpha: 1).cgColor
            showColorAnimation.toValue = UIColor(red: CGFloat(arc4random_uniform(255))/255, green: CGFloat(arc4random_uniform(255))/255, blue: CGFloat(arc4random_uniform(255))/255, alpha: 1).cgColor
            line.add(showColorAnimation, forKey: nil)
            line.add(showColorAnimation, forKey: nil)
            
            self.perform(#selector(hideHorizontalLine(line:)), with: line, afterDelay: 1)
        }
        
        @objc func hideHorizontalLine(line:CAShapeLayer){
            line.add(hideHorizontalLineAnimation, forKey: nil)
        }
        
        @objc func onMenuTouch(control:UIControl){
            for i in 0 ..< menus.count{
                if(menus[i].control == control){
                    hide(index: i)
                }
            }
        }
        
        private func hide(index:Int){
            let rowSize:CGFloat = frame.size.width / 3
            
            if index == 0{
                UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseIn, animations: {
                    self.menus[0].frame = CGRect(x: self.menus[0].frame.origin.x , y: self.menus[0].frame.origin.y - rowSize,width: rowSize, height: rowSize)
                }, completion: { (bo) in
                    UIView.animate(withDuration: 0.85, delay: 0, options: .curveEaseIn, animations: {
                        self.menus[0].frame = CGRect(x: self.menus[0].frame.origin.x , y: self.frame.size.height, width: rowSize, height: rowSize)
                    }, completion: { (bo) in
                        if self.menuTouched != nil{
                            self.menuTouched!(index)
                        }
                    })
                })
            }else{
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                    self.menus[0].frame = CGRect(x: self.menus[0].frame.origin.x , y: -rowSize, width: rowSize, height: rowSize)
                }, completion: nil)
            }
            
            if index == 5{
                UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseInOut, animations: {
                    self.menus[5].frame = CGRect(x: self.menus[5].frame.origin.x , y: self.menus[5].frame.origin.y + rowSize, width: rowSize, height: rowSize)
                }, completion: { (bo) in
                    UIView.animate(withDuration: 0.85, delay: 0, options: .curveEaseIn, animations: {
                        self.menus[5].frame = CGRect(x: self.menus[5].frame.origin.x , y: -rowSize, width: rowSize, height: rowSize)
                    }, completion: { (bo) in
                        if self.menuTouched != nil{
                            self.menuTouched!(index)
                        }
                    })
                })
            }else{
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                    self.menus[5].frame = CGRect(x: self.menus[5].frame.origin.x , y: self.frame.size.height, width: rowSize, height: rowSize)
                }, completion: nil)
            }
            
            if index == 1{
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                    self.menus[1].frame = CGRect(x: self.menus[1].frame.origin.x - rowSize , y: self.menus[1].frame.origin.y, width: rowSize, height: rowSize)
                }, completion: { (bo) in
                    UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseInOut, animations: {
                        self.menus[1].frame = CGRect(x: self.frame.size.width , y: self.menus[1].frame.origin.y , width: rowSize, height: rowSize)
                    }, completion: { (bo) in
                        if self.menuTouched != nil{
                            self.menuTouched!(index)
                        }
                    })
                })
            }else{
                UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut, animations: {
                    self.menus[1].frame = CGRect(x: self.frame.size.width , y: self.menus[1].frame.origin.y , width: rowSize, height: rowSize)
                }, completion: nil)
            }
            
            if index == 4{
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                    self.menus[4].frame = CGRect(x: self.menus[4].frame.origin.x + rowSize , y: self.menus[4].frame.origin.y, width: rowSize, height: rowSize)
                }, completion: { (bo) in
                    UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseInOut, animations: {
                        self.menus[4].frame = CGRect(x: -rowSize , y: self.menus[4].frame.origin.y , width: rowSize, height: rowSize)
                    }, completion: { (bo) in
                        if self.menuTouched != nil{
                            self.menuTouched!(index)
                        }
                    })
                })
            }
            else
            {
                UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut, animations: {
                    self.menus[4].frame = CGRect(x: -rowSize , y: self.menus[4].frame.origin.y , width: rowSize, height: rowSize)
                }, completion: nil)
            }
            
            if index == 2{
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                    self.menus[2].frame = CGRect(x: self.menus[2].frame.origin.x  , y: self.menus[2].frame.origin.y - rowSize, width: rowSize, height: rowSize)
                }, completion: { (bo) in
                    UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseInOut, animations: {
                        self.menus[2].frame = CGRect(x: self.menus[2].frame.origin.x , y: self.frame.size.height , width: rowSize, height: rowSize)
                    }, completion: { (bo) in
                        if self.menuTouched != nil{
                            self.menuTouched!(index)
                        }
                    })
                })
            }
            else
            {
                UIView.animate(withDuration: 0.7, delay: 0.1, options: .curveEaseInOut, animations: {
                    self.menus[2].frame = CGRect(x: -rowSize , y: self.menus[2].frame.origin.y , width: rowSize, height: rowSize)
                }, completion: nil)
            }
            
            if index == 3{
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                    self.menus[3].frame = CGRect(x: self.menus[3].frame.origin.x  , y: self.menus[3].frame.origin.y + rowSize, width: rowSize, height: rowSize)
                }, completion: { (bo) in
                    UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseInOut, animations: {
                        self.menus[3].frame = CGRect(x: self.menus[3].frame.origin.x ,y: -rowSize , width: rowSize, height: rowSize)
                    }, completion: { (bo) in
                        if self.menuTouched != nil{
                            self.menuTouched!(index)
                        }
                    })
                })
            }
            else{
                UIView.animate(withDuration: 0.7, delay: 0.1, options: .curveEaseInOut, animations: {
                    self.menus[3].frame = CGRect(x: self.frame.size.width , y: self.menus[3].frame.origin.y , width: rowSize, height: rowSize)
                }, completion: nil)
            }
            
            let rectLineAnimation1:CABasicAnimation = CABasicAnimation(keyPath: "strokeStart")
            rectLineAnimation1.fromValue = 0.8
            rectLineAnimation1.toValue = 0
            rectLineAnimation1.duration = 1
            rectLineAnimation1.isRemovedOnCompletion = false
            rectLine.add(rectLineAnimation1, forKey: nil)
            
            let rectLineAnimation2:CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
            rectLineAnimation2.fromValue = 1
            rectLineAnimation2.toValue = 0.2
            rectLineAnimation2.duration = 1
            rectLineAnimation2.isRemovedOnCompletion = false
            rectLine.add(rectLineAnimation2, forKey: nil)
            
            let rectColorAnimation:CABasicAnimation = CABasicAnimation(keyPath: "strokeColor")
            rectColorAnimation.duration = 1
            rectColorAnimation.fromValue = UIColor(red: CGFloat(arc4random_uniform(255))/255, green: CGFloat(arc4random_uniform(255))/255, blue: CGFloat(arc4random_uniform(255))/255, alpha: 1).cgColor
            rectColorAnimation.toValue = UIColor(red: CGFloat(arc4random_uniform(255))/255, green: CGFloat(arc4random_uniform(255))/255, blue: CGFloat(arc4random_uniform(255))/255, alpha: 1).cgColor
            rectColorAnimation.isRemovedOnCompletion = false
            rectLine.add(rectColorAnimation, forKey: nil)
            rectLine.strokeEnd = 0
            
        }
        
        func show(){
            let rowSize:CGFloat = frame.size.width / 3
            
            for i in 0 ..< horizontalLines.count{
                self.perform(#selector(showHorizontalLine(line:)), with: horizontalLines[i], afterDelay: 0.15 * CFTimeInterval(i))
            }
            
            let rectLineAnimation1:CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
            rectLineAnimation1.fromValue = 0.2
            rectLineAnimation1.toValue = 1
            rectLineAnimation1.duration = 2
            rectLineAnimation1.isRemovedOnCompletion = false
            rectLine.add(rectLineAnimation1, forKey: nil)
            
            let rectLineAnimation2:CABasicAnimation = CABasicAnimation(keyPath: "strokeStart")
            rectLineAnimation2.fromValue = 0
            rectLineAnimation2.toValue = 0.8
            rectLineAnimation2.duration = 2
            rectLineAnimation2.isRemovedOnCompletion = false
            rectLine.add(rectLineAnimation2, forKey: nil)
            
            
            
            let rectColorAnimation:CABasicAnimation = CABasicAnimation(keyPath: "strokeColor")
            rectColorAnimation.duration = 2
            rectColorAnimation.fromValue = UIColor(red: CGFloat(arc4random_uniform(255))/255, green: CGFloat(arc4random_uniform(255))/255, blue: CGFloat(arc4random_uniform(255))/255, alpha: 1).cgColor
            rectColorAnimation.toValue = UIColor(red: CGFloat(arc4random_uniform(255))/255, green: CGFloat(arc4random_uniform(255))/255, blue: CGFloat(arc4random_uniform(255))/255, alpha: 1).cgColor
            rectColorAnimation.isRemovedOnCompletion = false
            rectLine.add(rectColorAnimation, forKey: nil)
            rectLine.strokeEnd = 1
            for i in 0 ..< menuLines.count{
                
                let showColorAnimation:CABasicAnimation = CABasicAnimation(keyPath: "strokeColor")
                showColorAnimation.duration = 1
                showColorAnimation.fromValue = UIColor(red: CGFloat(arc4random_uniform(255))/255, green: CGFloat(arc4random_uniform(255))/255, blue: CGFloat(arc4random_uniform(255))/255, alpha: 1).cgColor
                showColorAnimation.toValue = UIColor(red: CGFloat(arc4random_uniform(255))/255, green: CGFloat(arc4random_uniform(255))/255, blue: CGFloat(arc4random_uniform(255))/255, alpha: 1).cgColor
                
                menuLines[i].add(showMenuLineAnimation, forKey: nil)
                menuLines[i].add(showColorAnimation, forKey: nil)
                
            }
            
            for i in 0 ..< menus.count{
                let cel:CGFloat = floor(CGFloat(i) / 2)
                let y:CGFloat = cel * (rowSize + 2) + frame.size.height / 2 - rowSize * 1.5 - 3
                let temp:CGFloat = CGFloat(i).truncatingRemainder(dividingBy: 2)
                
                menus[i].frame = CGRect(x: rowSize / 2 - 1 + temp * (rowSize + 2), y: y, width: rowSize, height: rowSize)
                self.menus[i].layer.transform = CATransform3DMakeRotation(CGFloat(CGFloat.pi / 2), 1, 1, 0)
                UIView.animate(withDuration: 0.3, delay: 0.06 * Double(i) + 1, options: .curveLinear, animations: {
                    self.menus[i].layer.transform = CATransform3DMakeRotation(0, 0, 0, 0)
                }, completion: nil)
                
            }
        }
        
}

