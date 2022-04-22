//
//  LaunchView.swift
//  Find
//
//  Created by A. Zheng (github.com/aheze) on 4/16/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import SwiftUI

enum LaunchViewConstants {
    static var spacing = CGFloat(20)

    static var sidePadding = CGFloat(24)

    static var headerSpacing = CGFloat(8)
    static var headerTitleFont = UIFont.systemFont(ofSize: 48, weight: .bold)
    static var headerSubtitleFont = UIFont.systemFont(ofSize: 24, weight: .medium)
    static var headerInsets = EdgeInsets(top: 48, leading: sidePadding, bottom: 16, trailing: sidePadding)

    static var footerInsets = EdgeInsets(top: 16, leading: sidePadding, bottom: 16, trailing: sidePadding)
    static var footerCornerRadius = CGFloat(20)

    static var controlButtonFont = UIFont.preferredFont(forTextStyle: .title3)

    static var controlCircleSpacing = CGFloat(12)
    static var controlCircleLength = CGFloat(8)
}

struct LaunchView: View {
    @ObservedObject var model: LaunchViewModel
    let c = LaunchViewConstants.self

    @State var topTextHeight = CGFloat(0)
    @State var bottomTextHeight = CGFloat(0)
    @State var contentHeight = CGFloat(0)
    @State var deviceHeight = CGFloat(0)

    var body: some View {
        /// gap above and below the content, on iPad
        let verticalGap = (deviceHeight - contentHeight) / 2

        VStack {
            Colors.accentDarkBackground.color
                .edgesIgnoringSafeArea(.all)
        }
        .mask(
            VStack(spacing: 0) {
                Color.black
                    .frame(height: topTextHeight + verticalGap)

                LinearGradient(
                    stops: [
                        .init(
                            color: Colors.accentDarkBackground.color,
                            location: 0
                        ),
                        .init(
                            color: Colors.accentDarkBackground.color.opacity(0),
                            location: 0.1
                        ),
                        .init(
                            color: Colors.accentDarkBackground.color.opacity(0),
                            location: 0.8
                        ),
                        .init(
                            color: Colors.accentDarkBackground.color,
                            location: 1
                        )
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )

                Color.black
                    .frame(height: bottomTextHeight + verticalGap)
            }
            .edgesIgnoringSafeArea(.all)
        )
        .overlay(
            VStack(spacing: c.spacing) {
                if model.currentPage == .empty {
                    VStack(spacing: c.headerSpacing) {
                        Text("Find")
                            .font(c.headerTitleFont.font)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text("An app to find text in real life.")
                            .font(c.headerSubtitleFont.font)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .opacity(model.currentPage == .empty ? 1 : 0)
                    .padding(c.headerInsets)

                    .readSize {
                        topTextHeight = $0.height
                    }
                }

                LaunchContentView(model: model)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background( /// for the final page
                        LinearGradient(
                            stops: [
                                .init(
                                    color: Colors.accentDarkBackground.color.opacity(0),
                                    location: 0
                                ),
                                .init(
                                    color: Colors.accentDarkBackground.color,
                                    location: 0.3
                                ),
                                .init(
                                    color: Colors.accentDarkBackground.color,
                                    location: 0.7
                                ),
                                .init(
                                    color: Colors.accentDarkBackground.color.opacity(0),
                                    location: 1
                                )
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .padding(.vertical, 80)
                        .opacity(model.currentPage == .final ? 1 : 0)
                    )

                PagingButtonsView(model: model)

                if model.currentPage == .empty {
                    Button {
                        withAnimation {
                            model.setCurrentPage(to: .photos)
                        }
                    } label: {
                        Text("Get Started")
                            .font(UIFont.preferredCustomFont(forTextStyle: .title1, weight: .medium).font)
                            .frame(maxWidth: .infinity)
                            .padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24))
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(c.footerCornerRadius)
                    }
                    .buttonStyle(LaunchButtonStyle())
                    .frame(maxWidth: .infinity)
                    .opacity(model.currentPage == .empty ? 1 : 0)
                    .padding(c.footerInsets)
                    .readSize {
                        bottomTextHeight = $0.height
                    }
                }
            }
            .frame(maxWidth: 560, maxHeight: 900)
            .foregroundColor(.white)
            .opacity(model.showingUI ? 1 : 0)
            .readSize {
                contentHeight = $0.height
            }
        )
        .readSize {
            deviceHeight = $0.height
        }
    }
}

struct PagingButtonsView: View {
    @ObservedObject var model: LaunchViewModel
    let c = LaunchViewConstants.self

    var body: some View {
        if model.currentPage != .empty, let currentIndex = model.getCurrentIndex() {
            let previousPage = model.pages[safe: currentIndex - 1]
            let nextPage = model.pages[safe: currentIndex + 1]

            HStack {
                LaunchControlButtonView(icon: "chevron.backward") {
                    if let previousPage = previousPage {
                        model.setCurrentPage(to: previousPage)
                    }
                }

                HStack(spacing: c.controlCircleSpacing) {
                    ForEach(model.pages, id: \.self) { page in
                        if page != .empty {
                            Circle()
                                .fill(Color.white)
                                .frame(width: c.controlCircleLength, height: c.controlCircleLength)
                                .opacity(model.currentPage == page ? 1 : 0.5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)

                LaunchControlButtonView(icon: "chevron.forward") {
                    if let nextPage = nextPage {
                        model.setCurrentPage(to: nextPage)
                    }
                }
                .opacity(nextPage != nil ? 1 : 0)
            }
            .padding(.horizontal, c.sidePadding)
        }
    }
}

struct LaunchControlButtonView: View {
    var icon: String
    var action: () -> Void

    let c = LaunchViewConstants.self

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .foregroundColor(.white)
                .font(c.controlButtonFont.font)
                .padding(12)
                .background(
                    Circle()
                        .fill(.white.opacity(0.15))
                )
        }
        .buttonStyle(LaunchButtonStyle())
    }
}

struct LaunchContentView: UIViewControllerRepresentable {
    @ObservedObject var model: LaunchViewModel

    func makeUIViewController(context: Context) -> LaunchContentViewController {
        LaunchContentViewController.make(model: model)
    }

    func updateUIViewController(_ uiViewController: LaunchContentViewController, context: Context) {}
}

public extension View {
    @inlinable
    func reverseMask<Mask: View>(
        @ViewBuilder _ mask: () -> Mask
    ) -> some View {
        self.mask(
            Rectangle()
                .overlay(
                    mask()
                        .blendMode(.destinationOut)
                )
        )
    }
}
