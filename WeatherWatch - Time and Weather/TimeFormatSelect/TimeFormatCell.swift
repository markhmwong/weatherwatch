//
//  TimeFormatCell.swift
//  WeatherWatch - Time and Weather
//
//  Created by Mark Wong on 11/6/2023.
//

import UIKit

class TimeFormatCell: UICollectionViewCell {
    
    let checkmarkImageView: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "checkmark"))
            imageView.tintColor = .systemBlue
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = isSelected ? .systemGray5 : .white
            optionLabel.textColor = isSelected ? .systemBlue : .black
            sampleLabel.textColor = isSelected ? .systemBlue : .black
            checkmarkImageView.isHidden = !isSelected
        }
    }
    
    let optionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    let sampleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.layer.cornerRadius = 5.0
        contentView.addSubview(optionLabel)
        contentView.addSubview(sampleLabel)
        contentView.addSubview(checkmarkImageView)
        
        optionLabel.translatesAutoresizingMaskIntoConstraints = false
        sampleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            optionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            optionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            optionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            sampleLabel.topAnchor.constraint(equalTo: optionLabel.bottomAnchor, constant: 10),
            sampleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            sampleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            checkmarkImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            checkmarkImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 20),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
