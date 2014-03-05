#!/usr/bin/env node

// process args
var argv = process.argv.slice(0);
argv.shift(); // node
var scriptName = argv.shift(); // fizz.js
if (argv.length !== 2) {
    // node <scriptName> args...
    console.log(process.argv);
    process.stderr.write('usage: ' + scriptName + ' <start> <end>\n');
    process.exit(1);
}

// load so
var ffi = require('ffi'),
    libfizz = ffi.Library('libfizz', { 'fizzy': [ 'int', [ 'int', 'int' ] ] }),
    start = argv[0],
    end = argv[1],
    fizzCount = libfizz.fizzy(start, end);

// call func
process.stdout.write('fizzed ' + fizzCount + 'times\n');
