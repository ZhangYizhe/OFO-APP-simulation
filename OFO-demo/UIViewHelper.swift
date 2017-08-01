//
//  UIViewHelper.swift
//  OFO-demo
//
//  Created by 张艺哲 on 2017/7/30.
//  Copyright © 2017年 张艺哲. All rights reserved.
//


//UIView 可视化编辑


extension UIView{
   @IBInspectable var boardwidth: CGFloat {//边框宽度
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
   @IBInspectable var borderColor: UIColor {//边框颜色
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {//边框圆角
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0 //裁边
        }
    }
    
    
}



@IBDesignable class MyPreviewLabel: UILabel {//方法可视化
    
}

@IBDesignable class MyPreviewButton: UIButton {//方法可视化
    
}

//开启手电筒

import AVFoundation

func turnTorch() {
    
    guard let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo) else { return }
    
    if device.hasTorch && device.isTorchAvailable {
        try? device.lockForConfiguration()
        
        if device.torchMode == .off {
            device.torchMode = .on
        } else {
            device.torchMode = .off
        }
        
        device.unlockForConfiguration()
    }
    
}













