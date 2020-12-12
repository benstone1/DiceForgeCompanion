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
    @IBOutlet var rollCountLabel: UILabel!
    @IBOutlet var goldCountLabel: UILabel!
    @IBOutlet var sunshardsCountLabel: UILabel!
    @IBOutlet var moonShardsCountLabel: UILabel!
    @IBOutlet var victoryPointsCountLabel: UILabel!
    @IBOutlet var rollTypeSegmentedControl: UISegmentedControl!
    @IBOutlet var rollCountStepper: UIStepper!
    
    var statistics: DieStatistics {
        return settings.statistics(for: dieOneDie, and: dieTwoDie)
    }
    
    var settings: DieStatisticsSettings! {
        didSet {
            rollCountStepper.value = Double(settings.rollCount)
            rollCountLabel.text = "\(settings.rollCount) roll" + (settings.rollCount != 1 ? "s" : "")
            rollTypeSegmentedControl.selectedSegmentIndex = settings.rollType.rawValue
            let stats = statistics
            goldCountLabel.text = "\(stats.expectedGoldCount)"
            sunshardsCountLabel.text = "\(stats.expectedSunShardCount)"
            moonShardsCountLabel.text = "\(stats.expectedMoonShardCount)"
            victoryPointsCountLabel.text = "\(stats.expectedVictoryPointCount)"
        }
    }
    
    var dieOneDie: Die! {
        didSet {
            dieOneView.setDie(to: dieOneDie)
        }
    }
    var dieTwoDie: Die! {
        didSet {
            dieTwoView.setDie(to: dieTwoDie)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dieOneDie = Die.startingDieOne
        dieTwoDie = Die.startingDieTwo
        settings = DieStatisticsSettings.defaultSettings
        dieOneView.setDelegate(to: self)
        dieTwoView.setDelegate(to: self)
    }
    
    @IBAction func updateRollType(_ sender: UISegmentedControl) {
        let newRollType = RollType(rawValue: sender.selectedSegmentIndex)!
        settings.rollType = newRollType
    }
    @IBAction func rollCountChanged(_ sender: UIStepper) {
        settings.rollCount = Int(sender.value)
    }
    
}

extension DiceSelectionViewController: DieViewDelegate {
    func didSelect(dieView: DieView, at faceIndex: Int) {
        let selectVC = SelectDieFaceViewController()
        selectVC.onSelect = { (newFace) in
            var newDieFaces = dieView.getDie().faces
            newDieFaces[faceIndex] = newFace
            dieView.setDie(to: Die(faces: newDieFaces))
        }
        present(selectVC, animated: true)
    }
}
