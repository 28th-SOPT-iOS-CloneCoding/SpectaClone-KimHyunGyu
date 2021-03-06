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
        $0.contentMode = .scaleAspectFit
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20)
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
        posterImageView.image = UIImage()
        titleLabel.text = ""
    }
}

// MARK: - Extensions

extension MovieCollectionViewCell {
    private func setUI() {
    }
    
    func initCellWith(urlPath: String, title: String) {
        Task {
            do {
                let posterImage = try await ImageDownloader.shared.image(from: urlPath)
                await MainActor.run {
                    posterImageView.image = posterImage
                    titleLabel.text = title
                }
            } catch ImageDownloadError.unsupportImage {
                print("image download error - unsupportImage")
            } catch ImageDownloadError.invalidServerResponse {
                print("image download error - invalidServerResponse")
            } catch ImageDownloadError.invalidURLString(let urlPath) {
                print("image download error - invalidURLString: \(urlPath)")
            }
        }
    }
}

// MARK: - Layout

extension MovieCollectionViewCell {
    private func setLayout() {
        self.addSubviews([posterImageView, titleLabel])

        let posterImageViewConstraints: [NSLayoutConstraint] = [
            posterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            posterImageView.topAnchor.constraint(equalTo: self.topAnchor),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 1.0)
        ]
        NSLayoutConstraint.activate(posterImageViewConstraints)
        
        let titleLabelConstraints: [NSLayoutConstraint] = [
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 5.0)
        ]
        NSLayoutConstraint.activate(titleLabelConstraints)
    }
}
