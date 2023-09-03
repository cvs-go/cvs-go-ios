//
//  NoticeListView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/09/03.
//

import SwiftUI

struct NoticeListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var myInfoViewModel: MyInfoViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            noticeTopBar
            ForEach(myInfoViewModel.noticeList, id: \.self) { notice in
                noticeCell(notice)
            }
            Spacer()
        }
        .onAppear {
            self.myInfoViewModel.requestNoticeList()
        }
    }
    
    var noticeTopBar: some View {
        HStack(spacing: 0) {
            Spacer().frame(width: 14)
            Image(name: .arrowLeft)
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }
            Spacer().frame(width: 9)
            Text("공지사항")
                .font(.pretendard(.bold, 18))
                .foregroundColor(.black)
            Spacer()
        }
        .frame(height: 44)
    }
    
    @ViewBuilder
    func noticeCell(_ notice: NoticeContentModel) -> some View {
        HStack(spacing: 0) {
            Spacer().frame(width: 24)
            Text(notice.title)
                .font(.pretendard(.semiBold, 16))
                .foregroundColor(.mineGray900)
            if notice.new {
                Spacer().frame(width: 10)
                Image(name: .newImage)
            }
            Spacer()
            Text(notice.createdAt)
                .font(.pretendard(.medium, 12))
                .foregroundColor(.mineGray400)
            Spacer().frame(width: 20)
        }
    }
}
