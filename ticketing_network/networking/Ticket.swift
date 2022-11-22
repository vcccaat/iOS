

import Foundation

struct Ticket: Codable {
    let id: Int
    var description: String
    var done: Bool
}


struct TicketResponse: Codable {
    let tasks: [Ticket]
}
