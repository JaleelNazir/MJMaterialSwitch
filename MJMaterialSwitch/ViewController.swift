//
//  ViewController.swift
//  MJMaterialSwitch
//
//  Created by Jaleel on 3/21/17.
//  Copyright © 2017 Glynk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var switch1: MJMaterialSwitch!
    var switch2: MJMaterialSwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set target 
        self.switch1.addTarget(self, action: #selector(switchStateChanged(_:)), for: UIControl.Event.valueChanged)
        self.switch1.tag = 1

        let xPos: CGFloat = (UIScreen.main.bounds.width / 2 ) - 22.5
        let yPos: CGFloat = (UIScreen.main.bounds.height / 2 ) + 50.0
        self.switch2 = MJMaterialSwitch(frame: CGRect(x: xPos , y: yPos, width: 64, height: 60))
        self.switch2.addTarget(self, action: #selector(switchStateChanged(_:)), for: UIControl.Event.valueChanged)
        switch2.tarckEdgeInset = UIEdgeInsets(top: 18, left: 0, bottom: 18, right: 0)
        self.switch2.tag = 2
        
        //
        switch2.trackOnTintColor = UIColor.red.withAlphaComponent(0.6)
        switch2.thumbOnTintColor = UIColor.red
        
        // Call update UI method in last.
        switch2.updateUI()
        
        self.view.addSubview(self.switch2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc func switchStateChanged(_ mjSwitch: MJMaterialSwitch) {
        print(mjSwitch.isOn, mjSwitch.tag)
    }
}

