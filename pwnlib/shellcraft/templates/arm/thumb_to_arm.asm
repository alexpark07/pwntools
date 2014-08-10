<% from pwnlib.shellcraft import common %>
<%docstring>
Returns code to switch from thumb to arm mode.

Technically this only makes sense in thumb mode, but arm mode is included,
so you can do:

```
context(arch = 'thumb')
thumb_to_arm() + '\n' +  some_other_arm_code() + '\n'
```
Suitable assembler directives are includes so this will work.

</%docstring>


		.thumb
		.align 2
		bx pc
		nop
		.arm
