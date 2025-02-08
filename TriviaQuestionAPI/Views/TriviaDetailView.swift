import SwiftUI

struct TriviaDetailView: View {
    let question: TriviaQuestion
    @State private var selectedAnswer: String? = nil
    @State private var isAnswered = false

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(question.question)
                .font(.title2)
                .bold()
            
            ForEach(question.allAnswers, id: \.self) { answer in
                Button(action: {
                    selectedAnswer = answer
                    isAnswered = true
                }) {
                    Text(answer)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedAnswer == answer ? (answer == question.correctAnswer ? Color.green : Color.red) : Color.blue.opacity(0.3))
                        .cornerRadius(10)
                        .foregroundColor(.black)
                }
            }

            if isAnswered {
                Text(selectedAnswer == question.correctAnswer ? "🎉 Correct!" : "❌ Wrong! Correct answer: \(question.correctAnswer)")
                    .font(.headline)
                    .foregroundColor(selectedAnswer == question.correctAnswer ? .green : .red)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Trivia Question")
    }
}
