import Foundation

// TriviaQuestion struct
struct TriviaQuestion: Codable, Identifiable {
    let id = UUID()  // Unique identifier for SwiftUI lists
    let category: String
    let type: String
    let difficulty: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]

    // Map API's JSON keys to our Swift properties
    enum CodingKeys: String, CodingKey {
        case category
        case type
        case difficulty
        case question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }

    // Decode HTML Entities for the question and answers
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
        guard let data = data(using: .utf8) else { return self }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        return (try? NSAttributedString(data: data, options: options, documentAttributes: nil).string) ?? self
    }
}
