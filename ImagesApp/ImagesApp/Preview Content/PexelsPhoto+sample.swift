//
//  PexelsPhoto+sample.swift
//  ImagesApp
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//


#if DEBUG
extension PexelsPhoto {
    static var sample: PexelsPhoto {
        .init(
            id: 3573351,
            width: 3066,
            height: 3968,
            alt: "Brown Rocks During Golden Hour",
            photographer: "Lukas Rodriguez",
            src: .init(original: "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png",
                    large: "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&h=650&w=940",
                    medium: "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&h=350",
                    small: "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&h=130")
            )
    }
}
#endif
