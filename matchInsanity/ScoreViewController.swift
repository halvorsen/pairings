//
//  ScoreViewController.swift
//  matchInsanity
//
//  Created by Aaron Halvorsen on 12/5/16.
//  Copyright © 2016 Aaron Halvorsen. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var fontSizeMultiplier = UIScreen.main.bounds.width / 375
    var scores: [String] = ["0","0","320450","0","0","0","0","0","0"]

    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let gameView: MatchViewController = segue.destination as! MatchViewController
//        gameView.y = y
//        gameView.z = z
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 23/255, green: 23/255, blue: 23/255, alpha: 1.0)
        addButtons()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    private func addButtons() {
        
        //button
        var arrow = UIButton()
        arrow.frame = CGRect(x: 329*screenWidth/750, y: 41*screenHeight/1332, width: 93*screenWidth/750, height: 76*screenWidth/750)
        arrow.setImage(UIImage(named: "Arrow.png"), for: .normal)
        arrow.tag = 200
        arrow.addTarget(self, action: #selector(ScoreViewController.menu(_:)), for: .touchUpInside)
        view.addSubview(arrow)
        
        //Labels
        let menuLabel = UILabel()
        menuLabel.frame.size = CGSize( width: screenWidth, height: (124/1332)*screenHeight)
        menuLabel.frame.origin.x = 0
        menuLabel.frame.origin.y = (160/1332)*screenHeight
        menuLabel.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*75)
        menuLabel.text = "Scores"
        menuLabel.textAlignment = .center
        menuLabel.textColor = UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0)
        view.addSubview(menuLabel)
        
        let topMargin: CGFloat = 444*screenHeight/1332
        let margin: CGFloat = 59*screenHeight/1332
    
        let xMargin2: CGFloat = 512

        for i in 0...17 {
            let annotation = UILabel()
            let annotations = ["Sanity", "Absurd", "Insane", "Sensible", "Ridiculous", "Idiotic", "Wise", "Farcical", "Foolish", scores[0], scores[1], scores[2], scores[3], scores[4], scores[5], scores[6], scores[7], scores[8]]
            annotation.text = annotations[i]
            annotation.frame.origin.x = 106*screenWidth/750
            annotation.textColor = UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0)
            annotation.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*20)
            annotation.frame.size = CGSize( width: (220/750)*screenWidth, height: (76/750)*screenWidth)
            annotation.textAlignment = .left
            annotation.frame.origin.y = topMargin + CGFloat(i)*margin
            if i > 8 {
                annotation.frame.origin.x += 380*screenWidth/750
                annotation.textAlignment = .right
                annotation.frame.size = CGSize( width: (159/750)*screenWidth, height: (76/750)*screenWidth)
                annotation.frame.origin.y = topMargin + CGFloat(i-9)*margin
                
            }
                        view.addSubview(annotation)
        }
        
        
        //images
        
        var image = UIImage()
        image = UIImage(named: "Troll.png")!
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 306*screenWidth/750, y: 1058*screenHeight/1332, width: 138*screenWidth/750, height: 150*screenWidth/750)
        view.addSubview(imageView)
        
        
    }
    
    @objc private func menu(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toMenuFromScore", sender: self)
    }
}
