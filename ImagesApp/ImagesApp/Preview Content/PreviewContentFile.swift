//
//  PreviewContentFile.swift
//  PexelsPhotos
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

import Foundation

struct PreviewContentFile {
    let name: String
    let fileExtension: String

    static let curatedNetworkResponse = PreviewContentFile(name: "curatedNetworkResponse", fileExtension: "json")
    static let searchForPhoto = PreviewContentFile(name: "searchForPhoto", fileExtension: "json")
    static let searchForPhotoMaldives = PreviewContentFile(name: "searchForPhoto-maldives", fileExtension: "json")

    var url: URL {
        guard let url = Bundle.main.url(forResource: name,
                                        withExtension: fileExtension) else {
            fatalError("Could not find \(name).\(fileExtension)")
        }
        return url
    }
}
