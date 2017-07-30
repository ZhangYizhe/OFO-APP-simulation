//
//  UIViewHelper.swift
//  OFO-demo
//
//  Created by 张艺哲 on 2017/7/30.
//  Copyright © 2017年 张艺哲. All rights reserved.
//

extension UIView{
   @IBInspectable var boardwidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
   @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
}
