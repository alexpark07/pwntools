<% from pwnlib.shellcraft import arm, common %>
<% from pwnlib.asm import cpp %>
<%page args="sock = 'r9'"/>
<%docstring>
	Args: [sock (imm/reg) = r9]
	Duplicates sock to stdin, stdout and stderr in thumb mode
</%docstring>
<%
	dup       = common.label("dup")
	looplabel = common.label("loop")
%>

${arm.arm_to_thumb()}

	mov r1, #3
	mov r7, ${cpp("SYS_dup2", arch = "thumb", os = "linux")}
	sub r2, r2, r2

${looplabel}:
	mov r0, ${sock}
	sub r1, r1, #1
	svc 1
	cmp r1, r2
	bne ${looplabel}

