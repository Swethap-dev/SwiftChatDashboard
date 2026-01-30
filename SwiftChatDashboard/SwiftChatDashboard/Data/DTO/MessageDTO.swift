//
//  MessageDTO.swift
//  SwiftChatDashboard
//
//  Created by swetha on 29/01/26.
//

import Foundation

struct MessageDTO: Decodable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
