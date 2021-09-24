//
//  SuccessViewController.swift
//  ZivameTask
//
//  Created by Sandeepan Swain on 22/09/21.
//

import UIKit
import CoreData

class SuccessViewController: UIViewController {
    let manager: StoreManager = StoreManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
            let result = manager.delete()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
