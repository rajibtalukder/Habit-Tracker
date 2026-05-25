import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = HabitViewModel()
    @State private var isShowingAddSheet = false
    
    
    private var completionRate: Double {
        guard !viewModel.habits.isEmpty else { return 0 }
        let completed = viewModel.habits.filter { $0.isCompleted }.count
        return Double(completed) / Double(viewModel.habits.count)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 25) {
                        headerSection
                        progressOverviewCard
                        
                        Text("Today's Habits")
                            .font(.title2.bold())
                            .padding(.horizontal)
                        
                        if viewModel.habits.isEmpty {
                            emptyStateView
                        } else {
                            habitListSection
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Habitly")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowingAddSheet = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                            .foregroundStyle(.blue)
                    }
                }
            }
            .sheet(isPresented: $isShowingAddSheet) {
                AddHabitSheet(viewModel: viewModel)
            }
        }
    }
    
    // MARK: - Subviews
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Welcome back,")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text("Build your future.")
                .font(.largeTitle.bold())
        }
        .padding(.horizontal)
    }
    
    private var progressOverviewCard: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Today's Progress")
                    .font(.headline)
                    .foregroundStyle(.white)
                Text("\(Int(completionRate * 100))% of your goals achieved!")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.8))
            }
            Spacer()
            
            ZStack {
                Circle()
                    .stroke(Color.white.opacity(0.2), lineWidth: 6)
                Circle()
                    .trim(from: 0, to: CGFloat(completionRate))
                    .stroke(Color.white, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut(duration: 0.6), value: completionRate)
            }
            .frame(width: 50, height: 50)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
        )
        .padding(.horizontal)
        .shadow(color: .blue.opacity(0.2), radius: 10, x: 0, y: 8)
    }
    
    private var habitListSection: some View {
        VStack(spacing: 16) {
            ForEach(viewModel.habits) { habit in
                HabitCardView(habit: habit) {
                    viewModel.toggleHabit(habit: habit)
                }
                .contextMenu {
                    Button(role: .destructive) {
                        if let index = viewModel.habits.firstIndex(where: { $0.id == habit.id }) {
                            viewModel.deleteHabit(at: IndexSet(integer: index))
                        }
                    } label: {
                        Label("Delete", image: "trash")
                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 12) {
            Image(systemName: "sparkles")
                .font(.largeTitle)
                .foregroundStyle(.secondary)
            Text("No habits set up yet.")
                .font(.headline)
                .foregroundStyle(.secondary)
            Text("Tap the '+' icon above to start your tracking journey.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 40)
    }
}
