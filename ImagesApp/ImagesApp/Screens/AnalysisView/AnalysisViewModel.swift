//
//  AnalysisViewModel.swift
//  ImagesApp
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

import Foundation

class AnalysisViewModel: ObservableObject {

    let coordinator: Coordinator
    let image: PexelsPhoto

    private let imageAnalysisService: ImageAnalysisService

    @Published var analysis: String? = nil
    @Published var titleText: LocalizedStringResource = "analysis.title"
    @Published var closeText: LocalizedStringResource = "analysis.close"
    @Published var loadingText: LocalizedStringResource = "analysis.loading.text"
    @Published var analysingText: LocalizedStringResource = "analysis.analysing.text"

    var imageURL: URL {
        URL(string: image.src.large)!
    }

    init(_ coordinator: Coordinator, image: PexelsPhoto) {
        self.coordinator = coordinator
        self.image = image

        imageAnalysisService = coordinator.resolver.resolve()
    }

    @MainActor
    func startAnalysis() async {
        do {
            analysis = try await imageAnalysisService.analyseImage(imageUrl: image.src.original)
        } catch {
            analysis = LocalizedStringResource("analysis.analysing.error").string
        }
    }

    func dismiss() {
        coordinator.dismissModal()
    }
}
