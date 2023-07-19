//
//  PokeDetailScreen.swift
//  KnowThemAll
//
//  Created by Данік on 11/07/2023.
//

import Foundation
import UIKit
import SnapKit

class PokeDetailView: UIView {
    
    let backArrow = UIImageView().apply {
        $0.image = UIImage(named: "backArrow")
    }
    
    let pokeName = UILabel().apply {
        $0.font = UIFont(name: "Lato-Bold", size: 24)
        $0.textColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let pokeImage = UIImageView().apply {
        $0.backgroundColor = .clear
    }
    
    let segmentedControl = UISegmentedControl(items: ["About", "Stats", "Evolution", "Moves" ]).apply {
        $0.selectedSegmentIndex = 0
        $0.backgroundColor = .systemBackground
        $0.selectedSegmentTintColor = .systemBlue
        $0.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        $0.setTitleTextAttributes([.foregroundColor: UIColor.systemBlue], for: .normal)
    }
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(backArrow)
        addSubview(pokeName)
        addSubview(pokeImage)
        addSubview(segmentedControl)
        
        backArrow.snp.makeConstraints { make in
            make.width.height.equalTo(15)
            make.top.equalToSuperview().offset(65)
            make.left.equalToSuperview().offset(24)
        }
        
        pokeName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(135)
            make.left.equalToSuperview().offset(24)
        }
        
        pokeImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(204)
            make.centerX.equalToSuperview()
            
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.left.right.equalToSuperview().offset(24)
        }
    }
    
    
    
}
