//
//  ContentView.swift
//  Calculator Application
//
//  Created by Tochukwu Ozurumba on 14/07/2022.
//

import SwiftUI

// declare calculator characters
enum CalculatorButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "/"
    case multiply = "*"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    //    define background colors by character
    var buttonColorConfig: Color {
        switch self {
        case .add, .subtract, .divide, .multiply, .equal:
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}

enum Operator {
    case add, subtract, multiply, divide, none
}

struct ContentView: View {
//    declare state
    @State var value = "0"
    
    @State var currentOperator: Operator = .none
    
    @State var currentOperationalValue = 0
    
//    assign cal button posiiton using multidimensional array
    let buttons: [[CalculatorButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    
    
    var body: some View {
//        create view for zstack
        ZStack {
//            assign full color
            Color.black.edgesIgnoringSafeArea(.all)
            
//            assign a vertical stack
            VStack {
                Spacer()
                
//                Text Display
                HStack {
//                    push codes to side (float)
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                }
                .padding()
                
//                button display
//                loop through the multidimensional array to create view
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
//                                define action for each button
                                self.clickButton(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight()
                                    )
                                    .background(item.buttonColorConfig)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item) / 2)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    
    // define button width function to define button width via screen
    // this will help with media queries and screen adaptation
    func buttonWidth(item: CalculatorButton) -> CGFloat {
        if (item == .equal) {
            return ((UIScreen.main.bounds.width - (4 * 12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }

    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    
//    process value when a button is clicked
    func clickButton(button: CalculatorButton) {
//        define action for each button
        
        switch button {
        case .add, .subtract, .divide, .multiply, .equal:
            if (button == .add) {
                
                self.currentOperator = .add
                self.currentOperationalValue = Int(self.value) ?? 0
                
            } else if button == .subtract {
                
                self.currentOperator = .subtract
                self.currentOperationalValue = Int(self.value) ?? 0
                
            } else if button == .divide {
                
                self.currentOperator = .divide
                self.currentOperationalValue = Int(self.value) ?? 0
                
            } else if button == .multiply {
                
                self.currentOperator = .multiply
                self.currentOperationalValue = Int(self.value) ?? 0
                
            } else if button == .equal {
                
//                this is more tricking, its the reason behind why we are storing the currentOperator state
                let currentValue = Int(self.value) ?? 0
                
//                when equal button is clicked, the current operator in use then will finilize the operation
//                so i need to know which was the current operator in use before the equal size
                switch currentOperator {
                case .add: self.value = "\(self.currentOperationalValue + currentValue)"
                case .subtract: self.value = "\(self.currentOperationalValue - currentValue)"
                case .multiply: self.value = "\(self.currentOperationalValue * currentValue)"
                case .divide: self.value = "\(self.currentOperationalValue / currentValue)"
               case .none:
                    break
                }
            }
            
//            reset screen value when a number is clicked and stored in currentOperationalValue
            if (button != .equal) {
                self.value = "0"
            }
        case .negative, .decimal, .percent:
            break
        case .clear:
            self.value = "0"
        default:
            let clickedValue = button.rawValue
            
            if self.value == "0" {
                value = clickedValue
            } else {
                self.value = "\(self.value)\(clickedValue)"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//NOTE: Most of the resources used here for this assignment was gotten from AfrazCodes, that's github username

