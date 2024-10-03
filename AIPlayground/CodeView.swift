import SwiftUI
import MarkdownUI
import Splash

struct CodeTextView: View {
    
    let content: String
    
    var body: some View {
        Markdown(content)
          .markdownBlockStyle(\.codeBlock) {
            codeBlock($0)
          }
          .markdownCodeSyntaxHighlighter(.splash(theme: self.theme))
    }

    @ViewBuilder
    private func codeBlock(_ configuration: CodeBlockConfiguration) -> some View {
      VStack(spacing: 0) {
        HStack {
          Text(configuration.language ?? "plain text")
            .font(.system(.caption, design: .monospaced))
            .fontWeight(.semibold)
            .foregroundColor(Color(theme.plainTextColor))
          Spacer()

          Image(systemName: "clipboard")
            .onTapGesture {
              copyToClipboard(configuration.content)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background {
          Color(theme.backgroundColor)
        }

        Divider()

        ScrollView(.horizontal) {
          configuration.label
            .relativeLineSpacing(.em(0.25))
            .markdownTextStyle {
              FontFamilyVariant(.monospaced)
              FontSize(.em(0.85))
            }
            .padding()
        }
      }
      .background(Color(.secondarySystemBackground))
      .clipShape(RoundedRectangle(cornerRadius: 8))
      .markdownMargin(top: .zero, bottom: .em(0.8))
    }

    private var theme: Splash.Theme {
        .sunset(withFont: .init(size: 16))
    }

    private func copyToClipboard(_ string: String) {
      #if os(macOS)
        if let pasteboard = NSPasteboard.general {
          pasteboard.clearContents()
          pasteboard.setString(string, forType: .string)
        }
      #elseif os(iOS)
        UIPasteboard.general.string = string
      #endif
    }
}
