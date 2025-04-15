//
//  OnboardingCollectionViewCell.swift
//  NewsApp-main
//
//  Created by Rajesh Gunasekar on 26/03/25.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    static let identifier = "OnboardingCollectionViewCell"
    
    private let onboardingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let onboardingTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 28.0, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let onboardingDescription: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnboardingCollectionViewCell {
    private func setupUI() {
        contentView.addSubview(onboardingImage)
        contentView.addSubview(onboardingTitle)
        contentView.addSubview(onboardingDescription)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // onboardingImage
            onboardingImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            onboardingImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            onboardingImage.widthAnchor.constraint(equalToConstant: 250),
            onboardingImage.heightAnchor.constraint(equalToConstant: 250),
            
            // onboardingTitle
            onboardingTitle.topAnchor.constraint(equalTo: onboardingImage.bottomAnchor, constant: 20),
            onboardingTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            onboardingTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // onboardingDescription
            onboardingDescription.topAnchor.constraint(equalTo: onboardingTitle.bottomAnchor, constant: 20),
            onboardingDescription.leadingAnchor.constraint(equalTo: onboardingTitle.leadingAnchor),
            onboardingDescription.trailingAnchor.constraint(equalTo: onboardingTitle.trailingAnchor)
        ])
    }
    
    func configure(with model: OnboardingSlider) {
        onboardingImage.image = UIImage(named: model.image)
        onboardingTitle.text = model.title
        onboardingDescription.text = model.description
    }
}
