<% from pwnlib.shellcraft import arm, common %>
<% from pwnlib.util.misc import binary_ip %>
<% from pwnlib.util.packing import u32 %>
<% from socket import htons %>
<%page args="port=31337"/>
<%docstring>
    listens on specific port

    Args:
        port (int/str): specific port (default: 31337)
</%docstring>
<%
    sockaddr_in       = common.label("sockaddr_in")
    after_sockaddr_in = common.label("after_sockaddr_in")
%>

    mov r0, AF_INET
    mov r1, SOCK_STREAM
    sub r2, r2, r2
    svc SYS_socket
    mov r6, r0

    adr r4, ${sockaddr_in}
    ldr r1, [r4]
    sub r2, r2, r2
    push { r1, r2 }
    mov r0, r6
    mov r1, sp
    mov r2, #16
    svc SYS_bind
    b ${after_sockaddr_in}

${sockaddr_in}:
    .short AF_INET
    .short ${htons(int(port))}

${after_sockaddr_in}:
    mov r1, #16
    mov r0, r6
    svc SYS_listen

    mov r0, r6
    sub r1, r1, r1
    sub r2, r2, r2
    svc SYS_accept
