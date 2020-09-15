//
//  ViewController.swift
//  CoreDataWithApi
//
//  Created by Jony on 21/08/20.
//  Copyright © 2020 Jony. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var dataModel = DataModel()
    var dataListArr = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getData()
    }

    func getData() {
        let objDataManager = DataManager()
        objDataManager.dataManager(product_id: "58", wk_token: "4da06d94de2a38b33e4daf39e1", width: "200", callBack: {(isSuccess, errorMesssage, dataModel)   in
            let strErrorMsg = errorMesssage
            let status = isSuccess
            if(status) {
                
                self.dataModel = dataModel!
//                print(self.dataModel.tabReview)
                
                
                self.dataListArr =  (dataModel?.postDataArray)!
                print(self.dataListArr.count)
                
//                let activitylist: DataListModel = self.dataListArr.object(at: 1) as! DataListModel
//                print(activitylist.customer_name)
                print("status ------------", status)
            } else {
                print("Error", strErrorMsg ?? "errorMesssage")
            }
        })
    }

}

