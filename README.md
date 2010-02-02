# ffi-udis86

* http://github.com/sophsec/ffi-udis86/
* Postmodern (postmodern.mod3 at gmail.com)

## DESCRIPTION:

Ruby FFI bindings for udis86, a x86 and x86-64 disassembler.

## FEATURES:

* Supports x86 and x86-64 instructions.
* Supports 16 and 32 disassembly modes.
* Supports Intel and ATT syntax output.
* Supports disassembling files and arbitrary input.
* Supports input callbacks.

## EXAMPLES:

Create a new disassembler:

    include FFI::UDis86
    
    ud = UD.create(:syntax => :att, :mode => 64)

Set the input buffer:

    ud.input_buffer = "\x90\x90\xc3"

Add an input callback:

    ud.input_callback { |ud| ops.shift || -1 }

Read a file:

    UD.open(path) do |ud|
      ...
    end

Disassemble and print instructions:

    ud.disas do |insn|
      puts insn
    end

## REQUIREMENTS:

* [udis86](http://udis86.sourceforge.net/) >= 1.7
* [ffi](http://github.com/ffi/ffi) >= 0.6.0

## INSTALL:

    $ sudo gem install ffi-udis86

## LICENSE:

The MIT License

Copyright (c) 2009-2010 Hal Brodigan

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.