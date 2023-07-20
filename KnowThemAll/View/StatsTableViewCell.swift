//
//  StatsTableViewCell.swift
//  KnowThemAll
//
//  Created by Данік on 20/07/2023.
//

import Foundation
import UIKit
import SnapKit

final class StatsTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "StatsTableViewCell"
    
    private let statLabel = UILabel().apply {
        $0.font = UIFont(name: "Lato", size: 11)
        $0.textColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let valueLabel = UILabel().apply {
        $0.font = UIFont(name: "Lato", size: 11)
        $0.textColor = UIColor(red: 0.31, green: 0.33, blue: 0.36, alpha: 1.0)
        $0.textAlignment = .right
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func configure(withStat stat: String, withValue value: String) {
        statLabel.text = stat
        valueLabel.text = value
        setupViews()
    }
    
    private func setupViews() {
        contentView.addSubview(statLabel)
        contentView.addSubview(valueLabel)
        
        // Constraints using SnapKit
        statLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(8)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(125)
            make.top.equalTo(statLabel.snp.top)
        }
    }
}
