//
//  ShowPasswordController.swift
//  OFO-demo
//
//  Created by 张艺哲 on 2017/7/30.
//  Copyright © 2017年 张艺哲. All rights reserved.
//

import UIKit
import SwiftyTimer
import SwiftySound

class ShowPasswordController: UIViewController {
    
    
    @IBOutlet weak var label1st: MyPreviewLabel!
    @IBOutlet weak var label2nd: MyPreviewLabel!
    @IBOutlet weak var label3rd: MyPreviewLabel!
    @IBOutlet weak var label4th: MyPreviewLabel!

    
    
    @IBAction func overtravelBtnTap(_ sender: UIBarButtonItem) {
        
      dismiss(animated: true, completion: nil)
    }
    

    
    @IBOutlet weak var codeflagLabel: UILabel!
    
    let defaults = UserDefaults.standard
        var code = ""//车牌号
    
    var passArray : [String] = []//{}属性监视器
    
    
    

    @IBOutlet weak var countDownLabel: UILabel!
    
    var remingSecond = 121
    
    var isTouchOn = false
    var isVoiceOn = true
    
    
    @IBOutlet weak var torchBtn: UIButton!
    @IBAction func torchBtnTap(_ sender: UIButton) {
        turnTorch()
        
        if isTouchOn {
            torchBtn.setImage(#imageLiteral(resourceName: "btn_unenableTorch"), for: .normal)
        } else {
            torchBtn.setImage(#imageLiteral(resourceName: "btn_enableTorch"), for: .normal)
        }
        
        isTouchOn = !isTouchOn
    }
    
    @IBOutlet weak var voiceBtn: UIButton!
    @IBAction func voiceBtnTap(_ sender: UIButton) {
        

        
        if isVoiceOn {
            voiceBtn.setImage(#imageLiteral(resourceName: "voiceclose"), for: .normal)
            

            
            defaults.set(false, forKey: "isVoiceOn")
            
            Sound.stopAll()
        } else {
            voiceBtn.setImage(#imageLiteral(resourceName: "voiceopen"), for: .normal)
            
            defaults.set(true, forKey: "isVoiceOn")
            
            
            Sound.play(file: "骑行结束_LH.m4a")
            
        }
        
        isVoiceOn = !isVoiceOn
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeflagLabel.text = "车牌号\(code)的解锁码"

        // Do any additional setup after loading the view.
        
        Timer.every(1) { (timer:Timer) in
            self.remingSecond -= 1
            
            self.countDownLabel.text = self.remingSecond.description
            
            if self.remingSecond == 0{
                timer.invalidate()
            }
        }
        
        if defaults.bool(forKey: "isVoiceOn")
        {
            Sound.play(file: "骑行结束_LH.m4a")
            voiceBtn.setImage(#imageLiteral(resourceName: "voiceopen"), for: .normal)
        }else{
            voiceBtn.setImage(#imageLiteral(resourceName: "voiceclose"), for: .normal)
            isVoiceOn = false
        }
        
        
        self.label1st.text = passArray[0]
        self.label2nd.text = passArray[1]
        self.label3rd.text = passArray[2]
        self.label4th.text = passArray[3]

        
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
