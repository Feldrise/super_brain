# Dream Journal Feature

## Overview

The Dream Journal is a feature within SuperBrain's Morning Routine module that allows users to record, categorize, and track their dreams.

## Features Implemented

### Core Functionality

- ✅ **Dream Entry Creation**: Users can create new dream entries with detailed content
- ✅ **Dream Editing**: Edit existing dream entries
- ✅ **Dream Deletion**: Remove unwanted dream entries
- ✅ **Search & Filter**: Search through dream entries by content and tags

### Dream Categorization

- ✅ **Mood Tracking**: 8 different mood options (Peaceful, Excited, Anxious, Confused, Happy, Scary, Sad, Neutral)
- ✅ **Dream Types**: 8 categories (Normal, Lucid, Nightmare, Recurring, Prophetic, Flying, Adventure, Romantic)
- ✅ **Special Properties**: Mark dreams as lucid or recurring
- ✅ **Tags System**: Add custom tags for better organization

### User Experience

- ✅ **Quick Prompts**: Pre-written sentence starters to help users begin writing
- ✅ **Date Selection**: Choose the specific date when the dream occurred
- ✅ **Beautiful UI**: Cards, emoji indicators, and intuitive navigation
- ✅ **Offline-First**: Data is stored in Firestore for persistence

## Architecture

### Clean Architecture Pattern

```
Domain Layer:
├── entities/dream_entry.dart          # Core business models
├── repositories/                      # Abstract repository contracts
└── usecases/                         # Business logic use cases

Data Layer:
└── repositories/                     # Firestore implementation

Presentation Layer:
├── pages/                           # UI screens
├── providers/                       # Riverpod state management
└── widgets/                        # Reusable UI components
```

### Key Technologies

- **State Management**: Riverpod with StateNotifier pattern
- **Data Persistence**: Cloud Firestore
- **Code Generation**: Freezed for immutable data classes
- **Navigation**: Integrated with existing go_router setup

## Usage

### From Morning Routine

1. Navigate to "Routine Matinale" from home screen
2. Tap on "Journal des rêves" card
3. Create new dreams with the floating action button

### Dream Entry Process

1. **Content**: Describe the dream (required)
2. **Quick Prompts**: Optional sentence starters for inspiration
3. **Mood**: Select emotional state during the dream
4. **Category**: Choose dream type (lucid, nightmare, etc.)
5. **Properties**: Mark as lucid/recurring if applicable
6. **Date**: Set when the dream occurred
7. **Tags**: Add custom labels for organization

### Search & Organization

- Use the search icon to find dreams by keywords
- Filter by content, tags, mood, or category
- Browse chronologically organized dream list

## Future Enhancements

### Analytics & Insights

- Dream pattern analysis
- Mood correlation tracking
- Sleep quality integration
- Recurring theme detection

### Enhanced Features

- Voice-to-text dream entry
- Dream sharing with privacy controls
- Export dreams to PDF/markdown
- Backup and sync across devices

## Technical Notes

### Providers Setup

```dart
// Already configured in dream_journal_providers.dart
final dreamEntriesProvider = FutureProvider<List<DreamEntry>>((ref) async {
  final useCase = ref.read(getDreamEntriesUseCaseProvider);
  return await useCase.call();
});
```

### Navigation Integration

The feature is integrated into the existing morning routine page at:
`/features/morning/presentation/morning_page.dart`

### Data Model

```dart
@freezed
class DreamEntry with _$DreamEntry {
  const factory DreamEntry({
    required String id,
    required String content,
    String? mood,
    String? category,
    @Default(false) bool isLucid,
    @Default(false) bool isRecurring,
    @Default([]) List<String> tags,
    DateTime? dreamDate,
    required DateTime createdAt,
    DateTime? updatedAt,
    @Default(false) bool isSynced,
  }) = _DreamEntry;
}
```
