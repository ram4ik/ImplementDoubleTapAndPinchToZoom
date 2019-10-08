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
    var body: some View {
        Image("pizza")
            .resizable()
            .scaledToFit()
            .scaleEffect(self.scale)
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
