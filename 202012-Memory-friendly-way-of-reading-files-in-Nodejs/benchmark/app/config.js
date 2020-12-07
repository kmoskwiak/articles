const CHUNK_SIZE = process.env.CHUNK_SIZE ? +process.env.CHUNK_SIZE : 6000;
const WAIT = process.env.WAIT ? +process.env.WAIT : 0;
console.log('Chunk size: ', CHUNK_SIZE);
console.log('Wait: ', WAIT);

const wait = () => {
    return new Promise(resolve => {
        setTimeout(resolve, WAIT)
    });
}

module.exports = {
    CHUNK_SIZE,
    WAIT,
    wait
}