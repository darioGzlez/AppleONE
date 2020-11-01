//
//  ContentView.swift
//  AppleONE
//
//  Created by Darío González Martínez on 30/10/2020.
//

import SwiftUI

struct ContentView: View {
    @State var showSheet = false
    
    var body: some View {
        AppleOneView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.dark)
            ContentView()
                .preferredColorScheme(.light)
        }
    }
}
