//
//  InputViewController.swift
//  OFO-demo
//
//  Created by 张艺哲 on 2017/7/28.
//  Copyright © 2017年 张艺哲. All rights reserved.
//

import UIKit
import APNumberPad

class InputViewController: UIViewController,APNumberPadDelegate,UITextFieldDelegate {
    var isFlashOn = false
    var isVoiceOn = true
    

    @IBOutlet weak var inputTestField: UITextField!
    
    @IBOutlet weak var goBtn: UIButton!
    
    
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
        
        
         let numberPad = APNumberPad(delegate: self)
        numberPad.leftFunctionButton.setTitle("确定", for: .normal)
        inputTestField.inputView = numberPad
        inputTestField.delegate = self
        

        // Do any additional setup after loading the view.
        
    }
    
    //numerpad左侧按钮
    
    func numberPad(_ numberPad: APNumberPad, functionButtonAction functionButton: UIButton, textInput: UIResponder) {
        print("你点了我")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else {
            return true
        }
        
        let newLength = text.characters.count + string.characters.count - range.length
        
        if newLength > 0 {
            goBtn.setImage(#imageLiteral(resourceName: "nextArrow_enable"), for: .normal)
            goBtn.backgroundColor = UIColor.ofo
        } else {
            goBtn.setImage(#imageLiteral(resourceName: "nextArrow_unenable"), for: .normal)
            goBtn.backgroundColor = UIColor.groupTableViewBackground
        }
        
        return newLength <= 8
        
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
