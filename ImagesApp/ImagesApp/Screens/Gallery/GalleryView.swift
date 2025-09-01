//
//  GalleryView.swift
//  ImagesApp
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

import SwiftUI

struct GalleryView: View {
    @StateObject var viewModel: GalleryViewModel

    @Namespace private var animationNamespace

    var body: some View {
        VStack {
            if viewModel.isLoading {
                loadingContent
            } else if viewModel.photos.count == 0 {
                noImagesContent
            } else {
                photoContent
            }
        }
        .navigationTitle(viewModel.pageTitle)
        .padding()
        .task { await viewModel.onAppear() }
    }

    private var loadingContent: some View {
        ProgressView(viewModel.loadingText.string)
    }

    private var noImagesContent: some View {
        ContentUnavailableView(viewModel.noImagesText.string,
                               systemImage: viewModel.noImagesSystemImage())
    }

    private var photoContent: some View {
        VStack(spacing: 0) {
            Spacer()

            primaryImage

            Spacer()

            filmStrip
                .padding(.bottom, 10)
        }
    }

    @ViewBuilder
    private var primaryImage: some View {
        if let selectedPhoto = viewModel.selectedPhoto {
            VStack {
                Button {
                    viewModel.viewDetails(selectedPhoto)
                } label: {
                    AsyncImage(url: URL(string: selectedPhoto.src.large)!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    } placeholder: {
                        ProgressView(viewModel.loadingText.string)
                    }
                }

                Label(selectedPhoto.alt, systemImage: "note")
                    .font(.headline)
                    .lineLimit(2, reservesSpace: false)
                    .matchedGeometryEffect(id: "alt", in: animationNamespace)

                Label(selectedPhoto.photographer, systemImage: "person.crop.square.badge.camera")
                    .font(.subheadline)
                    .matchedGeometryEffect(id: "photographer", in: animationNamespace)

                Text("\(selectedPhoto.width) X \(selectedPhoto.height)")
                    .font(.caption)
                    .matchedGeometryEffect(id: "imageDimensions", in: animationNamespace)
            }
            .padding(50)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    let isFavorite = viewModel.isFavorite(selectedPhoto)
                    Button(viewModel.toggleFavouriteButton.string,
                           systemImage: isFavorite ? SFSymbol.heartFill(): SFSymbol.heart(),
                           action: viewModel.toggleFavorite)
                    .symbolEffect(.bounce)
                }
            }
        }
    }

    private var filmStrip: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                ForEach(viewModel.photos) { photo in
                    Button {
                        withAnimation {
                            viewModel.selectedPhoto = photo
                        }
                    } label: {
                        AsyncImage(url: URL(string: photo.src.medium)!) { thumbnail in
                            thumbnail
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 80, height: 80)
                        .clipped()
                        .cornerRadius(10)
                        .overlay {
                            if photo == viewModel.selectedPhoto {
                                selectedThumbnailIndicator
                            }
                        }
                        .overlay(alignment: .topTrailing) {
                            if viewModel.isFavorite(photo) {
                                Image(systemName: SFSymbol.heartFill())
                                    .padding(4)
                            } else {
                                Image(systemName: SFSymbol.heart())
                                    .padding(4)
                            }
                        }
                    }

                }
                .padding(10)
            }
        }
    }

    private var selectedThumbnailIndicator: some View {
        RoundedRectangle(cornerRadius: 10, style: .circular)
            .stroke(Color.yellow, lineWidth: 3)
            .matchedGeometryEffect(id: "selectedThumbnail", in: animationNamespace)
    }
}

#Preview("Search query") {
    CoordindatorContent(.results(searchPhrase: "Preview"),
                        di: .forPreview())
}

#Preview("Saved") {
    CoordindatorContent(.saved,
                        di: .forPreview())
}
