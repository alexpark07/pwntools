<% from pwnlib.shellcraft import arm, common %>
<% from pwnlib.util.misc import arm_fixup %>
<% from socket import htons %>
<%page args="port=None"/>
<%docstring>
	find a socket, which is connected to the specified port
	Leaves socket in r0 reg.

	Args:
		port (int/str): specific port
</%docstring>
<%
	findpeer  = common.label("findpeer")
	looplabel = common.label("looplabel")
%>

${findpeer}:
	movs r5, #-1
	mov r3, sp

${looplabel}:
	mov sp, r3
	add r5, r5, #1
	mov r0, r5
	movs r2, #4
	push {r2}
	mov r2, sp
	add r1, sp, #32
	svc SYS_getpeername

%if port == None:
	cmp r0, #0
	bne ${looplabel}
%else:
	ldrh r1, [r1, #2]
	mov r2, #4
	${arm_fixup(htons(int(port)))}
	cmp r1, r7
	bne ${looplabel}
%endif
	mov r0, r5
