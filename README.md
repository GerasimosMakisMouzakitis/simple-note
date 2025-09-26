# 📝 Simple Sticky Notes Web App

A clean, intuitive web application that simulates an A4 paper with draggable yellow sticky notes. Perfect for quick note-taking, brainstorming, or organizing thoughts visually.

## ✨ Features

- **Click to Create**: Click anywhere on the A4 paper to add a new sticky note
- **Edit in Place**: Double-click any note to edit its text content
- **Drag & Drop**: Easily move notes around the canvas by dragging them
- **Right-Click Delete**: Right-click any note to delete it
- **Auto-Save**: All changes are automatically saved to your browser's local storage
- **Responsive Design**: Works on desktop, tablet, and mobile devices
- **Clean Interface**: Minimalist design focused on usability

## 🚀 Getting Started

1. **Open the App**: Simply open `index.html` in any modern web browser
2. **Create Notes**: Click anywhere on the paper to create your first sticky note
3. **Edit Text**: Double-click a note to edit its content
4. **Move Notes**: Drag notes around to organize them as you like
5. **Delete Notes**: Right-click a note and select "Delete Note" to remove it

## 💻 Usage Instructions

### Creating Notes
- Click anywhere on the A4 paper canvas
- A new yellow sticky note will appear at that location
- The note will initially contain placeholder text "Click to edit..."

### Editing Notes
- Double-click any sticky note to enter edit mode
- The text will be selected for easy replacement
- Type your content and press Enter or click elsewhere to save
- Changes are automatically saved to your browser

### Moving Notes
- Click and hold any sticky note (not on the text area)
- Drag it to your desired position
- Release to drop the note in the new location
- Position changes are automatically saved

### Deleting Notes
- Right-click on any sticky note
- Select "🗑️ Delete Note" from the context menu
- The note will be permanently removed

## 🔧 Technical Details

### Files Structure
```
simple-note/
├── index.html    # Main application file
├── styles.css    # All styling and animations
├── script.js     # JavaScript functionality
├── plan.md       # Development plan
└── README.md     # This file
```

### Browser Compatibility
- Chrome/Chromium (recommended)
- Firefox
- Safari
- Edge
- Mobile browsers (iOS Safari, Chrome Mobile)

### Local Storage
- Notes are automatically saved to your browser's localStorage
- Data persists between browser sessions
- No server or internet connection required

### Responsive Design
- Desktop: Full-size A4 canvas (600px × 848px)
- Tablet: Scaled canvas maintaining A4 proportions
- Mobile: Optimized for touch interactions with smaller notes

## 🎨 Customization

The app is built with vanilla HTML, CSS, and JavaScript, making it easy to customize:

### Changing Note Colors
Edit the `background` property in `.sticky-note` class in `styles.css`:
```css
.sticky-note {
    background: linear-gradient(45deg, #ffeb3b, #fff176); /* Yellow */
    /* Try: #ff9999 for pink, #99ff99 for green, etc. */
}
```

### Adjusting Note Size
Modify the `width` and `height` in `.sticky-note` class:
```css
.sticky-note {
    width: 150px;  /* Default width */
    height: 150px; /* Default height */
}
```

### Canvas Size
Change the A4 paper dimensions in `.a4-paper` class:
```css
.a4-paper {
    width: 600px;   /* Canvas width */
    height: 848px;  /* Canvas height (A4 ratio) */
}
```

## 🐛 Troubleshooting

**Notes aren't saving?**
- Check if your browser has localStorage enabled
- Some private/incognito modes may disable localStorage

**Drag and drop not working?**
- Make sure you're clicking on the note itself, not the text area
- Try clicking on the note's border or background

**Context menu not appearing?**
- Ensure right-click is enabled in your browser
- On mobile, try long-press instead of right-click

## 📱 Mobile Usage

- **Tap** to create new notes
- **Double-tap** to edit note text
- **Long-press** to access delete option
- **Drag** notes with your finger

## 🔒 Privacy

- All data is stored locally in your browser
- No data is sent to any servers
- No tracking or analytics
- Works completely offline

## 📄 License

This project is open source and available under the MIT License.

---

**Enjoy organizing your thoughts with Simple Sticky Notes! 🎉**