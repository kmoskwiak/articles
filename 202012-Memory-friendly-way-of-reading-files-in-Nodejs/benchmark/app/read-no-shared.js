const fs = require('fs');
const config = require('./config');

function readBytes(fd, size) {
    const buffer = Buffer.alloc(size);
    return new Promise((resolve, reject) => {
        fs.read(
            fd, 
            buffer,
            0,
            buffer.length,
            null,
            (err) => {
                if(err) { return reject(err); }
                resolve(buffer);
            }
        );
    });
}

async function* read(filePath, size) {
    const stats = fs.statSync(filePath);
    const fd = fs.openSync(filePath);
    console.log(stats.size)
    
    for(let i = 0; i < Math.ceil(stats.size / size); i++) {
        const buffer = await readBytes(fd, size);
        yield buffer;
    }
}

async function start() {
    let bytesRead = 0;
    console.log('Started');
    for await(const chunk of read('./file', config.CHUNK_SIZE)) {
        bytesRead = bytesRead + chunk.length;
        console.log(chunk.length);
        await config.wait();
    }
    console.log('Finished')
}

start();
