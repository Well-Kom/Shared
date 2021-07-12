//
//  QuestionCardView.swift
//  QuestionnaireSample
//
//  Created by Lokesh Sahni on 28/06/21.
//

//
//  CardView.swift
//  SwipeableCards
//
//  Created by Brandon Baars on 1/9/20.
//  Copyright © 2020 Brandon Baars. All rights reserved.
//

import SwiftUI

struct QuestionCardView: View {
    @State private var translation: CGSize = .zero
    @State private var swipeStatus: LikeDislike = .none
    
    private var question: Question
    private var onRemove: (_ question: Question) -> Void
    
    private var thresholdPercentage: CGFloat = 0.5 // when the user has draged 50% the width of the screen in either direction
    
    private enum LikeDislike: Int {
        case like, dislike, none
    }
    
    init(question: Question, onRemove: @escaping (_ question: Question) -> Void) {
        self.question = question
        self.onRemove = onRemove
    }
    
    /// What percentage of our own width have we swipped
    /// - Parameters:
    ///   - geometry: The geometry
    ///   - gesture: The current gesture translation value
    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                 ZStack(alignment: self.swipeStatus == .like ? .topLeading : .topTrailing) {

                    VStack {
                        
                        HStack{
                        Text(question.question)
                            .font(.title)
                            .bold()
                            .padding()
                            .frame(width: 300, height: 50, alignment: .topLeading)
                            Spacer()
                        }
                        
                        Divider()

                        RadioButtonGroup(items: question.options, selectedId: "") { selected in
                            print("Selected is: \(selected)")
                        }.padding()
                        
                        Divider()
                        
                    }.padding()
                    
                    if self.swipeStatus == .like {
                        Text("SAVED")
                            .font(.headline)
                            .padding()
                            .cornerRadius(10)
                            .foregroundColor(Color.green)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.green, lineWidth: 3.0)
                        ).padding(24)
                            .rotationEffect(Angle.degrees(-45))
                    } else if self.swipeStatus == .dislike {
                        Text("DISLIKE")
                            .font(.headline)
                            .padding()
                            .cornerRadius(10)
                            .foregroundColor(Color.red)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.red, lineWidth: 3.0)
                        ).padding(.top, 45)
                            .rotationEffect(Angle.degrees(45))
                    }
                }
                
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Show progress here ... ")
                            .font(.subheadline)
                            .bold()
                        Text("A progress bar can be shown here ..")
                            .font(.subheadline)
                            .bold()

                    }
                    Spacer()
                    
                    Image(systemName: "info.circle")
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .animation(.interactiveSpring())
            .offset(x: self.translation.width, y: 0)
            .rotationEffect(.degrees(Double(self.translation.width / geometry.size.width) * 25), anchor: .bottom)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.translation = value.translation
                        
                        if (self.getGesturePercentage(geometry, from: value)) >= self.thresholdPercentage {
                            self.swipeStatus = .like
                        } else if self.getGesturePercentage(geometry, from: value) <= -self.thresholdPercentage {
                            self.swipeStatus = .dislike
                        } else {
                            self.swipeStatus = .none
                        }
                        
                }.onEnded { value in
                    // determine snap distance > 0.5 aka half the width of the screen
                        if abs(self.getGesturePercentage(geometry, from: value)) > self.thresholdPercentage {
                            self.onRemove(self.question)
                        } else {
                            self.translation = .zero
                        }
                    }
            )
        }
    }
}

// 7
struct QuestionCardView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionCardView(question: Question(id: 0, question: "Physical Health", options: ["Very dissatisfied","Dissatisfied","Neutral","Satisfied","Very satisfied"],selectedanswer: ""),
                 onRemove: { _ in
                    // do nothing
            })
            .frame(height: 400)
            .padding()
    }
}
