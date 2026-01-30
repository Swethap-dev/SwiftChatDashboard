//
//  ImageTabView.swift
//  SwiftChatDashboard
//
//  Created by swetha on 30/01/26.
//

struct IdentifiableImage: Identifiable {
    let id = UUID()
    let image: UIImage
}


import SwiftUI

struct ImageTabView: View {
    @StateObject private var viewModel = ImageViewModel()
    @State private var showPicker = false
    @State private var pickerSource: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var selectedImageForDetail: IdentifiableImage?

    // Grid layout
    private let columns = [GridItem(.adaptive(minimum: 120), spacing: 12)]

    var body: some View {
        ZStack {
            // MARK: Background Gradient
            LinearGradient(
                colors: [Color.blue.opacity(0.2), Color.cyan.opacity(0.2)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            VStack {
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(viewModel.images) { imageEntity in
                            ZStack {
                                Image(uiImage: imageEntity.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 120)
                                    .clipped()
                                    .cornerRadius(12)
                                    .shadow(radius: 3)
                                    .onTapGesture {
                                        selectedImageForDetail = IdentifiableImage(image: imageEntity.image)
                                    }
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                Divider()
                    .padding(.vertical, 8)

                HStack(spacing: 20) {
                    Button {
                        openPicker(source: .camera)
                    } label: {
                        Label("Camera", systemImage: "camera.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.gradient)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(radius: 2)
                    }

                    Button {
                        openPicker(source: .photoLibrary)
                    } label: {
                        Label("Library", systemImage: "photo.fill.on.rectangle.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green.gradient)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(radius: 2)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .navigationTitle("Images")
            .sheet(isPresented: $showPicker, onDismiss: handlePickerDismiss) {
                ImagePicker(image: $selectedImage, sourceType: pickerSource)
            }
            .fullScreenCover(item: $selectedImageForDetail) { identifiableImage in
                ImageDetailView(image: identifiableImage.image)
            }
        }
    }

    // MARK: - Helper functions
    private func openPicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            pickerSource = source
        } else {
            pickerSource = .photoLibrary
            print("Selected source not available. Opening photo library instead")
        }
        showPicker = true
    }

    private func handlePickerDismiss() {
        if let selectedImage = selectedImage {
            viewModel.addImage(selectedImage)
            self.selectedImage = nil
        }
    }
}

// MARK: - Image Detail View
struct ImageDetailView: View {
    let image: UIImage
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.black.ignoresSafeArea()
            VStack{
                Spacer()
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .padding()
                Spacer()
            }

            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .padding()
            }
        }
    }
}
