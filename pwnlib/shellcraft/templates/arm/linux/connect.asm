<% from pwnlib.shellcraft import arm, common %>
<% from pwnlib.util.misc import binary_ip %>
<% from pwnlib.util.packing import u32 %>
<% from socket import htons %>
<%page args="host='127.0.0.1', port=31337"/>
<%docstring>
	Connects to host on port.

	Args:
		host (str)    : remote hostname or address (default: localhost)
		port (int/str): specific port (default: 31337)
</%docstring>
<%
	sockaddr       = common.label("sockaddr")
	after_sockaddr = common.label("after_sockaddr")
%>

	mov r0, AF_INET
	mov r1, SOCK_STREAM
	sub r2, r2, r2
	svc SYS_socket

	adr r1, ${sockaddr}
	mov r2, #16
	mov r3, AF_INET
	mov r6, r0

	strh r3, [r1]
	b ${after_sockaddr}
	sub r1, r1, r1

${sockaddr}:
	.short 0x4141
	.short ${htons(int(port))}
	.word  ${u32(binary_ip(host))}

${after_sockaddr}:
	svc SYS_connect
