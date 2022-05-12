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
    
    private lazy var movieCollectionView = UICollectionView(frame: .init(x: 100, y: 100, width: 200, height: 600), collectionViewLayout: collectionViewFlowlayout).then {
        $0.backgroundColor = .gray
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
                guard let url = URL(string: Const.URL.baseURL + Const.Endpoint.popular + Const.Key.key) else {
                    throw MovieDownloadError.invalidURLString
                }
                movies = try await getMovie(url: url)
                movieCollectionView.reloadData()
            } catch MovieDownloadError.invalidURLString {
                print("movie error - invalidURLString")
            } catch MovieDownloadError.invalidServerResponse {
                print("movie error - invalidServerResponse")
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
    
    private func getMovie(url: URL) async throws -> [Result] {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw MovieDownloadError.invalidServerResponse
        }
        let popularMovie = try JSONDecoder().decode(PopularMovie.self, from: data)
        
        return popularMovie.results
    }
}

// MARK: - UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate { }

// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // TODO: - 서버에서 전달받은 movie 갯수 리턴.
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        
        cell.initCellWith(url: movies[indexPath.item].posterPath, title: movies[indexPath.item].originalTitle)
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
        
        guard let superview = self.view.superview else { return }
        let movieCollectionViewConstraints: [NSLayoutConstraint] = [
            movieCollectionView.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            movieCollectionView.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            movieCollectionView.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            movieCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
        ]
        NSLayoutConstraint.activate(movieCollectionViewConstraints)
    }
}
