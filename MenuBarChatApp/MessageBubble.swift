import SwiftUI

struct MessageBubble: View {
    let message: Message
    
    var body: some View {
        HStack {
            if message.role == .user { Spacer() }
            
            Text(message.content)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(message.role == .user ? Color.accentColor : Color(.windowBackgroundColor))
                .foregroundColor(message.role == .user ? .white : .primary)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(
                            message.role == .user ? Color.clear :
                                Color(.separatorColor).opacity(0.5),
                            lineWidth: 1
                        )
                )
                .frame(maxWidth: 240, alignment: message.role == .user ? .trailing : .leading)
            
            if message.role == .assistant { Spacer() }
        }
    }
}
