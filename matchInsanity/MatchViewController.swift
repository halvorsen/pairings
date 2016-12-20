//
//  ViewController.swift
//  matchInsanity
//
//  Created by Aaron Halvorsen on 11/18/16.
//  Copyright © 2016 Aaron Halvorsen. All rights reserved.
//

import UIKit
import CoreData
import AudioToolbox

class MatchViewController: UIViewController {
    
    let scrollView = UIScrollView(frame: UIScreen.main.bounds)
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var indexArray = [Int]()
    let myItems = Items()
    var y = 4
    var z = 3
    var fontSizeMultiplier = UIScreen.main.bounds.width / 375
    var frontMargin = 10*UIScreen.main.bounds.width/750
    var topMargin = 179*UIScreen.main.bounds.height/1332 + 3
    var tileWidth = (UIScreen.main.bounds.width - 60*UIScreen.main.bounds.width/750)/5
    var tileHeight = (UIScreen.main.bounds.width - 60*UIScreen.main.bounds.width/750)/5
    var tiles = [UILabel]() //save tile
    var tilesColors = [Int]() //save color number for each tile
    var rectArray = [CGRect]()
    var pointArray = [CGPoint]()
    var gap = (UIScreen.main.bounds.width - 60*UIScreen.main.bounds.width/750)/50
    var margin = 10*UIScreen.main.bounds.width/750
    var game = String()
    var gameData = String()
    var flipped1: Int?
    var flipped2: Int?
    var flipped3: Int?
    var flippedTiles: Int = 0
    var tileAmount = Int()
    var centerPoint = CGPoint()
    var binary = true
    var triCount = 1
    var imageViewArray: [UIImageView?] = [nil, nil, nil]
    var wordLabelArray = [UILabel?]()
    var done = [Int]()
    var listOfImagesToUse = [String]()
    var listOfWordsToUse = [String]()
    var list = [String]()
    var index = [Int]()
    var resultsGameRequest = [AnyObject]()
    var isNewBoard = 1
    var time: Int = 0
    var guessNumber: Int = 0
    var scoreLabel = UILabel()
    var scoreText = String()
    var imageWidth = 8*(UIScreen.main.bounds.width - 60*UIScreen.main.bounds.width/750)/50
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var score: Int = 0 {didSet {
    
        let remainder = score%10
        scoreText = String(score - remainder)
        
        } }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        print("imagewidth: \(imageWidth)")
        print("tilewidth: \(tileWidth)")
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        
        self.view = self.scrollView
        
        view.backgroundColor = UIColor(red: 42/255, green: 42/255, blue: 42/255, alpha: 1.0)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(MatchViewController.respondToTapGesture(_:)))
        self.view.addGestureRecognizer(tap)
        
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {

        if game == "wise" || game == "farcical" || game == "foolish" {
            tileHeight = 1.06*tileWidth/2
            tileWidth = (screenWidth - 40*screenWidth/750)/3
        
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            if game == "wise" || game == "farcical" || game == "foolish" {
               margin = 5
                tileWidth = (screenWidth - 2*frontMargin - 9*margin)/10
                tileHeight = tileWidth/3
                topMargin = tileWidth
                
            } else {
                margin = 5
            tileHeight = (screenWidth - 2*frontMargin - 14*margin)/15
            tileWidth = tileHeight
            topMargin = tileHeight
            
            }
            gap = tileWidth / 10
            imageWidth = 0.8*tileWidth
            if game == "wise" || game == "sanity" || game == "sensible" {
                
                tileWidth += tileWidth
                tileHeight  += tileHeight
            }
            
            

            
        }
        
        tileAmount = (y+1)*(z+1)
    
        if isNewBoard == 1 {
            organizeIndex()
            
            selectItems()
            if done.count == 0 {
                done.append(500)
            }
        } else {
            if game == "wise" || game == "farcical" || game == "foolish" {
                listOfWordsToUse = list
            } else {
                listOfImagesToUse = list
            }
            indexArray = index
        }
  
        addLabels()
        if done.count > 1 {
            if game == "wise" || game == "farcical" || game == "foolish" {
                for n in done {
                    if n == 500 {
                        print("500")
                    } else {
                    print("n tiles: \(n)")
                    tiles[n].alpha = 0.0
                    
                    let wordView = UILabel()
                    
                    wordView.text = listOfWordsToUse[indexArray[n]]
                    
                    
                    wordView.frame = CGRect(x: pointArray[n].x - margin, y: pointArray[n].y, width: tileWidth + margin, height: tileHeight)
                    wordView.font = UIFont(name: "HelveticaNeue-Bold", size: 10)
                    wordView.alpha = 0.2
                    wordView.textAlignment = .center
                    wordView.textColor = UIColor.white
                    view.addSubview(wordView)
                     guessNumber += 1
                    }
                }
                
            } else if game == "sanity" || game == "absurd" || game == "insane" {
                for n in done {
                    if n == 500 {
                        print("500")
                    } else {
                  
                        var image = UIImage()
                        if indexArray[n] < tileAmount/2 {
                            image = UIImage(named: listOfImagesToUse[indexArray[n]])!
                        } else {
                            image = UIImage(named: listOfImagesToUse[indexArray[n] - tileAmount/2])!
                        }
                        let imageView = UIImageView(image: image)
                        imageView.frame = CGRect(x: pointArray[n].x + gap, y: pointArray[n].y + gap, width: imageWidth, height: imageWidth)
                        imageView.alpha = 0.2
                        view.addSubview(imageView)
                         guessNumber += 1
                        tiles[n].alpha = 0.0
                    }
                }
            } else {
                for n in done {
                    if n == 500 {
                        print("500")
                    } else {
                    
                        var image = UIImage()
                        if indexArray[n] < tileAmount/3 {
                            image = UIImage(named: myItems.listOfImages[indexArray[n]])!
                        } else if indexArray[n] < 2*tileAmount/3 {
                            image = UIImage(named: myItems.listOfImages[indexArray[n] - tileAmount/3])!
                        } else {
                            image = UIImage(named: myItems.listOfImages[indexArray[n] - 2*tileAmount/3])!
                        }
                        let imageView = UIImageView(image: image)
                        imageView.frame = CGRect(x: pointArray[n].x + gap, y: pointArray[n].y + gap, width: imageWidth, height: imageWidth)
                        imageView.alpha = 0.2
                        view.addSubview(imageView)
                        guessNumber += 1
                        tiles[n].alpha = 0.0
                    }
                }
            }
  
        }
     
        
    }


    
    func appMovedToBackground() {
        saveLevel()
    }
    
    @objc private func timerAction() {
        time += 1
    }
    
    private func addLabels() {
        
        let arrow = UIButton()
        arrow.frame = CGRect(x: 25*screenWidth/750, y: 33*screenHeight/1332, width: 44*screenWidth/750, height: 37*screenWidth/750)
        arrow.setImage(UIImage(named: "Arrow.png"), for: .normal)
        arrow.tag = 200
        arrow.addTarget(self, action: #selector(MatchViewController.menu(_:)), for: .touchUpInside)
        view.addSubview(arrow)
        
        
        scoreLabel.frame.size = CGSize( width: screenWidth, height: (115/1332)*screenHeight)
        scoreLabel.frame.origin.x = frontMargin + 35
        scoreLabel.frame.origin.y = (31/1332)*screenHeight
        scoreLabel.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*50)
        scoreLabel.text = "Scoreboard"
        if score > 0 {
            scoreLabel.text = scoreText
        }
        scoreLabel.textAlignment = .left
        scoreLabel.textColor = UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0)
        view.addSubview(scoreLabel)
        
        for i in 0...y {
            for j in 0...z {
                let tile = UILabel()
                tiles.append(tile)
                tile.frame.size = CGSize( width: tileWidth, height: tileHeight)
                
                    tile.frame.origin.x = frontMargin + CGFloat(i)*(tileWidth + margin)
                
                if UIDevice.current.userInterfaceIdiom != .pad && game == "wise" {
                    tile.frame.origin.x = frontMargin + CGFloat(i)*(tileWidth + margin)
                }
                tile.frame.origin.y = topMargin + CGFloat(j)*(tileHeight + margin)
                let point = CGPoint(x: tile.frame.origin.x, y: tile.frame.origin.y)
                pointArray.append(point)
                var maxx = CGFloat()
                var maxy = CGFloat()
                if i == y && j == z {
                    maxx = tile.frame.maxX + 10*screenWidth/750
                    maxy = tile.frame.maxY + 10*screenWidth/750
                    self.scrollView.contentSize = CGSize(width: maxx, height: maxy)
                }
                
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
                
                
                if game == "wise" || game == "farcical" || game == "foolish" {
                    tile.layer.cornerRadius = 2.0
                } else {
                    tile.layer.cornerRadius = 5.0
                }
                tile.clipsToBounds = true
                rectArray.append(tile.frame)
                self.view.addSubview(tile)
                
            }
        }
        
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            if game == "wise" || game == "sanity" || game == "sensible" {
                
                tileWidth -= tileWidth/2
                tileHeight  -= tileHeight/2
            }
        scoreLabel.frame.size = CGSize( width: screenWidth/3, height: tileWidth)
        scoreLabel.frame.origin.x = frontMargin + 1.25*tileWidth
        scoreLabel.frame.origin.y = 0
        scoreLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
            
            if game == "wise" || game == "farcical" || game == "foolish" {
                scoreLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 50)
                scoreLabel.frame.size = CGSize( width: screenWidth/2, height: tileWidth)
            }
            
            
            arrow.frame = CGRect(x: frontMargin + tileWidth/2, y: 0.29*topMargin, width: tileWidth/2, height: 37*tileWidth/88)
            
            var maxx = CGFloat()
            var maxy = CGFloat()
            let tile = tiles.last
                maxx = (tile?.frame.maxX)! + frontMargin
                maxy = (tile?.frame.maxY)! + frontMargin
                self.scrollView.contentSize = CGSize(width: maxx, height: maxy)
            
            if game == "wise" || game == "sanity" || game == "sensible" {
                
                tileWidth += tileWidth
                tileHeight  += tileHeight
            }
            
        }
    }
    
    
    
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
                        imageView.frame = CGRect(x: pointArray[n].x + gap, y: pointArray[n].y + gap, width: imageWidth, height: imageWidth)
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
                        guessNumber += 1
                        
                        if flipped1 != nil && flipped2 != nil {
                            if tiles[flipped1!].alpha == 0.0 && tiles[(flipped2!)].alpha == 0.0 {
                                flippedTiles = 2
                                
                                if (indexArray[flipped1!] == indexArray[flipped2!] - tileAmount/2) || (indexArray[flipped1!] == indexArray[flipped2!] + tileAmount/2) {
                                    done.append(flipped1!)
                                    done.append(flipped2!)
                                    var _score = 50000 - 2*time - 20*(guessNumber - 2*tileAmount)
                                    if _score < 500 {
                                        _score = 500
                                    }
                                    score += _score
                                    scoreLabel.text = scoreText
                                   // scoreLabel.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*70)
                                    flipped1 = nil
                                    flipped2 = nil
                                    
                                    imageViewArray[0]!.alpha = 0.2
                                    imageViewArray[1]!.alpha = 0.2
                                    imageViewArray[0] = nil
                                    imageViewArray[1] = nil
                                    flippedTiles = 0
                                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                                    if done.count >= tileAmount {
                                        saveScore()
                                        endGame()
                                    }
                                    
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
      
                            break outerLoop
                        }
                        tiles[flipped1!].alpha = 1.0
                        tiles[flipped2!].alpha = 1.0
                        imageViewArray[0]?.removeFromSuperview()
                        imageViewArray[1]?.removeFromSuperview()
                    }
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
                        imageView.frame = CGRect(x: pointArray[n].x + gap, y: pointArray[n].y + gap, width: imageWidth, height: imageWidth)
                        imageView.alpha = 1.0
                        view.addSubview(imageView)
                         guessNumber += 1
                        
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
                        
                        wordView.text = listOfWordsToUse[indexArray[n]]
                        
                        
                        wordView.frame = CGRect(x: pointArray[n].x - margin, y: pointArray[n].y, width: tileWidth + margin, height: tileHeight)
                        wordView.font = UIFont(name: "HelveticaNeue-Bold", size: 10)
                        wordView.alpha = 1.0
                        wordView.textAlignment = .center
                        wordView.textColor = UIColor.white
                        view.addSubview(wordView)
                         guessNumber += 1
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
                        
                        
                        if flipped1 != nil && flipped2 != nil {
       
                            if tiles[flipped1!].alpha == 0.0 && tiles[(flipped2!)].alpha == 0.0 {
                                flippedTiles = 2
                                
                                if (indexArray[flipped1!] == indexArray[flipped2!] - tileAmount/2) || (indexArray[flipped1!] == indexArray[flipped2!] + tileAmount/2) {
                                    done.append(flipped1!)
                                    done.append(flipped2!)
                                    var _score = 50000 - 2*time - 20*(guessNumber - 2*tileAmount)
                                    if _score < 500 {
                                        _score = 500
                                    }
                                    score += _score
                                    scoreLabel.text = scoreText
                                   // scoreLabel.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*70)
                                    flipped1 = nil
                                    flipped2 = nil
                                    
                                    wordLabelArray[0]!.alpha = 0.2
                                    wordLabelArray[1]!.alpha = 0.2
                                    wordLabelArray[0] = nil
                                    wordLabelArray[1] = nil
                                    flippedTiles = 0
                                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                                    if done.count >= tileAmount {
                                        saveScore()
                                        endGame()
                                    }
                                    
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
                            
                            break outerLoop
                        }
                        tiles[flipped1!].alpha = 1.0
                        tiles[flipped2!].alpha = 1.0
                        wordLabelArray[0]?.removeFromSuperview()
                        wordLabelArray[1]?.removeFromSuperview()
                    }
                    if rectArray[n].contains(centerPoint) {
                        if done.contains(n) {
                            
                            break outerLoop
                        }
                        tiles[n].alpha = 0.0
                        
                        let wordView = UILabel()
                        
                        wordView.text = listOfWordsToUse[indexArray[n]]
          
                        wordView.frame = CGRect(x: pointArray[n].x - margin, y: pointArray[n].y, width: tileWidth + margin, height: tileHeight)
                        wordView.font = UIFont(name: "HelveticaNeue-Bold", size: 10)
                        wordView.alpha = 1.0
                        wordView.textAlignment = .center
                        wordView.textColor = UIColor.white
                        view.addSubview(wordView)
                         guessNumber += 1
                        if binary {
                            wordLabelArray[0] = wordView
                            flipped1 = n
                            binary = false
                        } else {
                            wordLabelArray[1] = wordView
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
        
        if game == "sensible" || game == "ridiculous" || game == "idiotic" {
            switch flippedTiles {
            case 0, 1, 2:
                centerPoint = gesture.location(in: view)
                outerLoop: for n in 0..<tileAmount {
                    if rectArray[n].contains(centerPoint) {
                        if done.contains(n) {
                            break outerLoop
                        }
                        tiles[n].alpha = 0.0
                        var image = UIImage()
                        if indexArray[n] < tileAmount/3 {
                            image = UIImage(named: myItems.listOfImages[indexArray[n]])!
                        } else if indexArray[n] < 2*tileAmount/3 {
                            image = UIImage(named: myItems.listOfImages[indexArray[n] - tileAmount/3])!
                        } else {
                            image = UIImage(named: myItems.listOfImages[indexArray[n] - 2*tileAmount/3])!
                        }
                        let imageView = UIImageView(image: image)
                        imageView.frame = CGRect(x: pointArray[n].x + gap, y: pointArray[n].y + gap, width: imageWidth, height: imageWidth)
                        imageView.alpha = 1.0
                        
                        //                        if imageViewArray.count == 0 {
                        //                            imageViewArray.append(imageView)
                        //                            flipped1 = n
                        //                            triCount += 1
                        //                        } else if imageViewArray.count == 1 {
                        //                            imageViewArray.append(imageView)
                        //                            flipped2 = n
                        //                            triCount += 1
                        //                        } else if imageViewArray.count == 2 {
                        //                            imageViewArray.append(imageView)
                        //                            flipped3 = n
                        //                            triCount += 1
                        
                        if triCount%3 == 1 {
                            imageViewArray[0] = imageView
                            flipped1 = n
          
                            triCount += 1
                        } else if triCount%3 == 2 {
                            imageViewArray[1] = imageView
                            flipped2 = n
             
                            triCount += 1
                        } else if triCount%3 == 0 {
                            imageViewArray[2] = imageView
                            flipped3 = n
               
                            triCount += 1
                        }
                        
                        view.addSubview(imageView)
                         guessNumber += 1
                        
                        if flipped1 != nil && flipped2 != nil && flipped3 != nil {
                            var flips = [indexArray[flipped1!], indexArray[flipped2!],indexArray[flipped3!]]
     
                            flips = flips.sorted { $0 > $1 }
                  
                            if tiles[flipped1!].alpha == 0.0 && tiles[(flipped2!)].alpha == 0.0 {
                                flippedTiles = 2
                            }
                            if tiles[(flipped2!)].alpha == 0.0 && tiles[(flipped3!)].alpha == 0.0 {
                                flippedTiles = 2
                            }
                            if tiles[flipped1!].alpha == 0.0 && tiles[(flipped3!)].alpha == 0.0 {
                                flippedTiles = 2
                            }
                            if tiles[flipped1!].alpha == 0.0 && tiles[(flipped2!)].alpha == 0.0 && tiles[(flipped3!)].alpha == 0.0 {
                                flippedTiles = 3
            
                                if (flips[0] - 2*tileAmount/3 == flips[2]) && (flips[1] - tileAmount/3 == flips[2]) {
                                    done.append(flipped1!)
                                    done.append(flipped2!)
                                    done.append(flipped3!)
                                    var _score = 50000 - 2*time - 20*(guessNumber - 2*tileAmount)
                                    if _score < 500 {
                                        _score = 500
                                    }
                                    score += _score
                                    scoreLabel.text = scoreText
                                   // scoreLabel.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*70)
                                    flipped1 = nil
                                    flipped2 = nil
                                    flipped3 = nil
                                    
                                    imageViewArray[0]!.alpha = 0.2
                                    imageViewArray[1]!.alpha = 0.2
                                    imageViewArray[2]!.alpha = 0.2
                                    imageViewArray[0] = nil
                                    imageViewArray[1] = nil
                                    imageViewArray[2] = nil
                                    flippedTiles = 0
                                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                                    if done.count >= tileAmount {
                                        saveScore()
                                        endGame()
                                    }
                                    
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
                
            case 3:
                centerPoint = gesture.location(in: view)
                outerLoop: for n in 0..<tileAmount {
                    
                    if rectArray[n].contains(centerPoint) && flipped1 != nil && flipped2 != nil && flipped2 != nil {
                        if done.contains(n) {
                            
                            break outerLoop
                        }
                        tiles[flipped1!].alpha = 1.0
                        tiles[flipped2!].alpha = 1.0
                        tiles[flipped3!].alpha = 1.0
                        imageViewArray[0]?.removeFromSuperview()
                        imageViewArray[1]?.removeFromSuperview()
                        imageViewArray[2]?.removeFromSuperview()
                        flipped1 = nil
                        flipped2 = nil
                        flipped3 = nil
                    }
                    if rectArray[n].contains(centerPoint) {
                        if done.contains(n) {
                            
                            break outerLoop
                        }
                        tiles[n].alpha = 0.0
                        var image = UIImage()
                        if indexArray[n] < tileAmount/3 {
                            image = UIImage(named: myItems.listOfImages[indexArray[n]])!
                        } else if indexArray[n] < 2*tileAmount/3 {
                            image = UIImage(named: myItems.listOfImages[indexArray[n] - tileAmount/3])!
                        } else {
                            image = UIImage(named: myItems.listOfImages[indexArray[n] - 2*tileAmount/3])!
                        }
                        let imageView = UIImageView(image: image)
                        imageView.frame = CGRect(x: pointArray[n].x + gap, y: pointArray[n].y + gap, width: imageWidth, height: imageWidth)
                        imageView.alpha = 1.0
                        view.addSubview(imageView)
                         guessNumber += 1
                        if triCount%3 == 1 {
                            imageViewArray[0] = imageView
                            flipped1 = n
                    
                            triCount += 1
                        } else if triCount%3 == 2 {
                            imageViewArray[1] = imageView
                            flipped2 = n
                
                            triCount += 1
                        } else if triCount%3 == 0 {
                            imageViewArray[2] = imageView
                            flipped3 = n
               
                            triCount += 1
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
    
    private func selectItems() {
        var allNumbers = [Int]()
        var m: Int = 0

        if game == "sensible" || game == "sanity" {
            m = Int(arc4random_uniform(UInt32(175)))
        }
        if game == "ridiculous" || game == "absurd" {
            m = Int(arc4random_uniform(UInt32(100)))
        }
        if game == "sensible" || game == "ridiculous" || game == "idiotic" {
            for i in m..<(m+tileAmount/3) {
                allNumbers.append(i)
            }
     
            for _ in m..<(m+tileAmount/3) {
                
                let randomNumber = Int(arc4random_uniform(UInt32(allNumbers.count)))
           
                if let index = allNumbers.index(of: allNumbers[randomNumber]) {
     
                    listOfImagesToUse.append(myItems.listOfImages[allNumbers[randomNumber]])
                    allNumbers.remove(at: index)
                }
                
                
                
            }
            
            
        } else {
            
            for i in m..<(m+tileAmount/2) {
                allNumbers.append(i)
            }
            
            for _ in m..<(m+tileAmount/2) {
                
                let randomNumber = Int(arc4random_uniform(UInt32(allNumbers.count)))
                if let index = allNumbers.index(of: allNumbers[randomNumber]) {
                    listOfImagesToUse.append(myItems.listOfImages[allNumbers[randomNumber]])
                    allNumbers.remove(at: index)
                }
            }
        }
        if game == "wise" {
            for i in 0..<21 {
                listOfWordsToUse.append(myItems.listOfWords[i])
            }
            for i in 380..<401 {
                listOfWordsToUse.append(myItems.listOfWords[i])
            }
        }
        if game == "farcical" {
            
            for i in 0..<120 {
                listOfWordsToUse.append(myItems.listOfWords[i+21])
            }
            for i in 380..<500 {
                listOfWordsToUse.append(myItems.listOfWords[i+21])
            }
            
        }
        if game == "foolish" {
            
            for i in 0..<225 {
                listOfWordsToUse.append(myItems.listOfWords[i+141])
            }
            for i in 380..<605 {
                listOfWordsToUse.append(myItems.listOfWords[i+141])
            }
        }
    }
    
    private func organizeIndex() {
        var allNumbers = [Int]()
        for i in 0..<tileAmount {
            allNumbers.append(i)
        }
        
        for _ in 0..<tileAmount {
            
            let randomNumber = Int(arc4random_uniform(UInt32(allNumbers.count)))
            if let index = allNumbers.index(of: allNumbers[randomNumber]) {
                indexArray.append(allNumbers[randomNumber])
                allNumbers.remove(at: index)
            }
        }
        
    }
    
    @objc private func menu(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toMenuFromMatch", sender: self)
    }
    
    //coredata functions
    
    private func deleteAllData(entity: String)
    {
        let appDel = (UIApplication.shared.delegate as! AppDelegate)
        let context = appDel.persistentContainer.viewContext
        let ReqVar = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: ReqVar)
        do { try context.execute(DelAllReqVar) }
        catch { print(error) }
    }
    
    private func saveLevel() {
        var index = [Int]()
        var booleans = [Int]()
        var list = [String]()
        booleans = done
        for i in 0..<tileAmount {
            index.append(indexArray[i])
            if game == "wise" || game == "farcical" || game == "foolish" {
                list.append(listOfWordsToUse[i])
            } else if game == "sanity" || game == "absurd" || game == "insane" {
                if i < tileAmount/2 {
                    list.append(listOfImagesToUse[i])
                } else {
                    if i < tileAmount/3 {
                        list.append(listOfImagesToUse[i])
                    }
                }
            }
        }
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        if resultsGameRequest.count > 0 {
            deleteAllData(entity: gameData)
        }
        
        let entity = NSEntityDescription.insertNewObject(forEntityName: gameData, into: context)
        entity.setValue(index, forKey: "index")
        entity.setValue(booleans, forKey: "bool")
        entity.setValue(list, forKey: "list")
        entity.setValue(score, forKey: "score")
        entity.setValue(time, forKey: "time")
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    override func viewWillDisappear(_ animated: Bool) {

        saveLevel()
    }
    
    private func saveScore() {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        
        let entity = NSEntityDescription.insertNewObject(forEntityName: "HighScores", into: context)
        entity.setValue(score, forKey: game)
 
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    //coredata functions end
    
    private func endGame() {
        //display things when you win the game
    }
    
}



