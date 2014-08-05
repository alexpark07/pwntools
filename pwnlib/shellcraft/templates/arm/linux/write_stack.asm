<% from pwnlib.shellcraft import arm, common %>
<%page args="out_fd=None, size=255" />
<%docstring>
Writes a file from stack 

Args: 
	out_fd (imm/reg)       = STDIN_FILENO
	size (int/str/imm/reg) = 255
</%docstring>

	mov r2, ${size}
	mov r0, ${out_fd}
	mov r1, sp
	svc SYS_write
