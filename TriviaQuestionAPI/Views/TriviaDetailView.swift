import SwiftUI

struct TriviaDetailView: View {
    let question: TriviaQuestion
    @State private var selectedAnswer: String? = nil
    @State private var isAnswered = false

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(question.decodedQuestion)  // FIX: Use decodedQuestion
                .font(.title2)
                .bold()
            
            ForEach(question.allAnswers, id: \.self) { answer in
                Button(action: {
                    selectedAnswer = answer
                    isAnswered = true
                }) {
                    Text(answer.htmlDecoded())  // FIX: Decode each answer
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedAnswer == answer ? (answer == question.decodedCorrectAnswer ? Color.green : Color.red) : Color.blue.opacity(0.3))
                        .cornerRadius(10)
                        .foregroundColor(.black)
                }
            }

            if isAnswered {
                Text(selectedAnswer == question.decodedCorrectAnswer ? "🎉 Correct!" : "❌ Wrong! Correct answer: \(question.decodedCorrectAnswer)")
                    .font(.headline)
                    .foregroundColor(selectedAnswer == question.decodedCorrectAnswer ? .green : .red)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Trivia Question")
    }
}
