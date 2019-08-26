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

    var btn: UIButton!

    var androidSwitchSmall : MJMaterialSwitch!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.androidSwitchSmall = MJMaterialSwitch(withSize: .small, style: MJMaterialSwitchStyle.light, state: MJMaterialSwitchState.on)
        self.androidSwitchSmall.tag = kSmallSwitch
        self.androidSwitchSmall.addTarget(self, action: #selector(switchStateChanged(_:)), for: UIControl.Event.valueChanged)
        self.view.addSubview(self.androidSwitchSmall)

        let androidSwitchMedium = MJMaterialSwitch(withSize: .normal, style: MJMaterialSwitchStyle.medium, state: MJMaterialSwitchState.on)
        androidSwitchMedium.isBounceEnabled = false
        androidSwitchMedium.isRippleEnabled = true
        androidSwitchMedium.tag = kMediumSwitch
        androidSwitchMedium.addTarget(self, action: #selector(switchStateChanged(_:)), for: UIControl.Event.valueChanged)
        self.view.addSubview(androidSwitchMedium)

        let androidSwitchLarge = MJMaterialSwitch(withSize: .big, style: MJMaterialSwitchStyle.dark, state: MJMaterialSwitchState.on)
        androidSwitchLarge.tag = kLargeSwitch
        androidSwitchLarge.addTarget(self, action: #selector(switchStateChanged(_:)), for: UIControl.Event.valueChanged)
        self.view.addSubview(androidSwitchLarge)

        self.androidSwitchSmall.center = self.view.center
        self.androidSwitchSmall.center.y = self.view.center.y - 50

        androidSwitchMedium.center = self.view.center

        androidSwitchLarge.center = self.view.center
        androidSwitchLarge.center.y = self.view.center.y + 50

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc func switchStateChanged(_ mjSwitch: MJMaterialSwitch) {

        if mjSwitch.tag == kSmallSwitch {
            print(mjSwitch.isOn, mjSwitch.tag, "Small")

        } else if mjSwitch.tag == kMediumSwitch {

            print(mjSwitch.isOn, mjSwitch.tag, "Medium")

        } else if mjSwitch.tag == kLargeSwitch {
            print(mjSwitch.isOn, mjSwitch.tag, "Large")

        }
    }
}

