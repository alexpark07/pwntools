<% from pwnlib.shellcraft import arm, common %>
<%page args="filepath='./secret', flags=00, mode=None"/>
<%docstring>
open a file for reading/writing/sending to you

Args:
	filepath (str): filename to read with flags/mode
	flags (int/str): The argument flags must include one of the following access modes: O_RDONLY, O_WRONLY, or O_RDWR.  
	             These request opening  the  file  read-only,  write-only,  or read/write, respectively.
	mode (int/str): modes 
</%docstring>

<%
	filename   = common.label("filename")
	after_open = common.label("after_open")
%>

%if (int(flags) & 0100) != 0:
	if mode != None:
		mov r2, #${int(mode)}
%endif

	mov r1, #${int(flags)}
	adr r0, ${filename}
	svc SYS_open
	b ${after_open}
${filename}:
%if filepath:
	.asciz "${filepath}\x00"
	.align 2
%endif
${after_open}:
