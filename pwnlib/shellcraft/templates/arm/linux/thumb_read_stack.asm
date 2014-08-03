<% from pwnlib.shellcraft import arm, common %>
<% from pwnlib.util.misc import align %>
<% from pwnlib.asm import cpp %>
<%page args="in_fd=None, size=128, allocate_stack=True" />
<%docstring>
Reads to the stack in thumb mode.

You can optioanlly shave a few bytes not allocating the stack space.

Args: 
	in_fd (imm/reg)       = STDIN_FILENO
	size (int/str)        = 128
	allocate_stack(bool)  = True
</%docstring>

%if type(size) == str:
	size = int(size)
%endif

	.code 16
%if allocate_stack:
	sub sp, #${align(4, size)}
%endif

	movs r0, #${in_fd}
	movs r2, #${size}
	mov  r1, sp
	movs r7, #${cpp("SYS_read", arch = "thumb", os = "linux")}
	svc 1
	.align 2
