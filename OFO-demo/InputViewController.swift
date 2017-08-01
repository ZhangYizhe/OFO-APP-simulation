//
//  InputViewController.swift
//  OFO-demo
//
//  Created by 张艺哲 on 2017/7/28.
//  Copyright © 2017年 张艺哲. All rights reserved.
//

import UIKit
import APNumberPad
import FTIndicator

class InputViewController: UIViewController,APNumberPadDelegate,UITextFieldDelegate {
    var isFlashOn = false
    var isVoiceOn = true
    let defaults = UserDefaults.standard
    
    

    @IBAction func goBtnTap(_ sender: UIButton) {
        checkPass()
    }
        
        
        

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
            defaults.set(true, forKey: "isVoiceOn")
        } else {
            voiceBtn.setImage(#imageLiteral(resourceName: "voiceclose"), for: .normal)
            defaults.set(false, forKey: "isVoiceOn")
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
        

            goBtn.isEnabled = false
        
        if defaults.bool(forKey: "isVoiceOn")
        {
            voiceBtn.setImage(#imageLiteral(resourceName: "voiceopen"), for: .normal)
        }else{
            voiceBtn.setImage(#imageLiteral(resourceName: "voiceclose"), for: .normal)
            isVoiceOn = false
        }
        

        // Do any additional setup after loading the view.
        
    }
    
    //numerpad左侧按钮
    
    func numberPad(_ numberPad: APNumberPad, functionButtonAction functionButton: UIButton, textInput: UIResponder) {
        

        checkPass()
        

        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else {
            return true
        }
        
        let newLength = text.characters.count + string.characters.count - range.length
        
        if newLength > 0 {
            goBtn.setImage(#imageLiteral(resourceName: "nextArrow_enable"), for: .normal)
            goBtn.backgroundColor = UIColor.ofo
            
            goBtn.isEnabled = true
            
        } else {
            goBtn.setImage(#imageLiteral(resourceName: "nextArrow_unenable"), for: .normal)
            goBtn.backgroundColor = UIColor.groupTableViewBackground
            
            goBtn.isEnabled = false
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
    
    
    
    
    var passArray : [String] = [] //密码分割
    
    func checkPass() {
        
        if !inputTestField.text!.isEmpty{
            
           let code = inputTestField.text!
            
            Network.getpass(code: code, completion: { (pass) in
                
                
                
                if let pass = pass{
                    //"9999"转换成["9","9","9","9"]
                    self.passArray = pass.characters.map{
                        return $0.description
                    }
                    
                    self.performSegue(withIdentifier: "showPasscode", sender: self)
                    
                }else {
                    self.performSegue(withIdentifier: "showErrorView", sender: self)
                }
            })
            
            

            
        }
        
        
        
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showPasscode" {//确认是有指定identifier触发
            
        
            let dest = segue.destination as! ShowPasswordController //获取目标转场控制器并转换成具体的类
            let code = inputTestField.text!//设置目标控制器属性
            dest.code = code
            dest.passArray = self.passArray
        
            
            
        }
        
    }
    

}
