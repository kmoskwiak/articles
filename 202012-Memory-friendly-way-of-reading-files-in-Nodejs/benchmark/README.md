# Benchmark

Source files for benchamrk. To run this benchmark you will need Docker.

## How to prepare and run benchmark

Create 1GB file. There is a helper script.

```
sh create_file.sh
```

Build an image:

```
sh run.sh build
```

Exevute benchmark for each varaint:

#### readFileSync
```
sh run.sh readFile
```
#### createReadStream
```
sh run.sh cRS
```

#### read with shared buffer
```
sh run.sh read
```

#### read without shared bufer
```
sh run.sh read-no-shared
```

Each test will create couple of reports in format:

```
<name of the container>;<used memmory> / <avaliable memory>
```

for example:
```csv
elated_blackwell;27.08MiB / 1.941GiB
elated_blackwell;65.29MiB / 1.941GiB
elated_blackwell;60.95MiB / 1.941GiB
elated_blackwell;76.83MiB / 1.941GiB
elated_blackwell;56.91MiB / 1.941GiB
elated_blackwell;46.06MiB / 1.941GiB
elated_blackwell;78.08MiB / 1.941GiB
elated_blackwell;92.7MiB / 1.941GiB
elated_blackwell;62.08MiB / 1.941GiB
elated_blackwell;30.8MiB / 1.941GiB
```

Be careful with units. `docker stats` returns memory in **Mebibytes (MiB)**.  1 MiB is equal 1.04858 MB **(Megabyte)**.

## Results from my benchmark
Results from my benchmark are availible in [reports](./reports) directory. There are 4 files:

- [maximum-memory-usage.tsv](./reports/maximum-memory-usage.tsv) - moving maximum of memory usage
- [median-memory-usage-chunk-size.tsv](./reports/median-memory-usage-chunk-size.tsv) - median memory usage depending on chunk size
- [standard-deviation.tsv](./reports/standard-deviation.tsv) - standard deviation depending on chunk size
- [memory-usage-with-without-shared-buffer.tsv](./reports/memory-usage-with-without-shared-buffer.tsv) - comparison of memory usage read with and without shared buffer

In all those files MiB is used as memory unit.