import Foundation

@MainActor
class TriviaViewModel: ObservableObject {
    @Published var questions: [TriviaQuestion] = []
    @Published var isLoading = false
    private var currentPage = 1

    init() {
        Task {
            await fetchTriviaQuestions()
        }
    }

    func fetchTriviaQuestions() async {
        guard !isLoading else { return }
        isLoading = true
        
        let urlString = "https://opentdb.com/api.php?amount=10&page=\(currentPage)&type=multiple"
        guard let url = URL(string: urlString) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(TriviaResponse.self, from: data)
            
            DispatchQueue.main.async {
                self.questions.append(contentsOf: decodedResponse.results)
                self.isLoading = false
                self.currentPage += 1
            }
        } catch {
            print("Error fetching trivia:", error)
            isLoading = false
        }
    }
}
