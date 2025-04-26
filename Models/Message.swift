import Foundation

struct Message: Identifiable, Codable {
    let id = UUID()
    let text: String
    let isSentByMe: Bool
    let timestamp: Date
}
