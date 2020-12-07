const fs = require('fs');
const config = require('./config');

function readBytes(fd, buffer) {
    return new Promise((resolve, reject) => {
        fs.read(
            fd, 
            buffer,
            0,
            buffer.length,
            null,
            (err) => {
                if(err) { return reject(err); }
                resolve();
            }
        );
    });
}

async function* generateChunks(filePath, size) {
    const sharedBuffer = Buffer.alloc(size);
    const stats = fs.statSync(filePath); // file details
    const fd = fs.openSync(filePath); // file descriptor
    let bytesRead = 0; // how many bytes were read
    let end = size; 
    
    for(let i = 0; i < Math.ceil(stats.size / size); i++) {
        await readBytes(fd, sharedBuffer);
        bytesRead = (i + 1) * size;
        if(bytesRead > stats.size) {
          	// When we reach the end of file, 
          	// we have to calculate how many bytes were actually read
           end = size - (bytesRead - stats.size);
        }
        yield sharedBuffer.slice(0, end);
    }
}

async function main() {  
  for await(const chunk of generateChunks('./file', config.CHUNK_SIZE)) {
    // do someting with data  
    await config.wait();     
  }
}

main();