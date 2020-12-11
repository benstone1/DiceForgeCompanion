//
//  ViewController.swift
//  DiceForgeCompanion
//
//  Created by Benjamin Stone on 10/8/20.
//  Copyright © 2020 Benjamin Stone. All rights reserved.
//

import UIKit

class DiceSelectionViewController: UIViewController {

    @IBOutlet var dieOneView: DieView!
    @IBOutlet var dieTwoView: DieView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dieOneView.setDie(to: Die.startingDieOne)
        dieTwoView.setDie(to: Die.startingDieTwo)
        dieOneView.setDelegate(to: self)
        dieTwoView.setDelegate(to: self)
    }
}

extension DiceSelectionViewController: DieViewDelegate {
    func didSelectDie(at faceIndex: Int) {
        print("Die \(faceIndex) selected")
    }
}
