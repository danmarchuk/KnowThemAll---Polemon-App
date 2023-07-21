//
//  CustomSegmentedControl.swift
//  KnowThemAll
//
//  Created by Данік on 19/07/2023.
//

import Foundation
import UIKit
import SnapKit

protocol CustomSegmentedControlDelegate: AnyObject {
    func change(to index: Int)
}

final class CustomSegmentedControl: UIView {
    private var buttonTitles: [String]!
    private var buttons: [UIButton]!
    private var selectorView: UIView!
    private var grayLineView: UIView!

    var textColor: UIColor = .black
    var selectorViewColor: UIColor = .red
    var selectorTextColor: UIColor = .red

    weak var delegate: CustomSegmentedControlDelegate?

    public private(set) var selectedIndex: Int = 0

    convenience init(frame: CGRect, buttonTitle: [String]) {
        self.init(frame: frame)
        self.buttonTitles = buttonTitle
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor = UIColor.white
        updateView()
    }

    func setButtonTitles(buttonTitles: [String]) {
        self.buttonTitles = buttonTitles
        self.updateView()
    }

    func setIndex(index: Int) {
        buttons.forEach({ $0.setTitleColor(textColor, for: .normal) })
        let button = buttons[index]
        selectedIndex = index
        button.setTitleColor(selectorTextColor, for: .normal)
        button.titleLabel?.font = UIFont(name: "Lato-Regular", size: 11)
        let selectorPosition = (frame.width - 5) / CGFloat(buttonTitles.count) * CGFloat(index) + 5
        UIView.animate(withDuration: 0.2) {
            self.selectorView.frame.origin.x = selectorPosition
        }
    }

    @objc func buttonAction(sender: UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            if btn == sender {
                let selectorPosition = (frame.width - 5) / CGFloat(buttonTitles.count) * CGFloat(buttonIndex) + 5
                selectedIndex = buttonIndex
                delegate?.change(to: selectedIndex)
                UIView.animate(withDuration: 0.3) {
                    self.selectorView.frame.origin.x = selectorPosition
                }
                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
    }
}

// Configuration View
extension CustomSegmentedControl {
    private func updateView() {
        createButton()
        configGrayLineView()
        configSelectorView()
        configStackView()
    }

    private func configGrayLineView() {
        grayLineView = UIView()
        grayLineView.backgroundColor = UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1)
        addSubview(grayLineView)
        grayLineView.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.width.equalTo(self)
            make.bottom.equalTo(self)
        }
    }

    private func configSelectorView() {
        let selectorWidth = frame.width / CGFloat(self.buttonTitles.count) - 10
        selectorView = UIView()
        selectorView.backgroundColor = selectorViewColor
        addSubview(selectorView)
        selectorView.snp.makeConstraints { (make) in
            make.width.equalTo(selectorWidth)
            make.height.equalTo(1)
            make.bottom.equalTo(self)
            make.left.equalTo(self).offset(5)
        }
    }

    private func configStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }

    private func createButton() {
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.addTarget(self, action: #selector(CustomSegmentedControl.buttonAction(sender:)), for: .touchUpInside)
            button.setTitleColor(textColor, for: .normal)
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
    }
}
