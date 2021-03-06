//
//  GearRatio.swift
//  Calcubot2
//
//  Created by Student on 2022-04-19.
//

import SwiftUI

struct GearRatio: View {
    @ObservedObject var userInput = UserInputStages()
    
    @State var ifFunctionCalled: Bool = false
    
    var isShowingInputError: Bool{
        return ifFunctionCalled && userInput.Input[0].isEmpty
    }
    
    func GetDisplayValues(inDriven : String, inDriving : String) -> (Float, Float) {
        if let floatDriven = Float(inDriven), let floatDriving = Float(inDriving) {
            var scaleDriven, scaleDriving : Float
            
            let total = floatDriven + floatDriving
            
            scaleDriven = floatDriven / total
            scaleDriving = floatDriving / total
            
            return ( scaleDriven, scaleDriving )
        } else {
            return (0.9, 0.6)
        }
    }
    
    var AnimationView: some View {
        let (driven, driving) = GetDisplayValues(inDriven: userInput.Driven, inDriving: userInput.Driving)
        
        return HStack(spacing:0){
            RotatingCircleView(fill: .purple, scale: CGFloat(driven), direction: .right)
            
            RotatingCircleView(fill: .green, scale: CGFloat(driving), direction: .left)
            
        }
    }
    
    var Overlay: some View {
        VStack{
            VStack(){
                Text("Final Ratio Diagram")
                    .font(.title)
                
                Rectangle()
                    .frame(width: 350, height: 200)
                    .foregroundColor(.lightGrey)
                    .cornerRadius(10)
                    .overlay(AnimationView)
                HStack{
                    VStack{
                        Text("Input:")
                            .foregroundColor(isShowingInputError ? .red : .black)
                            .background {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.myOrange)
                            }
                            .padding()
                        Text("Output:")
                            .foregroundColor(isShowingInputError ? .red : .black)
                            .background {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.myBlue)
                            }
                            .padding()
                    }
                    ForEach(0..<userInput.StagesAdd, id: \.self) { index in
                        VStack{
                            TextField("Placeholder", text: $userInput.Input[index])
                                .keyboardType(.numbersAndPunctuation)
                                .foregroundColor(Color.red)
                                .background {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(Color.lightGrey)
                                }
                                .padding()
                            TextField("Placeholder", text: $userInput.Output[index])
                                .keyboardType(.numbersAndPunctuation)
                                .foregroundColor(Color.red)
                                .background {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(Color.lightGrey)
                                }
                                .padding()
                        }
                    }
                    
                    
                }
                
            }
            VStack{
                HStack {
                    Button {
                        userInput.AnswerFormatter()
                    } label: {
                        Text("Calculate")
                            .foregroundColor(Color.blue)
                            .padding()
                            .background{
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.myButton)
                            }
                            .padding()
                    }
                    Button {
                        userInput.StageAdded()
                    } label: {
                        Text("Add Stage")
                            .foregroundColor(Color.myButton)
                            .padding()
                            .background{
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(.blue)
                            }
                            .padding()
                    }
                    //.disabled(userInput.StagesAdd == 3)
                    Button {
                        userInput.StageRemoved()
                    } label: {
                        Text("Remove Stage")
                            .foregroundColor(Color.myButton)
                            .padding()
                            .background{
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(.red)
                            }
                            .padding()
                    }
                    .disabled(userInput.StagesAdd == 1)
                }
                //on keyboard press "Return"
                
                HStack{
                    Text("Answer:")
                        .background {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.lightGrey)
                        }
                        .padding()
                    Text(String(userInput.Answer))
                        .foregroundColor(Color.red)
                        .background {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.lightGrey)
                        }
                        .padding()
                }
            }
        }
    }
    
    var body: some View {
        Rectangle().fill(Color.myBackGround)
            .edgesIgnoringSafeArea(.all)
            .overlay(Overlay)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Gear Ratio Finder").font(.largeTitle)
                        .foregroundColor(Color.lightGrey)
                }
            }
    }
}


struct GearRatio_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            
            NavigationView {
                GearRatio()
            }
            
            GearRatio()
        }
    }
}
