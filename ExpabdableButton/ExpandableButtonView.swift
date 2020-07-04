//
//  ExpandableButtonView.swift
//  ExpabdableButton
//
//  Created by Yuwen Chiu on 2020/7/4.
//  Copyright © 2020 YuwenChiu. All rights reserved.
//

import UIKit

protocol ExpandableButtonViewDelegate: class {
    
    func doSomethingBy(title: String)
}

class ExpandableButtonView: UIView {
    
    weak var delegate: ExpandableButtonViewDelegate?

    let screenSize = UIScreen.main.bounds
    let shadowView = UIView()
    let controlButton = UIButton()
    var toolButtonList = [UIButton]()
    var isExpanded: Bool = false
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        let view = super.hitTest(point, with: event)
        return view == self ? nil : view
    }
    
    func setupShadowView() {
        
        shadowView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        shadowView.backgroundColor = .lightGray
        shadowView.alpha = 0
        
        let ges = UITapGestureRecognizer(target: self, action: #selector(onTouchControlButton))
        shadowView.isUserInteractionEnabled = true
        shadowView.addGestureRecognizer(ges)
        
        addSubview(shadowView)
    }
    
    func setupButtons(buttonTitles: [String]) {
        
        for index in 0 ..< buttonTitles.count {
            
            let toolButton = UIButton()
            
            toolButton.alpha = 0
            toolButton.frame = CGRect(x: Int(screenSize.width) - 70, y: Int(screenSize.height) - 100, width: 45, height: 45)
            toolButton.tag = index + 1
            toolButton.titleLabel?.font = UIFont(name: "PingFangTC-Semibold", size: 13)
            toolButton.setTitle(buttonTitles[index], for: .normal)
            toolButton.setTitleColor(.white, for: .normal)
            toolButton.layer.backgroundColor = UIColor.systemYellow.cgColor
            toolButton.addTarget(self, action: #selector(onTouchActionButton(button:)), for: .touchUpInside)
            setButtonStyle(button: toolButton)
            toolButtonList.append(toolButton)
            addSubview(toolButton)
        }
        
        controlButton.frame = CGRect(x: Int(screenSize.width) - 75, y: Int(screenSize.height) - 100, width: 55, height: 55)
        controlButton.tag = 0
        controlButton.titleLabel?.font = UIFont(name: "PingFangTC-Medium", size: 15)
        controlButton.setTitle("More", for: .normal)
        controlButton.setTitleColor(.white, for: .normal)
        controlButton.layer.backgroundColor = UIColor.systemYellow.cgColor
        controlButton.addTarget(self, action: #selector(onTouchControlButton), for: .touchUpInside)
        setButtonStyle(button: controlButton)
        addSubview(controlButton)
    }
    
    @objc func onTouchControlButton() {
        
        isExpanded.toggle()
        
        shadowView.alpha = isExpanded ? 0.5 : 0
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.toolButtonList.forEach {
                $0.frame = CGRect(x: Int(self.screenSize.width) - 70,
                                  y: Int(self.screenSize.height) - 100 - 55 * (self.isExpanded ? $0.tag : 0),
                                  width: 45, height: 45)
                $0.alpha = self.isExpanded ? 1 : 0
            }
        })
        
        controlButton.setTitle(isExpanded ? "Close" : "More", for: .normal)
        controlButton.setTitleColor(isExpanded ? .systemYellow : .white, for: .normal)
        controlButton.layer.backgroundColor = isExpanded ? UIColor.white.cgColor : UIColor.systemYellow.cgColor
    }
    
    @objc func onTouchActionButton(button: UIButton) {
        
        onTouchControlButton()
        delegate?.doSomethingBy(title: button.titleLabel?.text ?? "")
    }
    
    func setButtonStyle(button: UIButton) {
        
        button.layer.cornerRadius = button.bounds.width / 2
        button.layer.shadowRadius = 2
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
    }
}
