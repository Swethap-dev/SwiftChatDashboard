//
//  ChatBubbleView.swift
//  SwiftChatDashboard
//
//  Created by swetha on 29/01/26.
//

import SwiftUI

import SwiftUI

struct ChatBubbleView: View {
    let message: MessageEntity

    var body: some View {
        HStack {
            if message.sender == "Me" {
                Spacer()
            }

            Text(message.text)
                .padding(10)
                .background(message.sender == "Me" ? Color.blue : Color.gray.opacity(0.3))
                .foregroundColor(message.sender == "Me" ? .white : .primary)
                .cornerRadius(16)
                .frame(maxWidth: 250, alignment: message.sender == "Me" ? .trailing : .leading)

            if message.sender != "Me" {
                Spacer()
            }
        }
        .padding(message.sender == "Me" ? .leading : .trailing, 60)
        .padding(.vertical, 4)
    }
}
