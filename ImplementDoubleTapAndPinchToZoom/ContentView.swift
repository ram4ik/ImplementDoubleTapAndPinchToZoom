//
//  ContentView.swift
//  ImplementDoubleTapAndPinchToZoom
//
//  Created by ramil on 08.10.2019.
//  Copyright © 2019 com.ri. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var scale: CGFloat = 1.0
    @State var isTapped: Bool = false
    @State var pointTapped: CGPoint = CGPoint.zero
    @State var draggedWidth: CGSize = CGSize.zero
    @State var previousDRagged: CGSize = CGSize.zero
    var body: some View {
        GeometryReader { reader in
            Image("pizza")
                .resizable()
                .scaledToFit()
                .animation(.default)
                .scaleEffect(self.scale)
                .scaleEffect(self.isTapped ? 2 : 1, anchor: UnitPoint(x: self.pointTapped.x / reader.frame(in: .global).maxX, y: self.pointTapped.y / reader.frame(in: .global).maxY))
                .gesture(TapGesture(count: 2).onEnded({
                    self.isTapped = !self.isTapped
                }).simultaneously(with: DragGesture(minimumDistance: 0, coordinateSpace: .global).onChanged({ (value) in
                    self.pointTapped = value.startLocation
                    self.draggedWidth = CGSize(width: value.translation.width + self.previousDRagged.width, height: value.translation.height + self.previousDRagged.height)
                }).onEnded({ (value) in
                    self.draggedWidth = CGSize(width: value.translation.width + self.previousDRagged.width, height: value.translation.height + self.previousDRagged.height)
                    self.previousDRagged = self.draggedWidth
                })))
                .gesture(MagnificationGesture().onChanged({ (scsle) in
                    self.scale = self.scale.magnitude
                }).onEnded({ (scaleFinal) in
                    self.scale = scaleFinal.magnitude
                }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
