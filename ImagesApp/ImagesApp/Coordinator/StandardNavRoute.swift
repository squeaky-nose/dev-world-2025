//
//  StandardNavRoute.swift
//  ImagesApp
//
//  Created by Sushant Verma on 6/8/2025.
//

import Foundation

enum StandardNavRoute: Hashable, Identifiable {
    var id: String { String(describing: self) }

    case search
    case results(searchPhrase: String)
    case curated
    case saved
    case detail(photo: PexelsPhoto)

    case placeholder
}
