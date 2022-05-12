//
//  MovieCollectionViewCell.swift
//  SpectaClone-iOS
//
//  Created by kimhyungyu on 2022/05/11.
//

import UIKit

import Then

class MovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let posterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = UIImage(systemName: "circle")
    }
    
    private let titleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .boldSystemFont(ofSize: 16)
    }
    
    // MARK: - View Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
    
    }
}

// MARK: - Extensions

extension MovieCollectionViewCell {
    private func setUI() {
        self.backgroundColor = .black
    }
    
    func initCellWith(url: String, title: String) {
        if let url = URL(string: Const.URL.imageUrl + url) {
            // TODO: - 이미지 다운로드.
        }
        
        titleLabel.text = title
    }
}

// MARK: - Layout

extension MovieCollectionViewCell {
    private func setLayout() {
        self.addSubviews([posterImageView, titleLabel])
    
        guard let superview = self.superview else { return }
        let posterImageViewConstraints: [NSLayoutConstraint] = [
            posterImageView.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            posterImageView.topAnchor.constraint(equalTo: superview.topAnchor),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 1.0)
        ]
        NSLayoutConstraint.activate(posterImageViewConstraints)
        
        let titleLabelConstraints: [NSLayoutConstraint] = [
            titleLabel.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10.0)]
        NSLayoutConstraint.activate(titleLabelConstraints)
    }
}
