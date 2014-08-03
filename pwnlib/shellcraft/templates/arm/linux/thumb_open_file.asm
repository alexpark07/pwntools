<% from pwnlib.shellcraft import arm, common %>
<% from pwnlib.asm import cpp %>
<%page args="filepath='./secret', flags=00, mode=None"/>
<%docstring>
open a file for reading/writing/sending to you in thumb mode

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

	.code 16
%if (int(flags) & 0100) != 0:
	if mode != None:
		movs r2, #${int(mode)}
%endif
	adr r0, ${filename}
	movs r1, #${int(flags)}
	movs r7, #${cpp("SYS_open", arch = "thumb", os = "linux")}
	svc 1
	bl ${after_open}

${filename}:
		.asciz "${filepath}\x00"

${after_open}:
