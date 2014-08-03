<% from pwnlib.shellcraft import common %>
<%docstring>
Returns code to switch from arm to thumb mode.

Technically this only makes sense in arm mode, but thumb mode is included,
so you can do:
		```context(arch = 'thumb')
		arm_to_thumb() +  some_other_thumb_code()```

Suitable assembler directives are includes so this will work.
</%docstring>

	.arm
	add r3, pc, #1
	bx r3
	.thumb
