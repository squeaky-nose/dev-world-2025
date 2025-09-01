//
//  AnalysisViewModelTests.swift
//  ImagesApp
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

@testable import ImagesApp
import Testing
import Foundation

struct AnalysisViewModelTests {

    let dependencyResolver: DependencyResolver
    let coordinator: Coordinator
    let viewModel: AnalysisViewModel

    let mockImageLoader: MockImageAnalysisService

    let testPhoto = PexelsPhoto(id: 42,
                                width: 4,
                                height: 2,
                                alt: "unit test saved",
                                photographer: "/dev/world 2025",
                                src: .init(
                                    original: "http://localhost/original.png",
                                    large: "http://localhost/large.png",
                                    medium: "http://localhost/medium.png",
                                    small: "http://localhost/small.png"))

    init() {
        self.dependencyResolver = DependencyResolver.createEmpty()

        let mockImageAnalysisService = MockImageAnalysisService()
        self.mockImageLoader = mockImageAnalysisService
        dependencyResolver.register(ImageAnalysisService.self, resolved: .perResolution) { _ in
            mockImageAnalysisService
        }

        self.coordinator = Coordinator(inParent: nil, di: dependencyResolver)
        self.viewModel = .init(coordinator, image: testPhoto)
    }

    @Test func titleText() async throws {
        #expect(viewModel.titleText == "analysis.title")
        #expect(viewModel.titleText.string == "Analysis")
    }

    @Test func closeText() async throws {
        #expect(viewModel.closeText == "analysis.close")
        #expect(viewModel.closeText.string == "Close")
    }

    @Test func loadingText() async throws {
        #expect(viewModel.loadingText == "analysis.loading.text")
        #expect(viewModel.loadingText.string == "Loading")
    }

    @Test func displayImage() async throws {
        #expect(viewModel.imageURL == URL(string: self.testPhoto.src.large))
    }

    @Test func initiallyHasNoAnalysis() async throws {
        #expect(viewModel.analysis == nil)
    }

    @Test func performsAnalysis() async throws {
        await viewModel.startAnalysis()

        #expect(viewModel.analysis == "Unit test analysis")
    }

    @Test func displaysError() async throws {
        mockImageLoader.shouldFail = true
        await viewModel.startAnalysis()

        #expect(viewModel.analysis == "Unable to perform analysis. Please try again later.")
    }
}
