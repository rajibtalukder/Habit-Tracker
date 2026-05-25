import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = HabitViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 25) {
                        headerSection
                        
                        Text("Today's Habits")
                            .font(.title2.bold())
                            .padding(.horizontal)
                        
                        VStack(spacing: 16) {
                            ForEach(viewModel.habits) { habit in
                                HabitCardView(habit: habit) {
                                    viewModel.toggleHabit(habit: habit)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Habitly")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // MARK: - Subviews
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Welcome back,")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text("Build your future.")
                .font(.largeTitle.bold())
        }
        .padding(.horizontal)
    }
}

// MARK: - Habit Card Component
struct HabitCardView: View {
    let habit: Habit
    var onToggle: () -> Void
    
    var body: some View {
        HStack(spacing: 15) {
            // Icon Circle
            ZStack {
                Circle()
                    .fill(Color(habit.colorName).opacity(0.2))
                    .frame(width: 50, height: 50)
                
                Image(systemName: habit.icon)
                    .foregroundStyle(Color(habit.colorName))
                    .font(.title3)
            }
            
            VStack(alignment: .leading) {
                Text(habit.title)
                    .font(.headline)
                Text("\(habit.streak) day streak")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Button(action: onToggle) {
                Image(systemName: habit.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title)
                    .foregroundStyle(habit.isCompleted ? .green : .gray.opacity(0.5))
                    .contentTransition(.symbolEffect(.replace))
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
        )
    }
}
