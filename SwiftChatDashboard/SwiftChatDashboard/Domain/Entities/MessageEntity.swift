//
//  MessageEntity.swift
//  SwiftChatDashboard
//
//  Created by swetha on 29/01/26.
//

import Foundation
import UIKit

import Foundation

struct MessageEntity: Identifiable, Hashable {
    let id: UUID = UUID()
    let text: String
    let sender: String
    let timestamp: Date
}
