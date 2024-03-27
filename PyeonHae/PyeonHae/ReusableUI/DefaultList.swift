//
//  DefaultList.swift
//  PyeonHae
//
//  Created by 정건호 on 3/27/24.
//

import SwiftUI

struct DefaultList<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        List {
            content
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
        }
        .listStyle(PlainListStyle())
    }
}
