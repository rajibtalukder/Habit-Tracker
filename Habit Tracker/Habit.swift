
import Foundation

struct Habit : Identifiable{
    var id = UUID()
    var title : String
    var icon : String
    var colorName : String
    var isCompleted : Bool
    var streak : Int
}
