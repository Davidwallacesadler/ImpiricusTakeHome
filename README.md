# Impiricus Take Home
A simple native iOS application that displays engagement messages which can be checked for compliance policy violations.

## Setup
- Install the latest version of Xcode (latest version as of writing: 26.0)
- Clone the project
- Open the project in Xcode and allow Package Dependencies to be resolved
- Run the project

## Architecture Overview
This project roughly follows "Clean" architecture patterns where we have a clear separation between the Data, Domain, and Presentation layers in the application.

The project is split into 4 major directories:
1. **Data**: Contains all DataSources and DTO models. This is where all external data should flow whether from an external API or local resource.
2. **Domain**: Contains all Repositories and Domain models. This is where DTOs are fetched and transformed into domain objects that are more suitable for the presentation layer.
3. **Presentation**: Contains all Views and ViewModels. This is where repositories and ViewModels come together to provide the display data and handle user actions.
4. **Resources**: Contains all non-source code related files. This is where project assets and the mock data files live.

Example data flow:
```
User starts the app ->
  Message List Screen loads ->
  View calls to its ViewModel to load from messages repository ->
  Repository calls to its provided MessageDataSource ->
  DataSource fetches MessageDTO data and returns it ->
  Repository receives DTOs and transforms them into Domain Messages ->
  ViewModel updates observed Messages property ->
  View sees changes in ViewModel and refreshes the display
```
## Key Tradeoffs and Decisions
1. **Clean Architecture**: This is a good pattern for most apps, but maybe could be seen as slightly over-engineered for this problem as there is a decent amount of ceremony in setting up all the layers. For me, I think the tradeoff is worth it for better separation of concerns between the Data, Domain, and Presentation layers of the application.
2. **Mocked API for Messages, Physicians, Compliance Rules**: I chose to use a Mocked API for reading the provided resource files. This took more time to setup but allows for the project to grow more organically if this was transitioned into a production application.
3. **Synchronous Filtering**: Filtering the messages list all happens synchronously (and on the main thread). This was used for expediency and in an effort to get to the main functional pieces of the app working but could be very problematic in a production application with very large data sources.
4. **SwiftCSV Dependency**: Given the time constraints, I reached for the `SwiftCSV` Swift Package to parse the `csv` resources into DTOs. Given the sensitive nature of the data handled by the application and the increasing prevalence of dependency supply-chain attacks I would prefer to not have a dependency like this. With more time I would probably just write my own utility/package for `csv` parsing (or fork `SwiftCSV`) and host it in the company's GitHub to eliminate this vulnerability.

## Next Steps
1. **Better Unit Test Coverage**: I did not have time to add proper unit testing for ViewModel methods so adding better testable (pure) functions to the ViewModel and adding tests for them would be a solid next step.
2. **Improve Filtering**: Currently, filtering messages by physician and date range all happen synchronously on the main thread which could cause an ANR/jank if the messages list was very large. It would be great to improve the filtering experience for large data sets.
3. **Improve Accessibility**: The app needs accessibility Identifiers and Actions to be properly accessible by screen readers (i.e better accessibility descriptions for rows, better accessibility actions for buttons and controls).
4. **Improve Logging**: The app swallows a lot of exceptions and doesn't have the best error propigation. A robust logging system along with better error propigation would definitely be needed for future development.
5. **Analytics**: The app could use a generic Analytics layer that could be plugged into any kind of provider such as DataDog.
