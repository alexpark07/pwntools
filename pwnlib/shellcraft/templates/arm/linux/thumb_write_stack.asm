<% from pwnlib.shellcraft import arm, common %>
<% from pwnlib.asm import cpp %>
<%page args="out_fd=None, size=255" />
<%docstring>
Writes a file from stack in thumb mode

Args: 
	out_fd (imm/reg)   = STDIN_FILENO
	size (int/str)     = 255
</%docstring>

%if type(size) == str:
	size = int(size)
%endif

	.code 16
	movs r0, #${out_fd}
	movs r2, #${size}
	mov r1, sp
	movs r7, #${cpp("SYS_write", arch = "thumb", os = "linux")}
	svc 1
