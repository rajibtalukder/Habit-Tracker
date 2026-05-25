import SwiftUI
struct AddHabitSheet: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: HabitViewModel
    
    @State private var title = ""
    @State private var selectedIcon = "drop.fill"
    @State private var selectedColor = "blue"
    
    let icons = ["drop.fill", "figure.mind.and.body", "book.fill", "bed.double.fill", "heart.fill", "dumbbell.fill"]
    let colors = ["blue", "purple", "orange", "green", "pink"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Habit Details") {
                    TextField("Habit Title (e.g. Meditate)", text: $title)
                }
                
                Section("Choose Icon") {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 6), spacing: 10) {
                        ForEach(icons, id: \.self) { icon in
                            Image(systemName: icon)
                                .font(.title3)
                                .frame(width: 40, height: 40)
                                .background(selectedIcon == icon ? Color.blue.opacity(0.2) : Color.clear)
                                .clipShape(Circle())
                                .onTapGesture { selectedIcon = icon }
                        }
                    }
                    .padding(.vertical, 4)
                }
                
                Section("Choose Theme Color") {
                    HStack(spacing: 15) {
                        ForEach(colors, id: \.self) { color in
                            Circle()
                                .fill(Habit(title: "", icon: "", colorName: color, isCompleted: false, streak: 0).themeColor)
                                .frame(width: 35, height: 35)
                                .overlay(
                                    Circle()
                                        .stroke(Color.primary, lineWidth: selectedColor == color ? 2 : 0)
                                )
                                .onTapGesture { selectedColor = color }
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("New Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if !title.isEmpty {
                            viewModel.addHabit(title: title, icon: selectedIcon, colorName: selectedColor)
                            dismiss()
                        }
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}
