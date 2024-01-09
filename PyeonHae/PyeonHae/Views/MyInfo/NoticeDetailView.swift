//
//  NoticeDetailView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/09/03.
//

import SwiftUI

struct NoticeDetailView: View {
    @ObservedObject var myInfoViewModel: MyInfoViewModel
    var noticeId: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 13) {
            NavigationBar(title: "공지사항")
            Spacer().frame(height: 7)
            if let notice = myInfoViewModel.noticeDetail {
                Group {
                    Text(notice.title)
                        .font(.pretendard(.semiBold, 16))
                        .foregroundColor(.mineGray900)
                    // TODO: 이미지 UI 여쭤보고 수정하기
                    Text(notice.content)
                        .font(.pretendard(.regular, 16))
                        .foregroundColor(.grayscale85)
                    Text(notice.createdAt ?? String())
                        .font(.pretendard(.medium, 12))
                        .foregroundColor(.mineGray400)
                }
                .padding(.horizontal, 20)
            }
            Spacer()
        }
        .onAppear {
            myInfoViewModel.requestNoticeDetail(id: noticeId)
        }
    }
}
