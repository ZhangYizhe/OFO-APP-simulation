//
//  NetWork.swift
//  OFO-demo
//
//  Created by 张艺哲 on 2017/8/1.
//  Copyright © 2017年 张艺哲. All rights reserved.
//
import AVOSCloud

struct Network {
    
    
}

extension Network {
    static func getpass(code: String, completion : @escaping (String?) -> Void) {
        
        let query = AVQuery(className: "Code")
        
        query.whereKey("code", equalTo: code)
        
        query.getFirstObjectInBackground { (code,e) in
            if let e = e{
                print("出错",e.localizedDescription)
                completion(nil)
            }
            
            if let code = code ,let pass = code["pass"] as? String{
                completion(pass)
            }
        }
        
    }
}
