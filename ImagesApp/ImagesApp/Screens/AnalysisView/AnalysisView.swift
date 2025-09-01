//
//  AnalysisView.swift
//  ImagesApp
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

import SwiftUI

struct AnalysisView: View {
    @StateObject var viewModel: AnalysisViewModel

    var body: some View {
        ScrollView {
            AsyncImage(url: viewModel.imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
            } placeholder: {
                ProgressView(viewModel.loadingText.string)
            }

            if let analysis = viewModel.analysis {
                Text(analysis)
                    .font(.body)
            } else {
                ProgressView(viewModel.analysingText.string)
            }
        }
        .padding()
        .navigationTitle(viewModel.titleText.string)
        .navigationBarTitleDisplayMode(.inline)
        .interactiveDismissDisabled(true)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(viewModel.closeText.string,
                       systemImage: SFSymbol.xmark(),
                       action: viewModel.dismiss)
                .symbolEffect(.bounce)
            }
        }
        .task(id: "onFirstLoad") {
            await viewModel.startAnalysis()
        }
    }
}

#Preview {
    CoordindatorContent(.detail(photo: PexelsPhoto.sample), di: .forPreview())
}
