import Foundation

struct TriviaQuestion: Codable, Identifiable {
    var id: String { "\(category)-\(question)" }
    
    let category: String
    let type: String
    let difficulty: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]

    enum CodingKeys: String, CodingKey {
        case category
        case type
        case difficulty
        case question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }

    // Decode HTML Entities for the question and answers
    var decodedCategory: String {
        category.htmlDecoded()
    }
    
    var decodedQuestion: String {
        question.htmlDecoded()
    }
    
    var decodedCorrectAnswer: String {
        correctAnswer.htmlDecoded()
    }
    
    var decodedIncorrectAnswers: [String] {
        incorrectAnswers.map { $0.htmlDecoded() }
    }

    // Shuffle answers for display
    var allAnswers: [String] {
        (decodedIncorrectAnswers + [decodedCorrectAnswer]).shuffled()
    }
}


// TriviaResponse struct for decoding the entire response
struct TriviaResponse: Codable {
    let results: [TriviaQuestion]
}

// Extension for decoding HTML entities
extension String {
    func htmlDecoded() -> String {
        guard let data = self.data(using: .utf8) else { return self }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        if let decoded = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
            return decoded.string
        }
        return self
    }
}
