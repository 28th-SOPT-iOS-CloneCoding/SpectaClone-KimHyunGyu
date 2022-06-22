//
//  UIImage+.swift
//  SpectaClone-iOS
//
//  Created by kimhyungyu on 2022/06/22.
//

import UIKit

extension UIImage {
    var thumbnail: UIImage? {
        get async {
            let size = CGSize(width: 100, height: 140)
            return await self.byPreparingThumbnail(ofSize: size)
        }
    }
}
