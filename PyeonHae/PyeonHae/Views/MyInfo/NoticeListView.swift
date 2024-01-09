//
//  NoticeListView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/09/03.
//

import SwiftUI

struct NoticeListView: View {
    @ObservedObject var myInfoViewModel: MyInfoViewModel
    @State private var showNoticeDetail = false
    @State private var noticeId = -1
    
    var body: some View {
        VStack(spacing: 16) {
            NavigationBar(title: "공지사항")
            ForEach(myInfoViewModel.noticeList, id: \.self) { notice in
                noticeCell(notice)
            }
            Spacer()
        }
        .onAppear {
            self.myInfoViewModel.requestNoticeList()
        }
        .navigationDestination(isPresented: $showNoticeDetail) {
            NoticeDetailView(
                myInfoViewModel: myInfoViewModel,
                noticeId: noticeId
            )
        }
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
        .contentShape(Rectangle())
        .frame(height: 40)
        .onTapGesture {
            self.noticeId = notice.id
            self.showNoticeDetail = true
        }
    }
}
