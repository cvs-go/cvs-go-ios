//
//  NoticeDetailView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/09/03.
//

import SwiftUI

struct NoticeDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var myInfoViewModel: MyInfoViewModel
    
    var noticeId: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 13) {
            noticeTopBar
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
}
