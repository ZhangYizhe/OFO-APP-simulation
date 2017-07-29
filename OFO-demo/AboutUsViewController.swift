//
//  AboutUsViewController.swift
//  OFO-demo
//
//  Created by 张艺哲 on 2017/7/26.
//  Copyright © 2017年 张艺哲. All rights reserved.
//

import UIKit
import SWRevealViewController

class AboutUsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //启动容器包含两部分
        
        if let revealVC = revealViewController() {
            
            revealVC.rearViewRevealWidth = 280
            
            navigationItem.leftBarButtonItem?.target = revealVC
            navigationItem.leftBarButtonItem?.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }

        // Do any additional setup after loading the view.
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
