import Foundation
import SwiftUI

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var userInput: String = ""
    @Published var isLoading: Bool = false

    func sendMessage() {
        guard !userInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }

        let userMessage = Message(role: .user, content: userInput)
        messages.append(userMessage)
        userInput = ""
        isLoading = true // Start loading

        AzureOpenAIService.shared.sendRequest(prompt: userMessage.content) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false // Stop loading
                switch result {
                case .success(let reply):
                    self?.messages.append(Message(role: .assistant, content: reply))
                case .failure(let error):
                    self?.messages.append(Message(role: .assistant, content: "Error: \(error.localizedDescription)"))
                }
            }
        }
    }
}
