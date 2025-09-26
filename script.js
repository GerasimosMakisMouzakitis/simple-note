// Simple Sticky Notes App v1.1.0
// Author: GerasimosMakisMouzakitis
// Repository: https://github.com/GerasimosMakisMouzakitis/simple-note

class StickyNotesApp {
    constructor() {
        this.appVersion = '1.1.0';
        this.appAuthor = 'GerasimosMakisMouzakitis';
        this.canvas = document.getElementById('canvas');
        this.contextMenu = document.getElementById('contextMenu');
        this.notes = [];
        this.noteIdCounter = 0;
        this.currentNote = null;
        this.isDragging = false;
        this.dragOffset = { x: 0, y: 0 };
        
        this.init();
    }
    
    init() {
        this.loadNotes();
        this.bindEvents();
        this.renderNotes();
    }
    
    bindEvents() {
        // Canvas click to create new note
        this.canvas.addEventListener('click', (e) => this.handleCanvasClick(e));
        
        // Context menu events
        document.addEventListener('contextmenu', (e) => this.handleContextMenu(e));
        document.addEventListener('click', () => this.hideContextMenu());
        document.getElementById('deleteNote').addEventListener('click', () => this.deleteCurrentNote());
        
        // Mouse events for dragging
        document.addEventListener('mousemove', (e) => this.handleMouseMove(e));
        document.addEventListener('mouseup', () => this.handleMouseUp());
        
        // Export/Import events
        document.getElementById('exportBtn').addEventListener('click', () => this.exportToJSON());
        document.getElementById('importBtn').addEventListener('click', () => this.triggerImport());
        document.getElementById('fileInput').addEventListener('change', (e) => this.handleFileImport(e));
        
        // Prevent default drag behavior on images and other elements
        document.addEventListener('dragstart', (e) => e.preventDefault());
    }
    
    handleCanvasClick(e) {
        // Don't create a note if clicking on an existing note
        if (e.target.closest('.sticky-note')) return;
        
        const rect = this.canvas.getBoundingClientRect();
        const x = e.clientX - rect.left;
        const y = e.clientY - rect.top;
        
        // Make sure the note fits within the canvas
        const noteWidth = 150;
        const noteHeight = 150;
        const adjustedX = Math.min(x, this.canvas.offsetWidth - noteWidth);
        const adjustedY = Math.min(y, this.canvas.offsetHeight - noteHeight);
        
        this.createNote(adjustedX, adjustedY);
    }
    
    createNote(x, y, text = 'Click to edit...', id = null) {
        const noteId = id || ++this.noteIdCounter;
        const note = {
            id: noteId,
            x: x,
            y: y,
            text: text,
            timestamp: new Date().toISOString()
        };
        
        if (!id) {
            this.notes.push(note);
            this.saveNotes();
        }
        
        const noteElement = this.createNoteElement(note);
        this.canvas.appendChild(noteElement);
        
        // Add animation for new notes
        if (!id) {
            noteElement.classList.add('new-note');
            setTimeout(() => noteElement.classList.remove('new-note'), 300);
        }
        
        return noteElement;
    }
    
    createNoteElement(note) {
        const noteDiv = document.createElement('div');
        noteDiv.className = 'sticky-note';
        noteDiv.style.left = note.x + 'px';
        noteDiv.style.top = note.y + 'px';
        noteDiv.dataset.noteId = note.id;
        
        const textDiv = document.createElement('div');
        textDiv.className = 'note-text';
        textDiv.contentEditable = true;
        textDiv.textContent = note.text;
        
        noteDiv.appendChild(textDiv);
        
        // Bind events
        noteDiv.addEventListener('mousedown', (e) => this.handleNoteMouseDown(e, note));
        textDiv.addEventListener('blur', () => this.handleTextBlur(note, textDiv));
        textDiv.addEventListener('keydown', (e) => this.handleTextKeydown(e, textDiv));
        textDiv.addEventListener('input', () => this.handleTextInput(note, textDiv));
        
        // Double click to focus on text
        noteDiv.addEventListener('dblclick', (e) => {
            e.stopPropagation();
            textDiv.focus();
            // Select all text for easy editing
            const range = document.createRange();
            range.selectNodeContents(textDiv);
            const selection = window.getSelection();
            selection.removeAllRanges();
            selection.addRange(range);
        });
        
        return noteDiv;
    }
    
    handleNoteMouseDown(e, note) {
        // Don't start dragging if clicking on the text area
        if (e.target.classList.contains('note-text')) return;
        
        e.preventDefault();
        this.isDragging = true;
        this.currentNote = note;
        
        const noteElement = e.currentTarget;
        noteElement.classList.add('dragging');
        
        const rect = noteElement.getBoundingClientRect();
        const canvasRect = this.canvas.getBoundingClientRect();
        
        this.dragOffset = {
            x: e.clientX - rect.left,
            y: e.clientY - rect.top
        };
    }
    
    handleMouseMove(e) {
        if (!this.isDragging || !this.currentNote) return;
        
        const canvasRect = this.canvas.getBoundingClientRect();
        const noteElement = document.querySelector(`[data-note-id="${this.currentNote.id}"]`);
        
        if (!noteElement) return;
        
        let newX = e.clientX - canvasRect.left - this.dragOffset.x;
        let newY = e.clientY - canvasRect.top - this.dragOffset.y;
        
        // Keep note within canvas bounds
        const noteWidth = noteElement.offsetWidth;
        const noteHeight = noteElement.offsetHeight;
        
        newX = Math.max(0, Math.min(newX, this.canvas.offsetWidth - noteWidth));
        newY = Math.max(0, Math.min(newY, this.canvas.offsetHeight - noteHeight));
        
        noteElement.style.left = newX + 'px';
        noteElement.style.top = newY + 'px';
        
        // Update note data
        this.currentNote.x = newX;
        this.currentNote.y = newY;
    }
    
    handleMouseUp() {
        if (this.isDragging) {
            this.isDragging = false;
            
            if (this.currentNote) {
                const noteElement = document.querySelector(`[data-note-id="${this.currentNote.id}"]`);
                if (noteElement) {
                    noteElement.classList.remove('dragging');
                }
                
                this.saveNotes();
                this.currentNote = null;
            }
        }
    }
    
    handleTextBlur(note, textDiv) {
        note.text = textDiv.textContent || 'Click to edit...';
        this.saveNotes();
    }
    
    handleTextKeydown(e, textDiv) {
        // Allow Enter key but prevent other shortcuts
        if (e.key === 'Enter' && !e.shiftKey) {
            e.preventDefault();
            textDiv.blur();
        }
        
        // Prevent dragging when typing
        e.stopPropagation();
    }
    
    handleTextInput(note, textDiv) {
        note.text = textDiv.textContent;
        // Auto-save after a delay
        clearTimeout(this.autoSaveTimeout);
        this.autoSaveTimeout = setTimeout(() => this.saveNotes(), 1000);
    }
    
    handleContextMenu(e) {
        const noteElement = e.target.closest('.sticky-note');
        
        if (noteElement) {
            e.preventDefault();
            this.showContextMenu(e.pageX, e.pageY);
            this.currentNote = this.notes.find(note => note.id == noteElement.dataset.noteId);
        } else {
            this.hideContextMenu();
        }
    }
    
    showContextMenu(x, y) {
        this.contextMenu.style.display = 'block';
        this.contextMenu.style.left = x + 'px';
        this.contextMenu.style.top = y + 'px';
        
        // Adjust position if menu goes off screen
        const rect = this.contextMenu.getBoundingClientRect();
        if (rect.right > window.innerWidth) {
            this.contextMenu.style.left = (x - rect.width) + 'px';
        }
        if (rect.bottom > window.innerHeight) {
            this.contextMenu.style.top = (y - rect.height) + 'px';
        }
    }
    
    hideContextMenu() {
        this.contextMenu.style.display = 'none';
    }
    
    deleteCurrentNote() {
        if (!this.currentNote) return;
        
        // Remove from DOM
        const noteElement = document.querySelector(`[data-note-id="${this.currentNote.id}"]`);
        if (noteElement) {
            noteElement.style.animation = 'popIn 0.2s ease-in reverse';
            setTimeout(() => {
                if (noteElement.parentNode) {
                    noteElement.parentNode.removeChild(noteElement);
                }
            }, 200);
        }
        
        // Remove from data
        this.notes = this.notes.filter(note => note.id !== this.currentNote.id);
        this.saveNotes();
        
        this.hideContextMenu();
        this.currentNote = null;
    }
    
    saveNotes() {
        try {
            localStorage.setItem('stickyNotes', JSON.stringify(this.notes));
        } catch (e) {
            console.warn('Could not save notes to localStorage:', e);
        }
    }
    
    loadNotes() {
        try {
            const savedNotes = localStorage.getItem('stickyNotes');
            if (savedNotes) {
                this.notes = JSON.parse(savedNotes);
                // Update counter to avoid ID conflicts
                if (this.notes.length > 0) {
                    this.noteIdCounter = Math.max(...this.notes.map(note => note.id));
                }
            }
        } catch (e) {
            console.warn('Could not load notes from localStorage:', e);
            this.notes = [];
        }
    }
    
    renderNotes() {
        // Clear existing notes from DOM
        const existingNotes = this.canvas.querySelectorAll('.sticky-note');
        existingNotes.forEach(note => note.remove());
        
        // Render saved notes
        this.notes.forEach(note => {
            this.createNote(note.x, note.y, note.text, note.id);
        });
    }
    
    // Export all notes to JSON format
    exportToJSON() {
        try {
            const exportData = {
                metadata: {
                    appVersion: this.appVersion,
                    appAuthor: this.appAuthor,
                    exportDate: new Date().toISOString(),
                    noteCount: this.notes.length,
                    formatVersion: "1.0"
                },
                notes: this.notes.map(note => ({
                    id: note.id,
                    text: note.text,
                    x: note.x,
                    y: note.y,
                    timestamp: note.timestamp || new Date().toISOString()
                }))
            };
            
            const jsonString = JSON.stringify(exportData, null, 2);
            const blob = new Blob([jsonString], { type: 'application/json' });
            const url = URL.createObjectURL(blob);
            
            const a = document.createElement('a');
            a.href = url;
            a.download = `sticky-notes-${new Date().toISOString().split('T')[0]}.json`;
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
            URL.revokeObjectURL(url);
            
            this.showMessage(`✅ Exported ${this.notes.length} notes successfully!`, 'success');
        } catch (error) {
            console.error('Export failed:', error);
            this.showMessage('❌ Export failed. Please try again.', 'error');
        }
    }
    
    // Trigger file input for import
    triggerImport() {
        document.getElementById('fileInput').click();
    }
    
    // Handle JSON file import
    handleFileImport(event) {
        const file = event.target.files[0];
        if (!file) return;
        
        if (!file.name.endsWith('.json')) {
            this.showMessage('❌ Please select a valid JSON file.', 'error');
            return;
        }
        
        const reader = new FileReader();
        reader.onload = (e) => {
            try {
                const importData = JSON.parse(e.target.result);
                this.importFromJSON(importData);
            } catch (error) {
                console.error('Import failed:', error);
                this.showMessage('❌ Invalid JSON file format.', 'error');
            }
        };
        reader.readAsText(file);
        
        // Reset file input
        event.target.value = '';
    }
    
    // Import notes from JSON data
    importFromJSON(importData) {
        try {
            // Validate JSON structure
            if (!importData.notes || !Array.isArray(importData.notes)) {
                throw new Error('Invalid JSON structure: missing notes array');
            }
            
            // Show confirmation dialog
            const noteCount = importData.notes.length;
            const currentCount = this.notes.length;
            
            if (!confirm(`Import ${noteCount} notes? This will replace your current ${currentCount} notes.`)) {
                return;
            }
            
            // Validate each note
            const validNotes = importData.notes.filter(note => {
                return note && 
                       typeof note.text === 'string' && 
                       typeof note.x === 'number' && 
                       typeof note.y === 'number';
            });
            
            if (validNotes.length === 0) {
                this.showMessage('❌ No valid notes found in the file.', 'error');
                return;
            }
            
            // Clear existing notes and import new ones
            this.notes = validNotes.map((note, index) => ({
                id: this.noteIdCounter + index + 1,
                text: note.text || 'Imported note',
                x: Math.max(0, note.x),
                y: Math.max(0, note.y),
                timestamp: note.timestamp || new Date().toISOString()
            }));
            
            // Update counter
            this.noteIdCounter = Math.max(...this.notes.map(note => note.id));
            
            // Save and render
            this.saveNotes();
            this.renderNotes();
            
            const skipped = importData.notes.length - validNotes.length;
            let message = `✅ Imported ${validNotes.length} notes successfully!`;
            if (skipped > 0) {
                message += ` (${skipped} invalid notes skipped)`;
            }
            
            this.showMessage(message, 'success');
            
        } catch (error) {
            console.error('Import failed:', error);
            this.showMessage('❌ Import failed: ' + error.message, 'error');
        }
    }
    
    // Show temporary message to user
    showMessage(text, type = 'info') {
        // Remove existing message if any
        const existingMessage = document.querySelector('.temp-message');
        if (existingMessage) {
            existingMessage.remove();
        }
        
        // Create message element
        const message = document.createElement('div');
        message.className = `temp-message temp-message-${type}`;
        message.textContent = text;
        
        // Add to page
        document.body.appendChild(message);
        
        // Auto-remove after 3 seconds
        setTimeout(() => {
            if (message.parentNode) {
                message.style.animation = 'fadeOut 0.3s ease-out forwards';
                setTimeout(() => message.remove(), 300);
            }
        }, 3000);
    }

    // Public method to clear all notes (for debugging/demo)
    clearAllNotes() {
        this.notes = [];
        this.saveNotes();
        this.renderNotes();
    }
}

// Initialize the app when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    window.stickyNotesApp = new StickyNotesApp();
    
    // Add some helpful console commands
    console.log('🎉 Simple Sticky Notes App v1.1.0 loaded!');
    console.log('👨‍💻 Author: GerasimosMakisMouzakitis');
    console.log('💡 Try: stickyNotesApp.clearAllNotes() to clear all notes');
});

// Prevent zooming on double-tap for mobile
document.addEventListener('touchstart', function(e) {
    if (e.touches.length > 1) {
        e.preventDefault();
    }
});

let lastTouchEnd = 0;
document.addEventListener('touchend', function(e) {
    const now = (new Date()).getTime();
    if (now - lastTouchEnd <= 300) {
        e.preventDefault();
    }
    lastTouchEnd = now;
}, false);