//
//  ViewController.swift
//  SpectaClone-iOS
//
//  Created by kimhyungyu on 2022/05/11.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
}

// MARK: - Extension

extension ViewController {
    private func setUI() {
        self.view.backgroundColor = .red
    }
}
