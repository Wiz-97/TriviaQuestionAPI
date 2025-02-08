import SwiftUI

struct TriviaListView: View {
    @StateObject var viewModel = TriviaViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.questions) { question in
                        NavigationLink(destination: TriviaDetailView(question: question)) {
                            VStack(alignment: .leading) {
                                Text(question.category)
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                
                                HStack {
                                    Text(question.type.uppercased())
                                        .font(.subheadline)
                                        .bold()
                                    Spacer()
                                    Text("Difficulty: \(question.difficulty.capitalized)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
                        }
                        .padding(.horizontal)
                    }

                    if viewModel.isLoading {
                        ProgressView("Loading more questions...")
                    } else {
                        Button("Load More") {
                            Task {
                                await viewModel.fetchTriviaQuestions()
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Trivia Questions")
        }
    }
}

#Preview {
    TriviaListView()
}
