<% from pwnlib.shellcraft import arm, common %>
<% from pwnlib.util.misc import align %>
<%page args="in_fd=None, size=255, allocate_stack=True" />
<%docstring>
Reads to the stack.

You can optioanlly shave a few bytes not allocating the stack space.

Args: 
	in_fd (imm/reg)       = STDIN_FILENO
	size (int/str)        = 255
	allocate_stack(bool)  = True
</%docstring>

%if allocate_stack:
	sub sp, ${align(4, int(size))}
%endif
	mov r0, ${in_fd}
	mov r2, ${size}
	mov r1, sp
	svc SYS_read
