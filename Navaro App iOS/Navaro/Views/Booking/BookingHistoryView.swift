//
//  BookingHistoryView.swift
//  Navaro
//
//  Created by Guest User on 2025-09-09
//

import SwiftUI

struct BookingHistoryView: View {
    @StateObject private var viewModel = BookingViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    
                    if !viewModel.upcomingBookings.isEmpty {
                        Text("Upcoming Bookings")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)

                        ForEach(viewModel.upcomingBookings) { booking in
                            BookingCardView(booking: booking)
                        }
                    }

                    Divider().padding(.horizontal)

                    if !viewModel.pastBookings.isEmpty {
                        Text("Past Bookings")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)

                        ForEach(viewModel.pastBookings) { booking in
                            BookingCardView(booking: booking)
                        }
                    }
                }
                .padding(.bottom, 30)
            }
        }
        .onAppear {
            viewModel.fetchBookings()
        }
    }
}


struct BookingCardView: View {
    let booking: Booking
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(booking.hotelName)
                .font(.headline)
                .foregroundColor(.darkBlue)

            Text("\(formattedDate(booking.checkIn)) - \(formattedDate(booking.checkOut))")
                .font(.subheadline)
                .foregroundColor(.gray)

            Text("Rooms: \(booking.rooms)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            HStack {
                Text("$\(String(format: "%.2f", booking.price))")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.lightBlue)
                Spacer()
                Text(booking.status)
                    .font(.caption)
                    .padding(6)
                    .background(booking.status == "Confirmed" ? Color.green.opacity(0.2) : Color.gray.opacity(0.2))
                    .foregroundColor(booking.status == "Confirmed" ? .green : .gray)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .gray.opacity(0.15), radius: 5, x: 0, y: 3)
        .padding(.horizontal)
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}



#Preview {
    BookingHistoryView()
}
