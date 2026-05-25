import SwiftUI
internal import Combine

class HabitViewModel: ObservableObject {
    
    @Published var habits: [Habit] = [
        Habit(title: "Drink Water", icon: "drop.fill", colorName: "blue", isCompleted: false, streak: 5),
        Habit(title: "Morning Yoga", icon: "figure.mind.and.body", colorName: "purple", isCompleted: true, streak: 12),
        Habit(title: "Read 10 Pages", icon: "book.fill", colorName: "orange", isCompleted: false, streak: 3)
    ]
    
    func toggleHabit(habit: Habit) {
        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
            habits[index].isCompleted.toggle()
            if habits[index].isCompleted {
                habits[index].streak += 1
            } else {
                habits[index].streak -= 1
            }
        }
    }
}
