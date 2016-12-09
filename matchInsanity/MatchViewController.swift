//
//  ViewController.swift
//  matchInsanity
//
//  Created by Aaron Halvorsen on 11/18/16.
//  Copyright © 2016 Aaron Halvorsen. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController {
    
    let scrollView = UIScrollView(frame: UIScreen.main.bounds)
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var indexArray = [Int]()
    let myItems = Items()
    var y = 4
    var z = 3
    var fontSizeMultiplier = UIScreen.main.bounds.width / 375
    let frontMargin = 10*UIScreen.main.bounds.width/750 + 3
    let topMargin = 179*UIScreen.main.bounds.height/1332 + 3
    let tileWidth = UIScreen.main.bounds.width/5 - 10
    var tiles = [UILabel]() //save tile
    var tilesColors = [Int]() //save color number for each tile
    var rectArray = [CGRect]()
    var pointArray = [CGPoint]()
    let gap = ((UIScreen.main.bounds.width/5 - 4) - 62.5) / 2
    let game = String()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = self.scrollView
        self.scrollView.contentSize = CGSize(width: 2.9*screenWidth, height: 4.08*screenWidth)
        view.backgroundColor = UIColor(red: 23/255, green: 23/255, blue: 23/255, alpha: 1.0)
        addLabels()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(MatchViewController.respondToTapGesture(_:)))
        self.view.addGestureRecognizer(tap)
        
        organizeIndex()
        selectItems()
        
        
    }
    
    private func addLabels() {
        
        let arrow = UIButton()
        arrow.frame = CGRect(x: 670*screenWidth/750, y: 33*screenHeight/1332, width: 44*screenWidth/750, height: 37*screenWidth/750)
        arrow.setImage(UIImage(named: "Arrow.png"), for: .normal)
        arrow.tag = 200
        arrow.addTarget(self, action: #selector(MatchViewController.menu(_:)), for: .touchUpInside)
        view.addSubview(arrow)
        
        let scoreLabel = UILabel()
        scoreLabel.frame.size = CGSize( width: (500/750)*screenWidth, height: (115/1332)*screenHeight)
        scoreLabel.frame.origin.x = frontMargin
        scoreLabel.frame.origin.y = (31/1332)*screenHeight
        scoreLabel.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*70)
        scoreLabel.text = "123450"
        scoreLabel.textAlignment = .left
        scoreLabel.textColor = UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0)
        view.addSubview(scoreLabel)
        
        for i in 0...y {
            for j in 0...z {
                let tile = UILabel()
                tiles.append(tile)
                tile.frame.size = CGSize( width: tileWidth, height: tileWidth)
                tile.frame.origin.x = frontMargin + CGFloat(i)*(tileWidth + 6)
                tile.frame.origin.y = topMargin + CGFloat(j)*(tileWidth + 6)
                
                let point = CGPoint(x: frontMargin + CGFloat(i)*tileWidth, y: topMargin + CGFloat(j)*tileWidth)
                pointArray.append(point)
                
                let randomNumber = Int(arc4random_uniform(6))
                tilesColors.append(randomNumber)
                let alpha: CGFloat = 0.85
                switch randomNumber {
                    
                case 0: //red
                    tile.backgroundColor = UIColor(red: 236/255, green: 72/255, blue: 81/255, alpha: alpha)
                case 1: //orange
                    tile.backgroundColor = UIColor(red: 245/255, green: 133/255, blue: 57/255, alpha: alpha)
                case 2: //yellow
                    tile.backgroundColor = UIColor(red: 248/255, green: 223/255, blue: 74/255, alpha: alpha)
                case 3: //green
                    tile.backgroundColor = UIColor(red: 157/255, green: 206/255, blue: 92/255, alpha: alpha)
                case 4: //green
                    tile.backgroundColor = UIColor(red: 245/255, green: 133/255, blue: 57/255, alpha: alpha)
                case 5: //orange
                    tile.backgroundColor = UIColor(red: 248/255, green: 223/255, blue: 74/255, alpha: alpha)
                    
                default:
                    break
                }
                
                tile.layer.cornerRadius = 5.0
                
                tile.clipsToBounds = true
                rectArray.append(tile.frame)
                self.view.addSubview(tile)
                
            }
        }
    }
    
    var flipped1: Int?
    var flipped2: Int?
    var flippedTiles: Int = 0
    var tileAmount = 240
    var centerPoint = CGPoint()
    var binary = true
    var imageViewArray: [UIImageView?] = []
    var wordLabelArray = [UILabel?]()
    var done: [Int] = [500]
    
    @objc private func respondToTapGesture(_ gesture: UIGestureRecognizer) {
        
        
        if game == "sanity" || game == "absurd" || game == "insane" {
            switch flippedTiles {
            case 0, 1:
                centerPoint = gesture.location(in: view)
                outerLoop: for n in 0..<tileAmount {
                    if rectArray[n].contains(centerPoint) {
                        if done.contains(n) {
                            break outerLoop
                        }
                        tiles[n].alpha = 0.0
                        var image = UIImage()
                        if indexArray[n] < tileAmount/2 {
                            image = UIImage(named: listOfImagesToUse[indexArray[n]])!
                        } else {
                            image = UIImage(named: listOfImagesToUse[indexArray[n] - tileAmount/2])!
                        }
                        let imageView = UIImageView(image: image)
                        imageView.frame = CGRect(x: pointArray[n].x + gap, y: pointArray[n].y + gap, width: 125*screenWidth/750, height: 125*screenWidth/750)
                        imageView.alpha = 1.0
                        
                        if imageViewArray.count == 0 {
                            imageViewArray.append(imageView)
                            flipped1 = n
                        } else if imageViewArray.count == 1 {
                            imageViewArray.append(imageView)
                            flipped2 = n
                        } else if binary {
                            imageViewArray[0] = imageView
                            flipped1 = n
                            binary = false
                        } else {
                            imageViewArray[1] = imageView
                            flipped2 = n
                            binary = true
                        }
                        view.addSubview(imageView)
                        
                        if flipped1 != nil && flipped2 != nil {
                            if tiles[flipped1!].alpha == 0.0 && tiles[(flipped2!)].alpha == 0.0 {
                                flippedTiles = 2
                                
                                if (indexArray[flipped1!] == indexArray[flipped2!] - tileAmount/2) || (indexArray[flipped1!] == indexArray[flipped2!] + tileAmount/2) {
                                    done.append(flipped1!)
                                    done.append(flipped2!)
                                    flipped1 = nil
                                    flipped2 = nil
                                    
                                    imageViewArray[0]!.alpha = 0.2
                                    imageViewArray[1]!.alpha = 0.2
                                    imageViewArray[0] = nil
                                    imageViewArray[1] = nil
                                    flippedTiles = 0
                                    
                                    
                                }
                            } else {
                                flippedTiles = 1
                            }
                            
                        } else {
                            flippedTiles = 1
                        }
                        
                        break outerLoop
                    }
                    
                }
                
            case 2:
                centerPoint = gesture.location(in: view)
                outerLoop: for n in 0..<tileAmount {
                    
                    if rectArray[n].contains(centerPoint) && flipped1 != nil && flipped2 != nil  {
                        if done.contains(n) {
                            print("entered case 2 done statement")
                            print(done)
                            break outerLoop
                        }
                        tiles[flipped1!].alpha = 1.0
                        tiles[flipped2!].alpha = 1.0
                        imageViewArray[0]?.removeFromSuperview()
                        imageViewArray[1]?.removeFromSuperview()
                    }
                    if rectArray[n].contains(centerPoint) {
                        if done.contains(n) {
                            print("entered case 2 done statement")
                            print(done)
                            break outerLoop
                        }
                        tiles[n].alpha = 0.0
                        var image = UIImage()
                        if indexArray[n] < tileAmount/2 {
                            image = UIImage(named: listOfImagesToUse[indexArray[n]])!
                        } else {
                            image = UIImage(named: listOfImagesToUse[indexArray[n] - tileAmount/2])!
                        }
                        let imageView = UIImageView(image: image)
                        imageView.frame = CGRect(x: pointArray[n].x + gap, y: pointArray[n].y + gap, width: 125*screenWidth/750, height: 125*screenWidth/750)
                        imageView.alpha = 1.0
                        view.addSubview(imageView)
                        
                        if binary {
                            imageViewArray[0] = imageView
                            flipped1 = n
                            binary = false
                        } else {
                            imageViewArray[1] = imageView
                            flipped2 = n
                            binary = true
                        }
                        flippedTiles = 1
                        
                        break outerLoop
                    }
                    
                }
                
            default:
                break
            }
        }
        
        if game == "wise" || game == "farcical" || game == "foolish" {
            switch flippedTiles {
            case 0, 1:
                centerPoint = gesture.location(in: view)
                outerLoop: for n in 0..<tileAmount {
                    if rectArray[n].contains(centerPoint) {
                        if done.contains(n) {
                            break outerLoop
                        }
                        tiles[n].alpha = 0.0
                       
                        let wordView = UILabel()
                        if indexArray[n] < tileAmount/2 {
                            wordView.text = listOfWordsToUse[indexArray[n]]
                        } else {
                            wordView.text = listOfWordsToUse[indexArray[n] - tileAmount/2]
                        }
                        
                        wordView.frame = CGRect(x: pointArray[n].x + gap, y: pointArray[n].y + gap, width: 125*screenWidth/750, height: 125*screenWidth/750)
                        wordView.alpha = 1.0
                        wordView.textAlignment = .center
                        wordView.textColor = UIColor.white
                        
                        if wordLabelArray.count == 0 {
                            wordLabelArray.append(wordView)
                            flipped1 = n
                        } else if wordLabelArray.count == 1 {
                            wordLabelArray.append(wordView)
                            flipped2 = n
                        } else if binary {
                            wordLabelArray[0] = wordView
                            flipped1 = n
                            binary = false
                        } else {
                            wordLabelArray[1] = wordView
                            flipped2 = n
                            binary = true
                        }
                        view.addSubview(wordView)
                        
                        if flipped1 != nil && flipped2 != nil {
                            if tiles[flipped1!].alpha == 0.0 && tiles[(flipped2!)].alpha == 0.0 {
                                flippedTiles = 2
                                
                                if (indexArray[flipped1!] == indexArray[flipped2!] - tileAmount/2) || (indexArray[flipped1!] == indexArray[flipped2!] + tileAmount/2) {
                                    done.append(flipped1!)
                                    done.append(flipped2!)
                                    flipped1 = nil
                                    flipped2 = nil
                                    
                                    wordLabelArray[0]!.alpha = 0.2
                                    wordLabelArray[1]!.alpha = 0.2
                                    wordLabelArray[0] = nil
                                    wordLabelArray[1] = nil
                                    flippedTiles = 0
                                    
                                    
                                }
                            } else {
                                flippedTiles = 1
                            }
                            
                        } else {
                            flippedTiles = 1
                        }
                        
                        break outerLoop
                    }
                    
                }
                
            case 2:
                centerPoint = gesture.location(in: view)
                outerLoop: for n in 0..<tileAmount {
                    
                    if rectArray[n].contains(centerPoint) && flipped1 != nil && flipped2 != nil  {
                        if done.contains(n) {
                            print("entered case 2 done statement")
                            print(done)
                            break outerLoop
                        }
                        tiles[flipped1!].alpha = 1.0
                        tiles[flipped2!].alpha = 1.0
                        imageViewArray[0]?.removeFromSuperview()
                        imageViewArray[1]?.removeFromSuperview()
                    }
                    if rectArray[n].contains(centerPoint) {
                        if done.contains(n) {
                            print("entered case 2 done statement")
                            print(done)
                            break outerLoop
                        }
                        tiles[n].alpha = 0.0
                        var image = UIImage()
                        if indexArray[n] < tileAmount/2 {
                            image = UIImage(named: myItems.listOfImages[indexArray[n]])!
                        } else {
                            image = UIImage(named: myItems.listOfImages[indexArray[n] - tileAmount/2])!
                        }
                        let imageView = UIImageView(image: image)
                        imageView.frame = CGRect(x: pointArray[n].x + gap, y: pointArray[n].y + gap, width: 125*screenWidth/750, height: 125*screenWidth/750)
                        imageView.alpha = 1.0
                        view.addSubview(imageView)
                        
                        if binary {
                            imageViewArray[0] = imageView
                            flipped1 = n
                            binary = false
                        } else {
                            imageViewArray[1] = imageView
                            flipped2 = n
                            binary = true
                        }
                        flippedTiles = 1
                        
                        break outerLoop
                    }
                    
                }
                
            default:
                break
            }
        }
        
        if game == "sensible" || game == "rediculous" || game == "idiotic" {
            switch flippedTiles {
            case 0, 1:
                centerPoint = gesture.location(in: view)
                outerLoop: for n in 0..<tileAmount {
                    if rectArray[n].contains(centerPoint) {
                        if done.contains(n) {
                            break outerLoop
                        }
                        tiles[n].alpha = 0.0
                        var image = UIImage()
                        if indexArray[n] < tileAmount/2 {
                            image = UIImage(named: myItems.listOfImages[indexArray[n]])!
                        } else {
                            image = UIImage(named: myItems.listOfImages[indexArray[n] - tileAmount/2])!
                        }
                        let imageView = UIImageView(image: image)
                        imageView.frame = CGRect(x: pointArray[n].x + gap, y: pointArray[n].y + gap, width: 125*screenWidth/750, height: 125*screenWidth/750)
                        imageView.alpha = 1.0
                        
                        if imageViewArray.count == 0 {
                            imageViewArray.append(imageView)
                            flipped1 = n
                        } else if imageViewArray.count == 1 {
                            imageViewArray.append(imageView)
                            flipped2 = n
                        } else if binary {
                            imageViewArray[0] = imageView
                            flipped1 = n
                            binary = false
                        } else {
                            imageViewArray[1] = imageView
                            flipped2 = n
                            binary = true
                        }
                        view.addSubview(imageView)
                        
                        if flipped1 != nil && flipped2 != nil {
                            if tiles[flipped1!].alpha == 0.0 && tiles[(flipped2!)].alpha == 0.0 {
                                flippedTiles = 2
                                
                                if (indexArray[flipped1!] == indexArray[flipped2!] - tileAmount/2) || (indexArray[flipped1!] == indexArray[flipped2!] + tileAmount/2) {
                                    done.append(flipped1!)
                                    done.append(flipped2!)
                                    flipped1 = nil
                                    flipped2 = nil
                                    
                                    imageViewArray[0]!.alpha = 0.2
                                    imageViewArray[1]!.alpha = 0.2
                                    imageViewArray[0] = nil
                                    imageViewArray[1] = nil
                                    flippedTiles = 0
                                    
                                    
                                }
                            } else {
                                flippedTiles = 1
                            }
                            
                        } else {
                            flippedTiles = 1
                        }
                        
                        break outerLoop
                    }
                    
                }
                
            case 2:
                centerPoint = gesture.location(in: view)
                outerLoop: for n in 0..<tileAmount {
                    
                    if rectArray[n].contains(centerPoint) && flipped1 != nil && flipped2 != nil  {
                        if done.contains(n) {
                            print("entered case 2 done statement")
                            print(done)
                            break outerLoop
                        }
                        tiles[flipped1!].alpha = 1.0
                        tiles[flipped2!].alpha = 1.0
                        imageViewArray[0]?.removeFromSuperview()
                        imageViewArray[1]?.removeFromSuperview()
                    }
                    if rectArray[n].contains(centerPoint) {
                        if done.contains(n) {
                            print("entered case 2 done statement")
                            print(done)
                            break outerLoop
                        }
                        tiles[n].alpha = 0.0
                        var image = UIImage()
                        if indexArray[n] < tileAmount/2 {
                            image = UIImage(named: myItems.listOfImages[indexArray[n]])!
                        } else {
                            image = UIImage(named: myItems.listOfImages[indexArray[n] - tileAmount/2])!
                        }
                        let imageView = UIImageView(image: image)
                        imageView.frame = CGRect(x: pointArray[n].x + gap, y: pointArray[n].y + gap, width: 125*screenWidth/750, height: 125*screenWidth/750)
                        imageView.alpha = 1.0
                        view.addSubview(imageView)
                        
                        if binary {
                            imageViewArray[0] = imageView
                            flipped1 = n
                            binary = false
                        } else {
                            imageViewArray[1] = imageView
                            flipped2 = n
                            binary = true
                        }
                        flippedTiles = 1
                        
                        break outerLoop
                    }
                    
                }
                
            default:
                break
            }
        }
        
    }
    var listOfImagesToUse = [String]()
    var listOfWordsToUse = [String]()
    private func selectItems() {
        var randomNumber = Int()
        var Bool = true
        for _ in 0..<(tileAmount/2) {
            while Bool {
                
                randomNumber = Int(arc4random_uniform(UInt32(myItems.listOfImages.count)))
                if !listOfImagesToUse.contains(myItems.listOfImages[randomNumber]) {
                    Bool = false
                }
            }
        }
        listOfImagesToUse.append(myItems.listOfImages[randomNumber])
        if game == "wise" {
        for i in 0..<35 {
            listOfWordsToUse.append(myItems.listOfWords[i])
        }
        }
        if game == "farcical" {
            
        for i in 0..<120 {
            listOfWordsToUse.append(myItems.listOfWords[i+35])
        }
        }
        if game == "foolish" {

        for i in 0..<225 {
            listOfWordsToUse.append(myItems.listOfWords[i+155])
        }
        }
    }
    
    private func organizeIndex() {
        
        for _ in 0..<tileAmount {
            
            binary = true
            while binary {
                let randomNumber = Int(arc4random_uniform(UInt32(tileAmount)))
                if !indexArray.contains(randomNumber) {
                    indexArray.append(randomNumber)
                    binary = false
                }
            }
        }
        //        let m = imageIndexArray[0]
        //        if m > tileAmount / 2 {
        //            for i in 0..<tileAmount {
        //                if m == imageIndexArray[i] + tileAmount / 2 {
        //                    print("ROW: \(Int(i/15))")
        //                    print("COLM: \(i%15)")
        //                }
        //            }
        //        } else {
        //            for i in 0..<tileAmount {
        //                if m == imageIndexArray[i] - tileAmount / 2 {
        //                    print("ROW: \(Int(i/15))")
        //                    print("COLM: \(i%15)")
        //                }
        //            }
        //        }
        
        
    }
    
    
    
    
    
    @objc private func menu(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toMenuFromMatch", sender: self)
    }
    
    private func buyBonuses() {
        //IAP
    }
    
    
    private func sanityLevel(_ sender: UIButton) {
        y = 4
        z = 6
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        done.removeAll()
        tileAmount = (y+1)*(z+1)
        rectArray.removeAll()
        pointArray.removeAll()
        indexArray.removeAll()
        tiles.removeAll()
        tilesColors.removeAll()
        imageViewArray.removeAll()
        self.scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight)
        addLabels()
        organizeIndex()
        selectItems()
        binary = true
        flippedTiles = 0
        flipped1 = nil
        flipped2 = nil
        done.append(500)
        
    }
    private func absurdLevel(_ sender: UIButton) {
        y = 14
        z = 15
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        done.removeAll()
        tileAmount = (y+1)*(z+1)
        rectArray.removeAll()
        pointArray.removeAll()
        indexArray.removeAll()
        tiles.removeAll()
        tilesColors.removeAll()
        imageViewArray.removeAll()
        self.scrollView.contentSize = CGSize(width: 2.9*screenWidth, height: 4.08*screenWidth)
        addLabels()
        organizeIndex()
        selectItems()
        binary = true
        flippedTiles = 0
        flipped1 = nil
        flipped2 = nil
        done.append(500)
        
    }
    
    private func insaneLevel(_ sender: UIButton) {
        y = 14
        z = 29
        done.removeAll()
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        tileAmount = (y+1)*(z+1)
        rectArray.removeAll()
        pointArray.removeAll()
        indexArray.removeAll()
        tiles.removeAll()
        tilesColors.removeAll()
        imageViewArray.removeAll()
        self.scrollView.contentSize = CGSize(width: 2.9*screenWidth, height: 4.08*screenWidth)
        addLabels()
        organizeIndex()
        selectItems()
        binary = true
        flippedTiles = 0
        flipped1 = nil
        flipped2 = nil
        done.append(500)
        
    }
    
    private func wiseLevel(_ sender: UIButton) {
        y = 4
        z = 6
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        done.removeAll()
        tileAmount = (y+1)*(z+1)
        rectArray.removeAll()
        pointArray.removeAll()
        indexArray.removeAll()
        tiles.removeAll()
        tilesColors.removeAll()
        imageViewArray.removeAll()
        self.scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight)
        addLabels()
        organizeIndex()
        selectItems()
        binary = true
        flippedTiles = 0
        flipped1 = nil
        flipped2 = nil
        done.append(500)
        
    }
    private func farcicalLevel(_ sender: UIButton) {
        y = 14
        z = 15
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        done.removeAll()
        tileAmount = (y+1)*(z+1)
        rectArray.removeAll()
        pointArray.removeAll()
        indexArray.removeAll()
        tiles.removeAll()
        tilesColors.removeAll()
        imageViewArray.removeAll()
        self.scrollView.contentSize = CGSize(width: 2.9*screenWidth, height: 4.08*screenWidth)
        addLabels()
        organizeIndex()
        selectItems()
        binary = true
        flippedTiles = 0
        flipped1 = nil
        flipped2 = nil
        done.append(500)
        
    }
    
    private func foolishLevel(_ sender: UIButton) {
        y = 14
        z = 29
        done.removeAll()
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        tileAmount = (y+1)*(z+1)
        rectArray.removeAll()
        pointArray.removeAll()
        indexArray.removeAll()
        tiles.removeAll()
        tilesColors.removeAll()
        imageViewArray.removeAll()
        self.scrollView.contentSize = CGSize(width: 2.9*screenWidth, height: 4.08*screenWidth)
        addLabels()
        organizeIndex()
        selectItems()
        binary = true
        flippedTiles = 0
        flipped1 = nil
        flipped2 = nil
        done.append(500)
        
    }
    
    private func sensibleLevel(_ sender: UIButton) {
        y = 4
        z = 6
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        done.removeAll()
        tileAmount = (y+1)*(z+1)
        rectArray.removeAll()
        pointArray.removeAll()
        indexArray.removeAll()
        tiles.removeAll()
        tilesColors.removeAll()
        imageViewArray.removeAll()
        self.scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight)
        addLabels()
        organizeIndex()
        selectItems()
        binary = true
        flippedTiles = 0
        flipped1 = nil
        flipped2 = nil
        done.append(500)
        
    }
    private func rediculousLevel(_ sender: UIButton) {
        y = 14
        z = 15
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        done.removeAll()
        tileAmount = (y+1)*(z+1)
        rectArray.removeAll()
        pointArray.removeAll()
        indexArray.removeAll()
        tiles.removeAll()
        tilesColors.removeAll()
        imageViewArray.removeAll()
        self.scrollView.contentSize = CGSize(width: 2.9*screenWidth, height: 4.08*screenWidth)
        addLabels()
        organizeIndex()
        selectItems()
        binary = true
        flippedTiles = 0
        flipped1 = nil
        flipped2 = nil
        done.append(500)
        
    }
    
    private func idioticLevel(_ sender: UIButton) {
        y = 14
        z = 29
        done.removeAll()
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        tileAmount = (y+1)*(z+1)
        rectArray.removeAll()
        pointArray.removeAll()
        indexArray.removeAll()
        tiles.removeAll()
        tilesColors.removeAll()
        imageViewArray.removeAll()
        self.scrollView.contentSize = CGSize(width: 2.9*screenWidth, height: 4.08*screenWidth)
        addLabels()
        organizeIndex()
        selectItems()
        binary = true
        flippedTiles = 0
        flipped1 = nil
        flipped2 = nil
        done.append(500)
        
    }
    
    
    
}



