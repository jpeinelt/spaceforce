//
//  ViewController.swift
//  SpaceForce
//
//  Created by Julius Peinelt on 29.08.18.
//  Copyright © 2018 Julius Peinelt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var attempts = 0
    var hitCount = 0
    var isTargetHit = false
    let ship = UIButton()
    let enemy = UIImageView(image: UIImage(named: "enemyShip")!)
    var lasers = [UIImageView]()
    let attemptsLabel = UILabel()
    let hitLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .black

        attemptsLabel.text = "Attempts: \(attempts)"
        attemptsLabel.textColor = .white
        attemptsLabel.frame = CGRect(x: 110, y: 30, width: 100, height: 20)

        hitLabel.text = "Hits: \(hitCount)"
        hitLabel.textColor = .white

        hitLabel.frame = CGRect(x: 340, y: 30, width: 100, height: 20)

        ship.setImage(UIImage(named: "playerShip"), for: .normal)
        ship.frame = CGRect(x: 200, y: 620, width: 30, height: 30)
        ship.addTarget(self, action: #selector(shoot(sender:)), for: UIControlEvents.touchUpInside)

        enemy.frame = CGRect(x: 30, y: 80, width: 30, height: 30)

        self.view.addSubview(attemptsLabel)
        self.view.addSubview(hitLabel)
        self.view.addSubview(ship)
        self.view.addSubview(enemy)
    }

    @IBAction func shoot(sender: UIButton) {
        let laserAsset = UIImage(named: "laser")!
        let laser = UIImageView(image: laserAsset)
        laser.frame = CGRect(x: 200, y: 620, width: 7, height: 30)

        let animation = CABasicAnimation()
//        animation.delegate = self
        animation.keyPath = "position"
        animation.fromValue = [215, 680]
        animation.toValue = [315, 30]

        lasers.append(laser)
        self.view.addSubview(laser)
        laser.layer.add(animation, forKey: "position")

    }
}

extension ViewController: CAAnimationDelegate {

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        // TODO: isTargetHit never possible right now
        if isTargetHit {
            hitCount += 1
        } else {
            attempts += 1
        }

        attemptsLabel.text = "Attempts: \(attempts)"
        hitLabel.text = "Hits: \(hitCount)"

        let laser = lasers.last
        laser?.removeFromSuperview()
        lasers.removeLast()
    }
}
