//
//  ViewController.swift
//  SpectaClone-iOS
//
//  Created by kimhyungyu on 2022/05/11.
//

import UIKit

import Then

class ViewController: UIViewController {

    // MARK: - Properties
    
    private let titleLabel = UILabel().then {
        $0.text = "Movie Open API"
        $0.font = .systemFont(ofSize: 20)
    }
    
    private let collectionViewFlowlayout = UICollectionViewFlowLayout().then {
        $0.minimumLineSpacing = 10
        $0.minimumInteritemSpacing = 10
        $0.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        $0.scrollDirection = .vertical
    }
    
    private lazy var movieCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowlayout).then {
        $0.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCollectionViewCell")
    }
    
    private var movies: [Result] = []
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
        setLayout()
        
        Task {
            do {
                movies = try await getMovie()
                await MainActor.run {
                    movieCollectionView.reloadData()
                }
            } catch DataDownloadError.invalidURLString {
                print("movie error - invalidURLString")
            } catch DataDownloadError.invalidServerResponse {
                print("movie error - invalidServerResponse")
            } catch NetworkError.decodeError(let type) {
                print("network error - decodeError : \(type)")
            } catch NetworkError.requestError(let statusCode) {
                print("network error - requestError : \(statusCode)")
            } catch NetworkError.serverError(let statusCode) {
                print("network error - serverError : \(statusCode)")
            } catch NetworkError.networkFailError(let statusCode) {
                print("network error - networkFailError : \(statusCode)")
            }
        }
    }
}

// MARK: - Extension

extension ViewController {
    private func setUI() {
        self.view.backgroundColor = .white
    }
    
    private func setDelegate() {
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
    }
    
    // MARK: - Network
    
    private func getMovie() async throws -> [Result] {
        let popularMovie = try await NetworkAPI.shared.fetchPopularMovies()
        return popularMovie.results
    }
}

// MARK: - UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate { }

// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        
        cell.initCellWith(urlPath: movies[indexPath.item].posterPath, title: movies[indexPath.item].originalTitle)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = (collectionView.frame.width / 2) - 10
        let cellHeight: CGFloat = cellWidth + 30
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

// MARK: - Layout

extension ViewController {
    private func setLayout() {
        self.view.addSubviews([titleLabel, movieCollectionView])
        
        let titleLabelConstraints: [NSLayoutConstraint] = [
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20.0)]
        NSLayoutConstraint.activate(titleLabelConstraints)
        
        let movieCollectionViewConstraints: [NSLayoutConstraint] = [
            movieCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            movieCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            movieCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            movieCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
        ]
        NSLayoutConstraint.activate(movieCollectionViewConstraints)
    }
}
