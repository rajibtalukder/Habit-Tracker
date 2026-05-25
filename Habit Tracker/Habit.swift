import Foundation
import SwiftUI

struct Habit: Identifiable, Codable {
    var id = UUID()
    var title : String
    var icon : String
    var colorName : String
    var isCompleted : Bool
    var streak : Int
    
    
    var themeColor: Color {
        switch colorName.lowercased() {
        case "blue": return .blue
        case "purple": return .purple
        case "orange": return .orange
        case "green": return .green
        case "pink": return .pink
        default: return .accentColor
        }
    }
}
