//
//  NCardMontyViewController.swift
//  TabbedMonty
//
//  Created by The TEAM on 9/16/16.
//  Copyright © 2016 C4Q. All rights reserved.
//


import UIKit

class NCardMontyViewController: UIViewController {
    
    var gameLabel: UILabel!
    let howManyCards: Int
    
    let brain: MontyBrain
    
    let resetTitle = "Reset"
    
    required init?(coder aDecoder: NSCoder) {
        self.howManyCards = 19
        self.brain = MontyBrain(numCards: self.howManyCards)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGameButtons(v: self.view, totalButtons: self.howManyCards, buttonsPerRow: 6)
    }
    
    func resetButtonColors() {
        for v in view.subviews {
            if let button = v as? UIButton {
                if button.currentTitle != resetTitle {
                    button.backgroundColor = UIColor.blue
                    button.isEnabled = true
                    
                }
            }
        }
    }
    
    func handleReset() {
        resetButtonColors()
        brain.setupCards()
    }
    
    func disableCardButtons() {
        for v in view.subviews {
            if let button = v as? UIButton {
                if button.currentTitle != resetTitle {
                    button.isEnabled = false
                }
            }
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        gameLabel.text = sender.currentTitle
        
        if brain.checkCard(sender.tag - 1) {
            gameLabel.text = "Winner winner chicken dinner!"
            sender.backgroundColor = UIColor.green
            disableCardButtons()
            
            
        } else {
            gameLabel.text = "Nope! Guess again."
            sender.backgroundColor = UIColor.red
        }
    }
    
    func setUpResetButton() {
        let resetRect = CGRect(x: 10, y: 300, width: 60, height: 40)
        let resetButton = UIButton(frame: resetRect)
        resetButton.setTitle(resetTitle, for: UIControlState())
        resetButton.backgroundColor = UIColor.darkGray
        resetButton.addTarget(self, action: #selector(handleReset), for: .touchUpInside)
        view.addSubview(resetButton)
    }
    
    func setUpGameLabel () {
        gameLabel = UILabel()
        gameLabel.text = "Let's Play!"
        view.addSubview((gameLabel))
        gameLabel.translatesAutoresizingMaskIntoConstraints = false
        gameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        gameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setUpGameButtons(v: UIView, totalButtons: Int, buttonsPerRow : Int) {
        for i in 1...howManyCards {
            let y = ((i - 1) / buttonsPerRow)
            let x = ((i - 1) % buttonsPerRow)
            let side : CGFloat = v.bounds.size.width / CGFloat(buttonsPerRow)
            
            let rect = CGRect(origin: CGPoint(x: side * CGFloat(x), y: (CGFloat(y) * side + 100)), size: CGSize(width: side, height: side))
            let button = UIButton(frame: rect)
            button.tag = i
            button.backgroundColor = UIColor.blue
            button.setTitle(String(i), for: UIControlState())
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            self.view.addSubview(button)
        }
        setUpResetButton()
        setUpGameLabel()
    }
}


