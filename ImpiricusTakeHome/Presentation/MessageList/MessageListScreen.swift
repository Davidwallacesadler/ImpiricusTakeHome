//
//  MessageListScreen.swift
//  ImpiricusTakeHome
//
//  Created by David Sadler on 2/25/26.
//

import SwiftUI

struct MessageListScreen: View {
    
    @State private var viewModel: MessageListViewModel
    
    init() {
        _viewModel = State(
            initialValue: MessageListViewModel(
                messagesRepo: MessageRepository(dataSource: MockMessageDataSource()),
                physicianRepo: PhysicianRepository(dataSource: MockPhysicianDataSource())
            )
        )
    }
    
    var body: some View {
        NavigationStack {
            List {
                if !viewModel.isLoading {
                    Section {
                        ForEach(viewModel.displayMessages) { message in
                            MessageRow(
                                message: message,
                                physicianName: viewModel.physicianIDToPhysicianName[message.physicianID]
                            )
                        }
                    } header: {
                        ScrollView(.horizontal) {
                            HStack {
                                FilterChipButton(
                                    text: viewModel.filterPhysician?.name ?? "Select a Physician",
                                    hasSelection: viewModel.filterPhysician != nil,
                                    onChipTapped: viewModel.onPhysicianFilterButtonTapped,
                                    onClearTapped: viewModel.onPhysicianFilterClearButtonTapped
                                )
                                
                                FilterChipButton(
                                    text: viewModel.displayFilterRange ?? "Select a Date Range",
                                    hasSelection: viewModel.filterDateRange != nil,
                                    onChipTapped: viewModel.onDateRangeFilterButtonTapped,
                                    onClearTapped: viewModel.onDateRangeClearButtonTapped
                                )
                            }
                            .padding(.bottom, 12)
                        }
                    }
                }
            }
            .navigationTitle("Messages")
            .task {
                await viewModel.fetchAllData()
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(1.5)
                }
            }
            .sheet(item: $viewModel.sheetType) { sheetType in
                switch sheetType {
                case .physicianSelect:
                    PhysicianPickerScreen(
                        physicians: viewModel.physicians,
                        selection: $viewModel.filterPhysician
                    )
                    .presentationDetents([.medium, .large])
                case .dateRangeSelect:
                    DateRangePickerScreen(dateRange: $viewModel.filterDateRange)
                    .presentationDetents([.medium, .large])
                }
            }
        }
    }
}

// MARK: - SubViews

private struct FilterChipButton: View {
    
    let text: String
    let hasSelection: Bool
    let onChipTapped: () -> Void
    let onClearTapped: () -> Void
    
    var body: some View {
        HStack(spacing: 4) {
            Button {
                onChipTapped()
            } label: {
                Text(text)
                    .foregroundStyle(Color.white)
                    .font(.headline)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(hasSelection ? Color.blue : Color.gray, in: Capsule())
            }
            
            if hasSelection {
                Button {
                    onClearTapped()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(Color.white)
                        .font(.headline)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue, in: Circle())
                }
            }
        }
    }
}
