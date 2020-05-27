//
//  PlanterControllerTableViewController.swift
//  SmartPlanter
//
//  Created by Harri on 5/26/20.
//  Copyright © 2020 Harri. All rights reserved.
//

import UIKit
import SocketIO

class PlanterControllerTableViewController: UIViewController {
    
    let manager = SocketManager(socketURL: URL(string: "http://192.168.137.49:8000")!, config: [.log(true), .compress])
    
    var socket: SocketIOClient!
    
    var leftTimer: Timer!
    var rightTimer: Timer!
    var upTimer: Timer!
    var downTimer: Timer!

    var speedAmmo = 20
    
    var inter = false
    
    var rightButton: UIButton = {
        var button = UIButton()
        let image = UIImage.init(systemName: "play.fill")
        image?.withTintColor(.yellow)
        button.setImage(image, for: .normal)
        button.tintColor = UIColor(red: 50/255, green: 168/255, blue: 81/255, alpha: 1)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(didClickRight), for: [.touchUpInside, .touchUpOutside])
        button.addTarget(self, action: #selector(rightDown), for: .touchDown)
    
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return button
    }()
    
    var leftButton: UIButton = {
        var button = UIButton()
        let image = UIImage.init(systemName: "play.fill")
        image?.withTintColor(.yellow)
        button.tintColor = UIColor(red: 50/255, green: 168/255, blue: 81/255, alpha: 1)
        button.setImage(image, for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(didClickLeft), for: [.touchUpInside, .touchUpOutside])
        button.addTarget(self, action: #selector(leftDown), for: .touchDown)
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.transform = button.transform.rotated(by: .pi)
        return button
    }()
    
    var topButton: UIButton = {
        var button = UIButton()
        let image = UIImage.init(systemName: "play.fill")
        button.tintColor = UIColor(red: 50/255, green: 168/255, blue: 81/255, alpha: 1)
        image?.withTintColor(.yellow)
        button.setImage(image, for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(didClickTop), for: [.touchUpInside, .touchUpOutside])
          button.addTarget(self, action: #selector(upDown), for: .touchDown)
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.transform = button.transform.rotated(by: -.pi/2)
        return button
    }()
    
    var bottomButton: UIButton = {
        var button = UIButton()
        let image = UIImage.init(systemName: "play.fill")
        button.tintColor = UIColor(red: 50/255, green: 168/255, blue: 81/255, alpha: 1)
        button.setImage(image, for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(didClickBottom), for: [.touchUpInside, .touchUpOutside])
         button.addTarget(self, action: #selector(downDown), for: .touchDown)
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.transform = button.transform.rotated(by: .pi/2)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Remote Controller"
        initalizeButtons()
        connectSocket()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.socket.connect()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        socket.disconnect()
    }
    
    func initalizeButtons() {
        self.view.addSubview(rightButton)
        self.view.addSubview(leftButton)
        self.view.addSubview(topButton)
        self.view.addSubview(bottomButton)
        
        self.rightButton.translatesAutoresizingMaskIntoConstraints = false
        self.leftButton.translatesAutoresizingMaskIntoConstraints = false
        self.topButton.translatesAutoresizingMaskIntoConstraints = false
        self.bottomButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.rightButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15).isActive = true
        self.rightButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.rightButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.rightButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.leftButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15).isActive = true
        self.leftButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.leftButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.leftButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.topButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        self.topButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.topButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.topButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.bottomButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
        self.bottomButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.bottomButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.bottomButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func connectSocket() {
        self.socket = self.manager.defaultSocket
        self.socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
    }

    @objc func rightDown() {
        rightTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(rightFire), userInfo: nil, repeats: true)

       // while(inter) {
           // DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                // self.socket.emit("right","hi")
          //  }
      //  }
     }
    
    @objc func rightFire() {
        self.socket.emit("right","hi")
    }

    func moveRight() {
        //self.socket.emit("right","hi")
        //print("release")
        rightTimer.invalidate()
    }
    
    @objc func leftDown() {
          leftTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(leftFire), userInfo: nil, repeats: true)
    }
    
   @objc func leftFire() {
         self.socket.emit("left","hi")
    }
    
    func moveLeft() {
        leftTimer.invalidate()
    }
    
    @objc func upDown() {
            upTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(upFire), userInfo: nil, repeats: true)
    }
    
    @objc func upFire() {
        self.socket.emit("forward","hi")
    }
    
    func moveUp() {

        upTimer.invalidate()
    }
    
    @objc func downDown() {
        downTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(downFire), userInfo: nil, repeats: true)
    }
    
    @objc func downFire() {
        self.socket.emit("backward","hi")
    }
    
    func moveDown() {
        self.downTimer.invalidate()
    }
    
    @objc func didClickRight() {
        moveRight()
    }
    
    @objc func didClickLeft() {
       moveLeft()
    }
    
    @objc func didClickTop() {
        moveUp()
    }
    
    @objc func didClickBottom() {
       moveDown()
    }
}
