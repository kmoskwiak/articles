const fs = require('fs');
const config = require('./config');

function readBytes(filePath, start, end) {
    let out = [];
    return new Promise((resolve, reject) => {
        let file = fs.createReadStream(
            filePath, 
            {
                start: start, 
                end: end 
            }
        );

        file.on('data', (data) => {
            out.push(data);
        });

        file.on('end', () => {
            resolve(Buffer.concat(out));
        });
    });
}

async function* read(filePath, range, buf) {
    let start = 0;
    let end = range;
    let isEnd = false;

    while(!isEnd) {
        let out = await readBytes(filePath, start, end, buf);
        start = end + 1;
        end = end + range;

        if(out.length < range) {
            isEnd = true;
        }

        yield out;
    }
}

async function start() {
    let bytesRead = 0;
    console.log('Started');
    
    for await(const chunk of read('./file', config.CHUNK_SIZE)) {
        bytesRead = bytesRead + chunk.length;
        await config.wait();
    }

    console.log('Finished')
}

start();
