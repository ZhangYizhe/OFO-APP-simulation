//
//  ShowPasswordController.swift
//  OFO-demo
//
//  Created by 张艺哲 on 2017/7/30.
//  Copyright © 2017年 张艺哲. All rights reserved.
//

import UIKit
import SwiftyTimer

class ShowPasswordController: UIViewController {

    @IBOutlet weak var countDownLabel: UILabel!
    
    var remingSecond = 121
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        Timer.every(1) { (timer:Timer) in
            self.remingSecond -= 1
            
            self.countDownLabel.text = self.remingSecond.description
            
            if self.remingSecond == 0{
                timer.invalidate()
            }
        }
    }

    @IBAction func reportBtnTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
