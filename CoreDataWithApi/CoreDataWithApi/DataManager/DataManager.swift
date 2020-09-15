//
//  DataManager.swift
//  CoreDataWithApi
//
//  Created by Jony on 21/08/20.
//  Copyright © 2020 Jony. All rights reserved.
//

import UIKit
import Alamofire

class DataManager: NSObject {
    
    //    product_id: "58", wk_token: "4da06d94de2a38b33e4daf39e1", width: "200"
    func dataManager(product_id : String, wk_token: String, width : String, callBack :
        @escaping ((_ isSuccess : Bool, _ Message : String?, _ responseData :  DataModel?) -> ())) {
        let parameters: Parameters = [
            "product_id":product_id,
            "wk_token":wk_token,
            "width":width,
        ]
        let _: HTTPHeaders = [
            "Accept": "application/json"
        ]
//        print(parameters)
        
        Alamofire.request(Common_Domain, method: .post, parameters: parameters).responseJSON { response in
            if let json = response.result.value {
                print("JSON: \(json)")                      // serialized json response
                if let data = response.data,
                    let _ = String(data: data, encoding: .utf8) {
                    let dictionary = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! NSDictionary
                    if(dictionary?.object(forKey: "status") as! Int == 200) {
                        let dataModel: DataModel =  DataModel.getPostData(dataDict: dictionary!)
                        callBack(true, dictionary?.object(forKey: "message") as? String, dataModel)
                    }
                    else
                    {
                        callBack(false, dictionary?.object(forKey: "message") as? String, nil)
                    }
                }
                
            }
        }
    }
}
