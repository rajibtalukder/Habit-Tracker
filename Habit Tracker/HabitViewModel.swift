import SwiftUI
internal import Combine

class HabitViewModel: ObservableObject {
    @Published var habits: [Habit] = [] {
        didSet {
            saveHabits()
        }
    }
    
    private let saveKey = "HabitsSavedData"
    
    init() {
        loadHabits()
    }
    
    // MARK: - Business Logic
    func toggleHabit(habit: Habit) {
        guard let index = habits.firstIndex(where: { $0.id == habit.id }) else { return }
        
        withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
            habits[index].isCompleted.toggle()
            if habits[index].isCompleted {
                habits[index].streak += 1
            } else {
                habits[index].streak = max(0, habits[index].streak - 1)
            }
        }
    }
    
    func addHabit(title: String, icon: String, colorName: String) {
        let newHabit = Habit(title: title, icon: icon, colorName: colorName, isCompleted: false, streak: 0)
        withAnimation {
            habits.append(newHabit)
        }
    }
    
    func deleteHabit(at offsets: IndexSet) {
        habits.remove(atOffsets: offsets)
    }
    
    // MARK: - Data Persistence
    private func loadHabits() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([Habit].self, from: data) {
            self.habits = decoded
        } else {
            // Default sample data on first run
            self.habits = [
                Habit(title: "Drink Water", icon: "drop.fill", colorName: "blue", isCompleted: false, streak: 5),
                Habit(title: "Morning Yoga", icon: "figure.mind.and.body", colorName: "purple", isCompleted: true, streak: 12),
                Habit(title: "Read 10 Pages", icon: "book.fill", colorName: "orange", isCompleted: false, streak: 3)
            ]
        }
    }
    
    private func saveHabits() {
        if let encoded = try? JSONEncoder().encode(habits) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
}
