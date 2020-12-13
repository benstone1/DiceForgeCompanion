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
            updateStats()
        }
    }
    
    func updateStats() {
        guard settings != nil && dieOneDie != nil && dieTwoDie != nil else { return }
        let stats = statistics
        if stats.expectedGoldCount.min == stats.expectedGoldCount.max {
            goldCountLabel.text = String(format: "%.2f", stats.expectedGoldCount.min)
        } else {
            goldCountLabel.text = String(format: "%.2f", stats.expectedGoldCount.min) + " - " + String(format: "%.2f", stats.expectedGoldCount.max)
        }
        if stats.expectedSunShardCount.min == stats.expectedSunShardCount.max {
            sunshardsCountLabel.text = String(format: "%.2f", stats.expectedSunShardCount.min)
        } else {
            sunshardsCountLabel.text = String(format: "%.2f", stats.expectedSunShardCount.min) + " - " + String(format: "%.2f", stats.expectedSunShardCount.max)
        }
        if stats.expectedMoonShardCount.min == stats.expectedMoonShardCount.max {
            moonShardsCountLabel.text = String(format: "%.2f", stats.expectedMoonShardCount.min)
        } else {
            moonShardsCountLabel.text = String(format: "%.2f", stats.expectedMoonShardCount.min) + " - " + String(format: "%.2f", stats.expectedMoonShardCount.max)
        }
        if stats.expectedVictoryPointCount.min == stats.expectedVictoryPointCount.max {
            victoryPointsCountLabel.text = String(format: "%.2f", stats.expectedVictoryPointCount.min)
        } else {
            victoryPointsCountLabel.text = String(format: "%.2f", stats.expectedVictoryPointCount.min) + " - " + String(format: "%.2f", stats.expectedVictoryPointCount.max)
        }
    }
    
    var dieOneDie: Die! {
        didSet {
            dieOneView.setDie(to: dieOneDie)
            updateStats()
        }
    }
    var dieTwoDie: Die! {
        didSet {
            dieTwoView.setDie(to: dieTwoDie)
            updateStats()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dieOneDie = Die.startingDieOne
        dieTwoDie = Die.startingDieTwo
        settings = DieStatisticsSettings.defaultSettings
        dieOneView.setDelegate(to: self)
        dieTwoView.setDelegate(to: self)
        dieOneView.setType(to: .leftDie)
        dieTwoView.setType(to: .rightDie)
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
        selectVC.onSelect = { [self] (newFace) in
            var newDieFaces = dieView.getDie().faces
            newDieFaces[faceIndex] = newFace
            let newDie = Die(faces: newDieFaces)
            if dieView.dieType == RollType.leftDie {
                self.dieOneDie = newDie
            } else if dieView.dieType == RollType.rightDie {
                self.dieTwoDie = newDie
            }
        }
        present(selectVC, animated: true)
    }
}
