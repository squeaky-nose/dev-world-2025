//
//  PreviewImageAnalysisService.swift
//  ImagesApp
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

#if DEBUG
final class PreviewImageAnalysisService: ImageAnalysisService {
    func analyseImage(imageUrl: String) async throws -> String {
        try? await Task.sleep(for: .seconds(1))

        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur sit amet justo urna. Vivamus finibus, nisi molestie dictum tempus, enim nisl sodales dui, sit amet fringilla lorem arcu eget nunc. Etiam dignissim vitae lorem nec finibus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nam consectetur suscipit tellus, quis rutrum nisl gravida eget. Suspendisse tincidunt bibendum nibh, id hendrerit leo efficitur sit amet. Sed at eros quam."
    }
}
#endif
