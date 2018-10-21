# Befunge

Befunge is a stack-based, reflective, esoteric programming language. It differs from conventional languages in that programs are arranged on a two-dimensional grid. "Arrow" instructions direct the control flow to the left, right, up or down, and loops are constructed by sending the control flow in a cycle.

This implementation is based upon the following references:
1. https://en.wikipedia.org/wiki/Befunge
2. https://esolangs.org/wiki/Befunge


## Usage
```
$ ruby befunge.rb <filename>
```

## Included

1. 3 Hello World examples: `helloworld, 2 and 3.bf`
2. A quine: `quine.bf`
3. A direction checker: `flowcheck.bf`
4. A less or more game that allows you to cheat `less_or_more.bf`
5. A factorial program: `factorial.bf`

## Instruction Set
<table>
<tr>
<th>Cmd
</th>
<th>Description
</th></tr>
<tr>
<td><code>+</code>
</td>
<td>Addition: Pop two values a and b, then push the result of a+b
</td></tr>
<tr>
<td><code>-</code>
</td>
<td>Subtraction: Pop two values a and b, then push the result of b-a
</td></tr>
<tr>
<td><code>*</code>
</td>
<td>Multiplication: Pop two values a and b, then push the result of a*b
</td></tr>
<tr>
<td><code>/</code>
</td>
<td>Integer division: Pop two values a and b, then push the result of b/a, rounded down. According to the specifications, if a is zero, ask the user what result they want.
</td></tr>
<tr>
<td><code>%</code>
</td>
<td>Modulo: Pop two values a and b, then push the remainder of the integer division of b/a.
</td></tr>
<tr>
<td><code>!</code>
</td>
<td>Logical NOT: Pop a value. If the value is zero, push 1; otherwise, push zero.
</td></tr>
<tr>
<td><code>`</code>
</td>
<td>Greater than: Pop two values a and b, then push 1 if b&gt;a, otherwise zero.
</td></tr>
<tr>
<td><code>&gt;</code>
</td>
<td>PC direction right
</td></tr>
<tr>
<td><code>&lt;</code>
</td>
<td>PC direction left
</td></tr>
<tr>
<td><code>^</code>
</td>
<td>PC direction up
</td></tr>
<tr>
<td><code>v</code>
</td>
<td>PC direction down
</td></tr>
<tr>
<td><code>?</code>
</td>
<td>Random PC direction
</td></tr>
<tr>
<td><code>_</code>
</td>
<td>Horizontal IF: pop a value; set direction to right if value=0, set to left otherwise
</td></tr>
<tr>
<td><code>|</code>
</td>
<td>Vertical IF: pop a value; set direction to down if value=0, set to up otherwise
</td></tr>
<tr>
<td><code>"</code>
</td>
<td>Toggle stringmode (push each character's ASCII value all the way up to the next <code>"</code>)
</td></tr>
<tr>
<td><code>:</code>
</td>
<td>Duplicate top stack value
</td></tr>
<tr>
<td><code>\</code>
</td>
<td>Swap top stack values
</td></tr>
<tr>
<td><code>$</code>
</td>
<td>Pop (remove) top stack value and discard
</td></tr>
<tr>
<td><code>.</code>
</td>
<td>Pop top of stack and output as integer
</td></tr>
<tr>
<td><code>,</code>
</td>
<td>Pop top of stack and output as ASCII character
</td></tr>
<tr>
<td><code>#</code>
</td>
<td>Bridge: jump over next command in the current direction of the current PC
</td></tr>
<tr>
<td><code>g</code>
</td>
<td>A "get" call (a way to retrieve data in storage). Pop two values y and x, then push the ASCII value of the character at that position in the program. If (x,y) is out of bounds, push 0
</td></tr>
<tr>
<td><code>p</code>
</td>
<td>A "put" call (a way to store a value for later use). Pop three values y, x and v, then change the character at the position (x,y) in the program to the character with ASCII value v
</td></tr>
<tr>
<td><code>&amp;</code>
</td>
<td>Get integer from user and push it
</td></tr>
<tr>
<td><code>~</code>
</td>
<td>Get character from user and push it
</td></tr>
<tr>
<td><code>@</code>
</td>
<td>End program
</td></tr>
<tr>
<td><code>0</code> – <code>9</code>
</td>
<td>Push corresponding number onto the stack
</td></tr></table>

