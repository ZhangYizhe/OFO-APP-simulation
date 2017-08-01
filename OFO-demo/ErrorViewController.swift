//
//  ErrorViewController.swift
//  OFO-demo
//
//  Created by 张艺哲 on 2017/8/1.
//  Copyright © 2017年 张艺哲. All rights reserved.
//

import UIKit
import MIBlurPopup

class ErrorViewController: UIViewController {
    
    @IBAction func gestureTap(_ sender: UITapGestureRecognizer) {
        self.close()
    }

    @IBOutlet weak var mypopupView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeBtnTap(_ sender: Any) {
        close()
        
    }
    func close() {
        dismiss(animated : true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}

extension ErrorViewController : MIBlurPopupDelegate {
    var popupView : UIView{
        return mypopupView
    }
    
    var blurEffectStyle : UIBlurEffectStyle{
        return .light
    }
    var initialScaleAmmount : CGFloat{
        return 0.2
    }
    var animationDuration : TimeInterval{
        return 0.2
    }
    
}
