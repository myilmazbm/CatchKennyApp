//
//  ViewController.swift
//  CatchTheKenny
//
//  Created by macos12 on 1.07.2022.
//

import UIKit

class ViewController: UIViewController {
    var defaultTime = 10
    var defaultTimeTick = 1
    var defaultKennyTimeTick = 1
    var score = 0
    var timer = Timer()
    var hideTimer = Timer()
    var counter = 0
    var highScore = 0
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var kennyImg1: UIImageView!
    @IBOutlet weak var kennyImg2: UIImageView!
    @IBOutlet weak var kennyImg3: UIImageView!
    @IBOutlet weak var kennyImg4: UIImageView!
    @IBOutlet weak var kennyImg5: UIImageView!
    @IBOutlet weak var kennyImg6: UIImageView!
    @IBOutlet weak var kennyImg7: UIImageView!
    @IBOutlet weak var kennyImg8: UIImageView!
    @IBOutlet weak var kennyImg9: UIImageView!
    
    var kennyArray = [UIImageView]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let highScoreOld = UserDefaults.standard.object(forKey: "highScore")
        //print("aldı")
        if highScoreOld != nil{
            if let newScore = highScoreOld as? Int{
                highScore = newScore
            }
        }

        
        highScoreLabel.text = "High Score: \(highScore)"
        
        kennyArray = [kennyImg1,kennyImg2,kennyImg3,kennyImg4,kennyImg5,kennyImg6,kennyImg7,kennyImg8,kennyImg9]
        hideKenny()
        scoreLabel.text = "Score: \(score)"
        counter = defaultTime
        timeLabel.text = "\(counter)"
        
        for kenny in kennyArray {
            kenny.isUserInteractionEnabled = true
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
            kenny.addGestureRecognizer(recognizer)
        }
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(defaultTimeTick), target: self, selector: #selector(timerTicks), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: TimeInterval(defaultKennyTimeTick), target: self, selector: #selector(hideKennyTicks), userInfo: nil, repeats: true)
    }
    @objc func hideKennyTicks(){
        let randomNumber = Int.random(in: 0...(kennyArray.count-1))
        hideKenny()
        kennyArray[randomNumber].isHidden = false
    }
    
    @objc func timerTicks(){
        counter -= 1
        timeLabel.text = "\(counter)"
        
        
        if counter == 0 {
            
            timer.invalidate()
            hideTimer.invalidate()
            hideKenny()
            
            if score > highScore {
                highScore = score
                highScoreLabel.text = "High Score: \(highScore)"
                UserDefaults.standard.set(highScore, forKey: "highScore")
                
            }
            
            
            
            for kenny in kennyArray{
                kenny.isUserInteractionEnabled = false
            }
            let alert = UIAlertController(title: "Times's Up!!", message: "Do you want to play again?", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Raplay", style: .default) { Void in
                self.counter = self.defaultTime
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.timeLabel.text = "\(self.counter)"
                for kenny in self.kennyArray{
                    kenny.isUserInteractionEnabled = true
                }
                self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(self.defaultTimeTick), target: self, selector: #selector(self.timerTicks), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: TimeInterval(self.defaultKennyTimeTick), target: self, selector: #selector(self.hideKennyTicks), userInfo: nil, repeats: true)
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true)
        }
    }
    
    
    @objc func hideKenny(){
        for kenny in kennyArray {
            kenny.isHidden = true
        }
    }
    
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
        
    }

}

