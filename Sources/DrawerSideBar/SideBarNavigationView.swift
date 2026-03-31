//
//  SideBarNavigationView.swift
//  DrawerSideBar
//
//  Created by shubham kachhiya on 31/03/26.
//


import SwiftUI

public struct SideBarNavigationView<SideBar: View, Main: View>: View {
    var sideBarWidthRatio: CGFloat
    var mainViewScaleSize: CGFloat
    let sideBarContent: (EdgeInsets) -> SideBar
    let mainContent: (EdgeInsets) -> Main

    @Binding var isSideBarOpened: Bool

    public init(
        isSideBarOpened: Binding<Bool> = .constant(false),
        sideBarWidthRatio: CGFloat = 0.7,
        mainViewScaleSize: CGFloat = 0.8,
        @ViewBuilder sideBar: @escaping (EdgeInsets) -> SideBar,
        @ViewBuilder main: @escaping (EdgeInsets) -> Main
    ) {
        self._isSideBarOpened = isSideBarOpened
        self.sideBarWidthRatio = sideBarWidthRatio
        self.mainViewScaleSize = mainViewScaleSize
        self.sideBarContent = sideBar
        self.mainContent = main
    }

    var sideBarWidth: CGFloat { UIScreen.main.bounds.size.width * sideBarWidthRatio }

    @State private var offset: CGFloat = 0
    @GestureState private var gestureOffset: CGFloat = 0

    var totalOffset: CGFloat {
        max(self.offset + self.gestureOffset, 0)
    }

    public var body: some View {
        GeometryReader { proxy in
            let safeArea = proxy.safeAreaInsets

            ZStack(alignment: .leading) {
                Color.blue

                ZStack {
                    sideBarContent(safeArea)
                }
                .frame(width: sideBarWidth)
                .offset(x: -sideBarWidth)
                .offset(x: totalOffset)

                ZStack(alignment: .top) {
                    mainContent(safeArea)

                    HStack {
                        Button {
                            withAnimation {
                                isSideBarOpened.toggle()
                            }
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .resizable()
                                .foregroundStyle(.black)
                                .frame(width: 25, height: 20)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, safeArea.top)
                }
                .clipShape(RoundedRectangle(cornerRadius: isSideBarOpened ? 20 : 0))
                .shadow(
                    color: .black.opacity(isSideBarOpened ? 1 : 0),
                    radius: 18, x: 8, y: 0
                )
                .overlay(
                    RoundedRectangle(cornerRadius: isSideBarOpened ? 20 : 0)
                        .stroke(Color.white.opacity(isSideBarOpened ? 0.9 : 0), lineWidth: 2)
                )
                .scaleEffect(isSideBarOpened ? mainViewScaleSize : 1.0, anchor: .leading)
                .offset(x: totalOffset)
                .gesture(
                    DragGesture()
                        .updating($gestureOffset) { value, out, _ in
                            if value.translation.width > 0 && isSideBarOpened {
                                out = value.translation.width * 0.1
                            } else {
                                out = min(value.translation.width, sideBarWidth)
                            }
                        }
                        .onEnded(onEnd(value:))
                )
            }
            .ignoresSafeArea()
        }
        .animation(.smooth(duration: 0.4, extraBounce: 0), value: offset)
        .animation(.smooth(duration: 0.4, extraBounce: 0), value: gestureOffset)
        .onChange(of: isSideBarOpened) { _, newValue in
            offset = newValue ? sideBarWidth : 0
        }
    }

    func onEnd(value: DragGesture.Value) {
        let translation = value.translation.width
        if translation > 0 && translation > (sideBarWidth * 0.6) {
            isSideBarOpened = true
        } else if -translation > (sideBarWidth / 2) {
            isSideBarOpened = false
        } else {
            if offset == 0 || !isSideBarOpened { return }
            isSideBarOpened = true
        }
    }
}
