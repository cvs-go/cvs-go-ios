//
//  ContentView.swift
//  PyeonHae
//
//  Created by 정건호 on 2022/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
                .font(.pretendard(.extraBold, 24))
                .foregroundColor(.green)
            
            Text("Hello, world!")
                .font(.pretendard(.extraBold, 24))
                .foregroundColor(.systemGreen)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
