# Creative Dalaal Demo app

This is a Flutter application that implements a comment section with nested replies. It allows users to add comments, reply to existing comments, edit, and delete comments. The application ensures that nested replies are scrollable and the latest comments are displayed by default with an option to view previous comments.

## Features

- Add new comments
- Reply to existing comments
- Edit and delete comments
- Display latest 4 comments by default

## Getting Started

### Prerequisites

Before you begin, ensure you have met the following requirements:

- You have installed the latest version of [Flutter SDK](https://flutter.dev/docs/get-started/install)
- You have a connected device (physical or emulator) to run the app
- You have a code editor such as [Visual Studio Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio)

### Installation

Follow these steps to set up and run the project:

1. **Clone the repository:**

   ```bash
   git clone git@github.com:Akash4097/creative_dalaal_demo.git

   cd creative_dalaal_demo

2. **Install dependencies:**

Navigate to the project directory and install the dependencies:

```bash
flutter pub get
```

3. **Run the app:**

Ensure you have a connected device or emulator running, then use the following command to run the app:

```bash
flutter run
```


### Project Structure


 * `lib/`

   * `data_models/`

     * `comment.dart:` data-model class for comment.
     * `user.dart:` data-model class for user. 
   *  `notifier/`
      * `comment_service_notifier.dart:` Manages the state and logic for comments, including adding, editing, and deleting comments.
   * `ui/`
     * `screens/`
        * `comment_section_screen.dart:`  The main screen that displays the comment section.
     * `widgets/`
        * `comment_widget.dart: `The CommentWidget class for displaying individual comments and their nested replies.
   * `utils/`
        * `date_format_extension.dart:`Extension method for formatting dates.
        * `responsive.dart:` class to make the widget resposive to width upto 720.
        * `unique_id.dart:` class contain method that generate unique ids.



## How to Use

### Adding a Comment
1. Type your comment in the text field at the top.
2. Press the send button to add the comment.

### Replying to a Comment
1. Press the "Reply" button below the comment you want to reply to.
2. Type your reply in the text field that appears.
3. Press the send button to add the reply.

### Editing a Comment
1. Press the menu icon (three dots) on the comment you want to edit.
2. Select "Edit" from the dropdown menu.
3. Edit your comment in the text field that appears and press the check icon to save.

### Deleting a Comment
1. Press the menu icon (three dots) on the comment you want to delete.
2. Select "Delete" from the dropdown menu.

### Viewing Previous Comments
1. If there are more than four comments, a "Show Previous Comments" button will appear.
2. Press the button to view all comments.
3. Press "Hide Previous Comments" to collapse the view back to the latest four comments.
