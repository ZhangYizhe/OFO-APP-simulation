//
//  InputViewController.swift
//  OFO-demo
//
//  Created by 张艺哲 on 2017/7/28.
//  Copyright © 2017年 张艺哲. All rights reserved.
//

import UIKit

class InputViewController: UIViewController {
    var isFlashOn = false
    var isVoiceOn = true
    

    @IBOutlet weak var inputTestField: UITextField!
    
    
    
    @IBOutlet weak var flashBtn: UIButton!
    @IBOutlet weak var voiceBtn: UIButton!
    

    @IBAction func flashBtnTap(_ sender: UIButton) {
        isFlashOn = !isFlashOn
        
        if isFlashOn {
            flashBtn.setImage(#imageLiteral(resourceName: "btn_enableTorch"), for: .normal)
        } else {
            flashBtn.setImage(#imageLiteral(resourceName: "btn_unenableTorch"), for: .normal)
        }
        
    }
    @IBAction func voiceBtnTap(_ sender: UIButton) {
       isVoiceOn = !isVoiceOn
        
        if isVoiceOn {
            voiceBtn.setImage(#imageLiteral(resourceName: "voiceopen"), for: .normal)
        } else {
            voiceBtn.setImage(#imageLiteral(resourceName: "voiceclose"), for: .normal)
        }

        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "车辆解锁"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "扫码用车", style: .plain, target: self, action: #selector(backToScan))
        
        
        inputTestField.layer.borderWidth = 2
        inputTestField.layer.borderColor = UIColor.ofo.cgColor
        
        navigationController?.navigationBar.barTintColor = UIColor.ofo
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barStyle = .black

        // Do any additional setup after loading the view.
        
    }
    
    func backToScan(){
        navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
