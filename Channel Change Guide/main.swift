//
//  main.swift
//  Channel Change Guide
//
//  Created by DOMINGUEZ, LEO on 9/26/17.
//  Copyright © 2017 DOMINGUEZ, LEO. All rights reserved.
//

import UIKit

UIApplicationMain(CommandLine.argc, UnsafeMutableRawPointer(CommandLine.unsafeArgv) .bindMemory( to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc)), nil, NSStringFromClass(AppDelegate))

class main: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
