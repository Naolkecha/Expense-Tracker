// Service worker for sqflite_common_ffi_web
importScripts('https://cdn.jsdelivr.net/npm/sql.js@1.8.0/dist/sql-wasm.js');

// Initialize SQL.js
initSqlJs({
  locateFile: file => `https://cdn.jsdelivr.net/npm/sql.js@1.8.0/dist/${file}`
}).then(function(SQL){
  self.SQL = SQL;
  postMessage({ type: 'ready' });
});

// Handle messages from main thread
self.addEventListener('message', function(e) {
  // Handle database operations
  const data = e.data;
  
  if (data.type === 'exec') {
    try {
      const result = self.SQL.exec(data.sql);
      postMessage({ type: 'result', id: data.id, result: result });
    } catch (error) {
      postMessage({ type: 'error', id: data.id, error: error.message });
    }
  }
});

