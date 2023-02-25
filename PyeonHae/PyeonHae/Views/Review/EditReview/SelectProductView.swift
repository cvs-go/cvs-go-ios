//
//  SelectProductView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/02/09.
//

import SwiftUI

struct SelectProductView: View {
    @State var isSelectProduct: Bool = false
    @Binding var showSearchProductView: Bool
    var body: some View {
        VStack {
            Button(action: {
                showSearchProductView.toggle()
            }) {
//                if(!isSelectProduct) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [3]))
                                    .foregroundColor(Color.grayscale30)
                        HStack {
                            Image(name: .plusButton)
                            Text("리뷰를 남길 제품을 선택해주세요.")
                                .font(.pretendard(.regular, 14))
                                .foregroundColor(.grayscale70)
                        }
                    }
                    .background(Color.grayscale10)
                    .padding(.horizontal, 12)
                    .frame(height: 64)
//                } else {
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 10)
//                            .stroke(Color.grayscale30, lineWidth: 1)
//                        HStack {
//                            Image(name: .sampleImage)
//                                .resizable()
//                                .frame(width: 52, height: 52)
//                                .padding(.leading, 6)
//                            VStack(alignment: .leading) {
//                                Text("코카콜라")
//                                    .font(.pretendard(.regular, 12))
//                                    .foregroundColor(.grayscale50)
//                                Text("제품 이름 한줄에서 끝내자")
//                                    .font(.pretendard(.semiBold, 14))
//                                    .foregroundColor(.grayscale85)
//                            }
//                            Spacer()
//                            Button(action: {
//                                isSelectProduct.toggle()
//                            }) {
//                                Image(name: .close)
//                                    .resizable()
//                                    .frame(width: 24, height: 24)
//                                    .padding(.trailing, 16)
//                            }
//                        }
//                    }
//                    .background(Color.grayscale10)
//                    .padding(.horizontal, 12)
//                    .frame(height: 64)
//                }
            }
        }
        .padding(.all, 16)
        .background(Color.white)
    }
}

//struct SelectProductView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectProductView()
//    }
//}

private struct Distances {
    static let hidden: CGFloat = 500
    static let dismiss: CGFloat = 200
}

struct BottomSheet<Content: View>: View {
    @Binding var isPresented: Bool
    @ViewBuilder let content: Content

    @State private var translation = Distances.hidden

    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .onTapGesture {
                    isPresented = false
                }

            VStack {
                Spacer()
                contentView
                    .offset(y: translation)
                    .animation(.interactiveSpring(), value: isPresented)
                    .animation(.interactiveSpring(), value: translation)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                guard translation > 0 else { return }
                                translation = value.translation.height
                            }
                            .onEnded { value in
                                if value.translation.height > Distances.dismiss {
                                    translation = Distances.hidden
                                    isPresented = false
                                } else {
                                    translation = 0
                                }
                            }
                    )
            }
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation {
                translation = 0
            }
        }
    }

    private var contentView: some View {
        VStack(spacing: 0) {
            handle
                .padding(.top, 10)
            content
                .padding(.top, 13)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: UIWindow().screen.bounds.height - 93)
        .background(Color.white)
        .cornerRadius(24)
        .shadow(color: Color.gray, radius: 2, x: 0, y: -2)
    }

    private var handle: some View {
        RoundedRectangle(cornerRadius: 3)
            .fill(Color.grayscale30)
            .frame(width: 44, height: 4)
    }
}


extension View {
    func bottomSheet<Content: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self
            .overlay(
                Group {
                    if isPresented.wrappedValue {
                        BottomSheet(
                            isPresented: isPresented,
                            content: content
                        )
                    }
                }
            )
    }
}
