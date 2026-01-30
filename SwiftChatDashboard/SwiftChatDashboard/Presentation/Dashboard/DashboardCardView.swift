//
//  DashboardCardView.swift
//  SwiftChatDashboard
//
//  Created by swetha on 29/01/26.
//

import SwiftUI

struct DashboardCardView: View {
    let title: String
    let value: String
    let iconName: String

    @State private var appear = false

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: iconName)
                .font(.title)
                .foregroundColor(.blue)
                .padding()
                .background(RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.title2).bold()
                Text(value)
                    .font(.title3).bold()
            }
            Spacer()
        }
        .padding(8)
        .frame(height: 100)
        .background(.ultraThickMaterial)
        .cornerRadius(20)
        .scaleEffect(appear ? 1 : 0.9)
        .opacity(appear ? 1 : 0)
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                appear = true
            }
        }
    }
}
