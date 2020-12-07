const fs = require('fs');
const config = require('./config');

async function start() {
    let bytesRead = 0;
    console.log('Started');
    let chunk = { chunk: null };
    for await(chunk.chunk of fs.createReadStream('./file', { highWaterMark: config.CHUNK_SIZE })) {
        bytesRead = bytesRead + chunk.length;
        await config.wait();
    }
    console.log('Finished')
}

start();
