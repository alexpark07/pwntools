<% from pwnlib.shellcraft import arm, common %>
<% from pwnlib.asm import cpp %>
<%page args="sock = 4"/>
<%docstring>
	Args: [sock (int/str) = default: 4]
	Duplicates sock to stdin, stdout and stderr in thumb mode
</%docstring>
<%
	dup       = common.label("dup")
	looplabel = common.label("loop")
%>

	.thumb
${dup}:
	movs r1, #3
	movs r7, ${cpp("SYS_dup2", arch = "thumb", os = "linux")}
	subs r2, r2, r2

${looplabel}:
	movs r0, ${sock}
	subs r1, r1, #1
	svc 1
	cmp r1, r2
	bne ${looplabel}

