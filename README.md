# MenuBarChatApp

MenuBarChatApp is a macOS menu bar application that enables users to chat with OpenAI's GPT-4 model using Azure's OpenAI Service. It provides an intuitive chat interface with a lightweight, easily accessible design integrated into the macOS menu bar.

## Features

- A menu bar application for quick access to Azure's OpenAI-powered chatbot.
- Intuitive chat interface with message bubbles for user and assistant responses.
- Dynamic response generation with a loading indicator while waiting for replies.
- Secure API key management using a `config.plist` file.

## Setup Instructions

### 1. Clone the Repository
```bash
git clone <repository-url>
cd MenuBarChatApp
```

### 2. Configure the API Key

The app securely loads the Azure OpenAI Service API key from a `config.plist` file.

1. Locate the `example.config.plist` file in the project.
2. Duplicate the file and rename it to `config.plist`.
3. Add your Azure API key:
   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
   <plist version="1.0">
   <dict>
       <key>AZURE_API_KEY</key>
       <string>your_actual_api_key_here</string>
   </dict>
   </plist>
   ```

4. **Ensure the API key is not pushed to GitHub:**
   - Check the `.gitignore` file contains:
     ```
     config.plist
     ```

### 3. Set Up Azure OpenAI Service

1. Log in to the [Azure Portal](https://portal.azure.com/).
2. Create an **Azure OpenAI Service** resource.
3. Deploy the GPT-4 model and note the deployment name (e.g., `gpt-4o`).
4. Retrieve the **API endpoint** and **API key** from the Azure dashboard.
5. Update the endpoint in the `AzureOpenAIService` class:
   ```swift
   private let endpoint = "https://<your-resource-name>.openai.azure.com/openai/deployments/<deployment-id>/chat/completions?api-version=2023-03-15-preview"
   ```

### 4. Build and Run the App

1. Open the project in Xcode:
   ```bash
   open MenuBarChatApp.xcodeproj
   ```
2. Select your Mac as the target device.
3. Build and run the app using the Play button in Xcode.
4. The app icon will appear in your Mac's menu bar.

## How the App Works

1. **Menu Bar Access**:
   - The app runs in the macOS menu bar for quick access.
   - Clicking the menu bar icon opens a popover displaying the chat interface.

2. **Chat Interface**:
   - Users can type messages in the input field at the bottom.
   - A loading indicator (`Generating...`) appears while the assistant generates a response.
   - Messages are displayed in a scrollable chat history, with distinct styles for user and assistant messages.

## Code Structure

### 1. Files Overview
- **`MenuBarChatAppApp.swift`**:
  - Configures the app as a menu bar application using an `NSApplicationDelegate`.
  - Handles popover management for the chat interface.

- **`ContentView.swift`**:
  - The main chat interface, including:
    - Chat history.
    - Input field.
    - "Submit" button with dynamic loading state.

- **`ChatViewModel.swift`**:
  - Manages:
    - Chat messages (`[Message]`).
    - User input state (`userInput`).
    - Loading state (`isLoading`).
  - Sends requests to Azure OpenAI using `AzureOpenAIService`.

- **`AzureOpenAIService.swift`**:
  - Handles HTTP requests to Azure OpenAI Service.
  - Loads the API key securely from `config.plist`.
  - Processes API responses and errors.

- **`MessageBubble.swift`**:
  - A reusable SwiftUI component for rendering chat messages.
  - Styles messages differently for user and assistant roles.

- **`Message.swift`**:
  - A simple model representing a chat message with:
    - `id`: A unique identifier.
    - `role`: The message sender (`user` or `assistant`).
    - `content`: The message text.

### 2. Key Classes

#### AzureOpenAIService
- Manages communication with Azure OpenAI Service.
- Sends user input as a prompt and processes the AI-generated response.
- Uses `URLSession` for networking and JSON parsing for response handling.

#### ChatViewModel
- A SwiftUI `ObservableObject` that:
  - Updates the chat UI with new messages.
  - Tracks the loading state during response generation.
  - Formats and sends user input to `AzureOpenAIService`.

#### MessageBubble
- A custom SwiftUI view for chat bubbles.
- Displays user messages on the right and assistant responses on the left.

## Design Details

### UI Design
- The app follows macOS design conventions with system colors and fonts.
- Minimalistic design with clear distinctions between user and assistant messages.

### Error Handling
- Displays error messages (e.g., "Error: Invalid URL") in the chat history when API calls fail.
- Prevents submission of empty messages.

## Example Screenshot

Here's what the app looks like:

<img src="https://github.com/AjinkyaSambare/MenuBarChatApp_MacOS/blob/main/image.png" alt="MenuBarChatApp Screenshot" width="400"/>

## Known Issues
- Ensure your API key and endpoint are correctly configured.
- Network errors may occur if the API endpoint or key is invalid.

## Future Enhancements
- Add local storage for chat history.
- Support additional models and customization options.
- Provide an option for dark mode styling.

## Credits
- Developed by Ajinkya, Intern at Idealabs, under the guidance of the Idealabs team, 2024.
- Powered by [Azure OpenAI Service](https://azure.microsoft.com/en-us/products/cognitive-services/openai-service/).

## License
This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.
