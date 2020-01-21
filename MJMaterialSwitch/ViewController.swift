//
//  ViewController.swift
//  MJMaterialSwitch
//
//  Created by Jaleel on 3/21/17.
//  Copyright © 2017 Glynk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Tags
    let kSmallSwitch = 1
    let kMediumSwitch = 2
    let kLargeSwitch = 3

    var androidSwitchSmall: MJMaterialSwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc func switchStateChanged(_ mjSwitch: MJMaterialSwitch) {
        print(mjSwitch.isOn, mjSwitch.tag, "Large")
    }
}

