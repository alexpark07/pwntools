<% from pwnlib.shellcraft import arm, common %>
<% from pwnlib.asm import cpp %>
<%page args="out_fd=None, size=255" />
<%docstring>
Writes a file from stack in thumb mode

Args: 
	out_fd (imm/reg)        = STDIN_FILENO
	size (int/str/imm/reg)  = 255
</%docstring>

	.code 16
	movs r2, ${size}
	movs r0, ${out_fd}
	mov r1, sp
	movs r7, ${cpp("SYS_write", arch = "thumb", os = "linux")}
	svc 1
