# LegumLex Native Android App

A native Android application for LegumLex legal services client portal.

## Development Workflow

### Server-Side Development (VS Code Remote SSH)
1. Code development and editing
2. Git commits and pushes
3. Project structure management

### Local Development (Android Studio)
1. Clone/pull latest changes
2. Build and compile
3. Run on emulator/device
4. Testing and debugging

## Project Structure

```
app/
├── src/
│   ├── main/
│   │   ├── java/com/legumlex/clientapp/
│   │   │   ├── activities/
│   │   │   ├── fragments/
│   │   │   ├── models/
│   │   │   ├── services/
│   │   │   └── utils/
│   │   ├── res/
│   │   │   ├── layout/
│   │   │   ├── values/
│   │   │   └── drawable/
│   │   └── AndroidManifest.xml
│   └── test/
└── build.gradle
```

## Setup Instructions

### On Windows (Android Studio):
1. `git clone [repository-url]`
2. Open in Android Studio
3. Sync project with Gradle files
4. Build and run

### On Server (VS Code):
1. Make changes to code
2. `git add .`
3. `git commit -m "description"`
4. `git push`

## API Integration

- **Backend**: Perfex CRM API
- **Authentication**: Token-based
- **Features**: Cases, Documents, Invoices, Profile

## Requirements

- Android API 21+ (Android 5.0)
- Kotlin
- Retrofit for API calls
- Material Design Components