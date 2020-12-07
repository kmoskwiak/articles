const fs = require('fs');
const config = require('./config');

async function start() {
    const stream = fs.readFileSync('./file');
    let bytesRead = 0;
    for(bytesRead = 0; bytesRead <= stream.length; bytesRead = bytesRead + config.CHUNK_SIZE) {
        await config.wait();
    }
    console.log('Finished')
}

start();
