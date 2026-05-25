import SwiftUI
struct HabitCardView: View {
    let habit: Habit
    var onToggle: () -> Void
    
    var body: some View {
        HStack(spacing: 15) {
            ZStack {
                Circle()
                    .fill(habit.themeColor.opacity(0.15))
                    .frame(width: 50, height: 50)
                
                Image(systemName: habit.icon)
                    .foregroundStyle(habit.themeColor)
                    .font(.title3)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(habit.title)
                    .font(.headline)
                    .strikethrough(habit.isCompleted, color: .gray)
                    .foregroundStyle(habit.isCompleted ? .secondary : .primary)
                
                HStack(spacing: 4) {
                    Image(systemName: "flame.fill")
                        .font(.caption)
                        .foregroundStyle(habit.streak > 0 ? .orange : .gray)
                    Text("\(habit.streak) day streak")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            Button(action: onToggle) {
                Image(systemName: habit.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title)
                    .foregroundStyle(habit.isCompleted ? .green : .gray.opacity(0.3))
                    .contentTransition(.symbolEffect(.replace))
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(UIColor.systemBackground))
                .shadow(color: .black.opacity(0.03), radius: 8, x: 0, y: 4)
        )
    }
}
