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
    var body: some View {
        Image("pizza")
            .resizable()
            .scaledToFit()
            .scaleEffect(self.scale)
            .scaleEffect(self.isTapped ? 2 : 1, anchor: UnitPoint(x: 0, y: 0))
            .gesture(TapGesture(count: 2).onEnded({
                self.isTapped = !self.isTapped
            }).simultaneously(with: DragGesture(minimumDistance: 0, coordinateSpace: .global).onChanged({ (value) in
                print(value.startLocation)
            }).onEnded({ (value) in
                print(value.location)
            })))
            .gesture(MagnificationGesture().onChanged({ (scsle) in
                self.scale = self.scale.magnitude
            }).onEnded({ (scaleFinal) in
                self.scale = scaleFinal.magnitude
            }))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
