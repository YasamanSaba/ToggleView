import SwiftUI

struct ToggleView: View {
    // MARK: - Properties
    @Binding var isOn: Bool
    let textLabel: String
    let colorIsOnText: Color
    let colorOffText: Color
    let rectMainColor: Color
    let strokeLineColor: Color
    let toggleColor: Color
    let toggleOffColor: Color
    // MARK: - Body
    var body: some View {
        HStack {
            Text(textLabel)
                .font(.body)
                .foregroundColor(isOn ? colorIsOnText : colorOffText)
            Toggle("", isOn: $isOn)
                .toggleStyle(PowerToggleStyle(rectMainColor: rectMainColor, strokeLineColor: strokeLineColor, toggleColor: toggleColor, toggleOffColor: toggleOffColor))
        }
        .frame(height: 43)
        .padding(.horizontal)
    }
}

// MARK: - Preview
struct ToggleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ToggleView(isOn: .constant(false), textLabel: "Toggle View", colorIsOnText: Color.green, colorOffText: Color.gray, rectMainColor: Color.blue, strokeLineColor: Color.orange, toggleColor: Color.red, toggleOffColor: Color.black)
                .previewLayout(.sizeThatFits)
            ToggleView(isOn: .constant(true), textLabel: "Toggle View", colorIsOnText: Color.green, colorOffText: Color.gray, rectMainColor: Color.blue, strokeLineColor: Color.orange, toggleColor: Color.red, toggleOffColor: Color.black)
                .previewLayout(.sizeThatFits)
        }
    }
}

// MARK: - Custom Toggle Style
struct PowerToggleStyle: ToggleStyle {
    // MARK: - Properties
    let rectMainColor: Color
    let strokeLineColor: Color
    let toggleColor: Color
    let toggleOffColor: Color
    
    // MARK: - Functions
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Rectangle()
                .foregroundColor(rectMainColor)
                .frame(width: 66.6, height: 27.3)
                .overlay(
                    HStack {
                        Spacer()
                        Circle()
                            .stroke(strokeLineColor, lineWidth: 1)
                            .frame(width: 10, height: 10)
                            .padding(.trailing, 9)
                    }
                )
                .overlay(
                    HStack {
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 1.5)
                            .foregroundColor(toggleColor)
                            .padding([.top, .bottom, .trailing], 10)
                            .padding(.leading, 15)
                        Spacer()
                    }
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 45)
                        .foregroundColor(configuration.isOn ? toggleColor : toggleOffColor)
                        .overlay(
                            HStack(spacing: 3) {
                                if configuration.isOn {
                                    RoundedRectangle(cornerRadius: 25)
                                        .frame(width: 1.5)
                                        .foregroundColor(strokeLineColor)
                                    RoundedRectangle(cornerRadius: 25)
                                        .frame(width: 1.5)
                                        .foregroundColor(strokeLineColor)
                                    RoundedRectangle(cornerRadius: 25)
                                        .frame(width: 1.5)
                                        .foregroundColor(strokeLineColor)
                                    Spacer()
                                } else {
                                    Spacer()
                                    RoundedRectangle(cornerRadius: 25)
                                        .frame(width: 1.5)
                                        .foregroundColor(strokeLineColor)
                                    RoundedRectangle(cornerRadius: 25)
                                        .frame(width: 1.5)
                                        .foregroundColor(strokeLineColor)
                                    RoundedRectangle(cornerRadius: 25)
                                        .frame(width: 1.5)
                                        .foregroundColor(strokeLineColor)
                                }
                                
                            }.padding(10)
                        )
                        .offset(x: configuration.isOn ? 11 : -11, y: 0)
                        .animation(Animation.linear(duration: 0.1))

                )

                .cornerRadius(20)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
}
