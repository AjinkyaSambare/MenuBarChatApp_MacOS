import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ChatViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("Azure AI Chat")
                    .font(.headline)
                Spacer()
                Button(action: {
                    NSApp.terminate(nil)
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
                .buttonStyle(.plain)
            }
            .padding()
            .background(Color(.windowBackgroundColor))
            
            Divider()
            
            // Chat History
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.messages) { message in
                            MessageBubble(message: message)
                                .id(message.id)
                        }
                    }
                    .padding()
                }
                .onChange(of: viewModel.messages.count) { _ in
                    if let lastMessage = viewModel.messages.last {
                        withAnimation {
                            proxy.scrollTo(lastMessage.id, anchor: .bottom)
                        }
                    }
                }
            }
            
            Divider()
            
            // Input Area
            // Input Area
            HStack(spacing: 8) {
                TextField("Type your message...", text: $viewModel.userInput)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(8)
                    .background(Color(.textBackgroundColor))
                    .cornerRadius(8)
                    .disabled(viewModel.isLoading)
                
                if viewModel.isLoading {
                    HStack {
                        Text("Generating..")
                            .foregroundColor(.gray)
                            .font(.caption)
                        ProgressView()
                            .scaleEffect(0.8)
                    }
                    .padding(.horizontal, 8)
                } else {
                    Button(action: viewModel.sendMessage) {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(
                                viewModel.userInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                                ? .gray
                                : .accentColor
                            )
                    }
                    .buttonStyle(.plain)
                    .disabled(viewModel.userInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
            .padding(12)
            .background(Color(.windowBackgroundColor))
        }
    }
}



#Preview {
    ContentView()
}
