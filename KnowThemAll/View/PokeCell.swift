//
//  PokeCell.swift
//  KnowThemAll
//
//  Created by Данік on 10/07/2023.
//

import UIKit
import SnapKit
import SDWebImage


class PokeCell: UICollectionViewCell {
    static let identifier = "PokeCell"

    private let nameLabel = UILabel().apply {
        $0.font = UIFont(name: "Lato-Bold", size: 13)
        $0.textColor = .red
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private let descriptionLabel = UILabel().apply {
        $0.textAlignment = .left
        $0.font = UIFont(name: "Lato-Regular", size: 11)
        $0.textColor = UIColor(red: 0.31, green: 0.33, blue: 0.36, alpha: 1)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private let imageView = UIImageView().apply {
        $0.image = UIImage(named: "")
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    func configure(withName name: String, withDescription description: String, withUrl url: String) {
        nameLabel.text = name
        descriptionLabel.text = description
        imageView.sd_setImage(with: URL(string: url), completed: nil)
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.15
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 2

        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(descriptionLabel)

        
        // make the nameLabel text uppercased
        nameLabel.text = nameLabel.text?.uppercased()
        // make the descriptionLabel text capitalized
        descriptionLabel.text = descriptionLabel.text?.capitalized
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.left.equalToSuperview().offset(9)
            make.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(54)
            make.left.equalToSuperview().offset(9)
        }
        
        imageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalToSuperview().dividedBy(1.5)
            make.height.equalToSuperview().dividedBy(1.5)
        }
    }
}
