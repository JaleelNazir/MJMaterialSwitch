//
//  ViewController.swift
//  MJMaterialSwitch
//
//  Created by Jaleel on 3/21/17.
//  Copyright © 2017 Glynk. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MJMaterialSwitchDelegate {

    var androidSwitchSmall : MJMaterialSwitch!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.androidSwitchSmall = MJMaterialSwitch(withSize: .small, style: MJMaterialSwitchStyle.light, state: MJMaterialSwitchState.on)
        self.androidSwitchSmall.delegate = self
        self.view.addSubview(self.androidSwitchSmall)

        let androidSwitchMedium = MJMaterialSwitch(withSize: .normal, style: MJMaterialSwitchStyle.medium, state: MJMaterialSwitchState.on)
        androidSwitchMedium.delegate = self
        self.view.addSubview(androidSwitchMedium)


        let androidSwitchLarge = MJMaterialSwitch(withSize: .big, style: MJMaterialSwitchStyle.dark, state: MJMaterialSwitchState.on)
        androidSwitchLarge.delegate = self
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

    func switchStateChanged(_ currentState: MJMaterialSwitchState) {
        print(currentState)
    }
}

