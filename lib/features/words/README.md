# Words List Feature

This feature implements a comprehensive memory training system using spaced repetition for word lists.

## Architecture

### Domain Layer

- **Entities**: `WordList`, `StudySession`, `WordResult` with Freezed for immutability
- **Repository Interface**: `WordListRepository` for data access abstraction
- **Use Cases**:
  - `StudyWordListUseCase` - Handle study sessions and SRS updates
  - `CreateWordListUseCase` - Create new word lists
  - `GetDailyWordListsUseCase` - Fetch curated daily content
  - `GetUserWordListsUseCase` - User's personal word lists
  - `GetDueWordListsUseCase` - Lists due for review

### Data Layer

- **Models**: `WordListModel`, `StudySessionModel` with Firestore conversion
- **Repository Implementation**: `WordListRepositoryImpl` with Firebase Firestore

### Presentation Layer

- **Providers**: Riverpod providers for state management and data flow
- **Pages**:
  - `StudySessionPage` - Interactive memory training session
  - `CreateWordListPage` - Create personal word lists
- **Widgets**: Updated `WordsSection` with real data integration

## Features

### Spaced Repetition System (SRS)

- SM-2 algorithm implementation
- Automatic scheduling based on performance
- Difficulty adjustment based on user success

### Study Modes

- **Memorization**: Show word, test recall
- **Recall**: Memory-based word recognition
- **Recognition**: Multiple choice (future)

### Daily Content

- Curated word lists refreshed daily
- Multiple categories (Animals, Objects, Colors, etc.)
- Difficulty levels (Facile, Moyen, Difficile)

### User-Generated Content

- Create custom word lists
- Category assignment
- Automatic SRS integration

## Firebase Structure

### Collections

```
daily_word_lists/
  {wordListId}/
    title: string
    words: string[]
    difficulty: string
    category: string
    isUserCreated: false
    isActive: boolean
    createdAt: timestamp
    nextReviewAt: timestamp
    easiness: number
    interval: number
    reps: number

users/
  {userId}/
    word_lists/
      {wordListId}/
        // Same structure as daily lists
        isUserCreated: true

    study_sessions/
      {sessionId}/
        userId: string
        wordListId: string
        startedAt: timestamp
        completedAt: timestamp
        results: WordResult[]
        isCompleted: boolean
        finalScore: number
        totalTimeSeconds: number
```

## Cloud Functions

### Available Functions

1. **populateDailyWordLists** (HTTP)

   - Populates initial daily word lists
   - Call: `POST https://region-project.cloudfunctions.net/populateDailyWordLists`

2. **refreshDailyWordLists** (Scheduled)

   - Runs daily at 6 AM UTC
   - Rotates daily content
   - Deactivates old lists

3. **generateDailyWordLists** (Callable)
   - Admin function to generate new lists
   - Requires admin authentication

## Getting Started

### Setup

1. Deploy Cloud Functions:

   ```bash
   cd functions
   npm install
   npm run deploy
   ```

2. Populate test data:

   ```dart
   import 'package:super_brain/core/services/test_data_service.dart';

   // In your app
   await TestDataService.populateTestWordLists();
   ```

### Usage

The feature is automatically integrated into the Reminder tab. Users can:

- View daily word lists and due reviews
- Create custom word lists via the FAB
- Start study sessions by tapping any word list
- Track progress through SRS scheduling

## Development Notes

- All word lists use Firestore real-time updates
- SRS calculation happens client-side for responsiveness
- Cloud Functions handle content curation and rotation
- Offline support through Firestore caching
- Performance optimized with indexed queries and limits
