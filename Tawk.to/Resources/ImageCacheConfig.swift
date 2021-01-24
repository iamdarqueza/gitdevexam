//
//  ImageCacheConfig.swift
//  Tawk.to
//
//  Created by Danmark Arqueza on 1/22/21.
//

import Foundation

struct ImageCacheConfig {
    let countLimit: Int
    let memoryLimit: Int

    static let defaultConfig = ImageCacheConfig(countLimit: 100, memoryLimit: 1024 * 1024 * 100) // 100 MB
}
