//
//  HeaderView.swift
//  KnowThemAll
//
//  Created by Данік on 11/07/2023.
//

import Foundation
import UIKit
import SnapKit

class HeaderView: UICollectionReusableView {
    
    static let identifier = "HeaderView"
    
    private let headerLabel = UILabel().apply {
        $0.text = "Know Them All"
        $0.font = UIFont(name: "Lato-Bold", size: 24)
        $0.textColor = UIColor(red: 0.14, green: 0.12, blue: 0.13, alpha: 1)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
