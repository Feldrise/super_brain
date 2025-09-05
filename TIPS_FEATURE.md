# Tips Feature Documentation

## Overview

The Tips feature provides daily brain training tips and advice to users of the SuperBrain app. It includes a comprehensive system for displaying, managing, and organizing brain training tips.

## Architecture

The tips feature follows clean architecture principles:

### Domain Layer

- **`DailyTip`**: Entity representing a tip with properties like id, title, content, category, etc.
- **`TipRepository`**: Interface defining operations for tip management
- **`TipCategory`**: Enum defining different tip categories (memory, concentration, productivity, etc.)

### Data Layer

- **`TipDataSource`**: Abstract interface for data sources
- **`LocalTipDataSource`**: Implementation that loads tips from JSON assets
- **`TipRepositoryImpl`**: Repository implementation using the data source

### Presentation Layer

- **`TipProviders`**: Riverpod providers for state management
- **`TipsListPage`**: Main page showing all tips with search and filtering
- **`TipDetailPage`**: Detailed view of a single tip
- **`TipCard`**: Reusable widget for displaying tip previews
- **`TipOfDayCard`**: Widget showing the daily tip on the home page

## Features

### Core Features

1. **Daily Tip**: Shows a different tip each day based on the day of the year
2. **Tips List**: Browse all available tips with search functionality
3. **Categories**: Tips are organized into categories (memory, concentration, etc.)
4. **Read Tracking**: Marks tips as read when viewed
5. **Search**: Find tips by title, content, or tags
6. **Tags**: Each tip can have multiple tags for better organization

### UI Features

1. **Responsive Design**: Works on different screen sizes
2. **Material Design**: Follows Material Design 3 guidelines
3. **Loading States**: Proper loading indicators
4. **Error Handling**: Graceful error handling with user-friendly messages
5. **Navigation**: Integrated with GoRouter for navigation

## Data Structure

Tips are stored in `assets/data/daily_tips.json` with the following structure:

```json
{
  "id": "unique_identifier",
  "title": "Tip Title",
  "content": "Detailed tip content...",
  "category": "memory|concentration|productivity|health|learning|motivation",
  "createdAt": "2024-09-01T10:00:00Z",
  "isRead": false,
  "tags": ["tag1", "tag2", "tag3"]
}
```

## Usage

### Adding New Tips

1. Add new tip objects to `assets/data/daily_tips.json`
2. Follow the JSON structure above
3. Use appropriate category values
4. Add relevant tags for better searchability

### Navigation

- `/tips` - Main tips list page
- Tips detail pages are navigated to via direct navigation from list/cards

### State Management

The feature uses Riverpod for state management with the following providers:

- `dailyTipProvider` - Current daily tip
- `allTipsProvider` - All available tips
- `searchTipsProvider` - Search results
- `markTipAsReadProvider` - Action to mark tips as read

## Integration

### Home Page Integration

The `TipOfDayCard` widget is integrated into the home page and shows:

- Daily tip title and preview
- Quick action to read the full tip
- Navigation to the tips list

### Router Integration

The tips routes are integrated into the main app router:

- `/tips` - Tips list page
- Direct navigation for tip details

## Future Enhancements

Potential improvements:

1. **Favorites**: Allow users to favorite tips
2. **Sharing**: Share tips via social media or messaging
3. **Offline Support**: Cache tips for offline viewing
4. **Personalization**: Suggest tips based on user activity
5. **Notifications**: Send daily tip notifications
6. **User-Generated Content**: Allow users to submit their own tips
7. **Progress Tracking**: Track which tips have been applied
8. **Difficulty Levels**: Categorize tips by difficulty
9. **Audio Tips**: Add audio narration for tips
10. **Related Tips**: Show related tips based on content similarity

## File Structure

```
lib/features/home/
├── domain/
│   ├── entities/
│   │   └── daily_tip.dart
│   └── repositories/
│       └── tip_repository.dart
├── data/
│   ├── datasources/
│   │   └── tip_data_source.dart
│   └── repositories/
│       └── tip_repository_impl.dart
├── presentation/
│   ├── providers/
│   │   └── tip_providers.dart
│   ├── pages/
│   │   ├── tips_list_page.dart
│   │   └── tip_detail_page.dart
│   └── widgets/
│       ├── tip_card.dart
│       └── tip_of_day_card.dart
└── tips.dart (barrel export)

assets/data/
└── daily_tips.json
```

## Dependencies

The tips feature uses the following packages:

- `flutter_riverpod`: State management
- `freezed`: Code generation for entities
- `json_annotation`: JSON serialization
- `go_router`: Navigation
- Standard Flutter packages for UI
