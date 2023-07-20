//
//  PokeDetailScreen.swift
//  KnowThemAll
//
//  Created by Данік on 11/07/2023.
//

import Foundation
import UIKit
import SnapKit

@IBDesignable
class PokeDetailView: UIView {
    
    
    let backArrow = UIButton().apply {
        $0.setImage(UIImage(named: "backArrow"), for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
    let pokeName = UILabel().apply {
        $0.font = UIFont(name: "Lato-Bold", size: 24)
        $0.textColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let pokeImage = UIImageView().apply {
        $0.backgroundColor = .clear
    }
    
    
    let segmentedControl = CustomSegmentedControl().apply {
        $0.setButtonTitles(buttonTitles: ["About", "Stats", "Evolution", "Moves" ])
    }
    
    
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withName name: String, withUrl url: String) {
        self.backgroundColor = .white
        pokeName.text = name
        pokeImage.sd_setImage(with: URL(string: url), completed: nil)
        setupView()
    }
    
    private func setupView() {
        addSubview(backArrow)
        addSubview(pokeName)
        addSubview(pokeImage)
        addSubview(segmentedControl)
        
        
        // make the descriptionLabel text capitalized
        pokeName.text = pokeName.text?.capitalized
        
        backArrow.snp.makeConstraints { make in
            make.width.height.equalTo(15)
            make.top.equalToSuperview().offset(65)
            make.left.equalToSuperview().offset(24)
        }
        
        pokeName.snp.makeConstraints { make in
            make.top.equalTo(backArrow.snp.bottom).offset(60)
            make.left.equalToSuperview().offset(24)
        }
        
        pokeImage.snp.makeConstraints { make in
            make.top.equalTo(pokeName.snp.bottom).offset(70)
            make.centerX.equalToSuperview()
            make.height.equalTo(self.frame.size.height / 6)
            make.width.equalTo(self.frame.size.width / 3)
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(pokeImage.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
    }
    
    
    
}
