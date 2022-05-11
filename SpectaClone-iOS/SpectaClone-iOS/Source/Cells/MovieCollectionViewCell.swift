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
    
    
    // MARK: - View Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
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
        
    }
}
