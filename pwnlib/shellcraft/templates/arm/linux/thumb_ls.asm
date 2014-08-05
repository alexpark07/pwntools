<% from pwnlib.shellcraft import common, arm %>
<% from pwnlib.asm import cpp %>
<%page args="filepath='.', in_fd = None, out_fd = None"/>
<%docstring>
``ls`` a directory list like UNIX Command in thumb mode

	Args: 
		filepath (str)  : target directory name (default: ``.``)
		in_fd  (int/str): in  file descriptor
		out_fd (int/str): out file descriptor
</%docstring>
<%
	looplabel = common.label("loop")
	nextlabel = common.label("next")
%>

	.code 16
${arm.linux.thumb_open_file(filepath)}

	subs r4, r4, r4
${looplabel}:
	${arm.linux.thumb_getdents(in_fd=in_fd)}
	cmp r0, r4
	ble ${nextlabel}
	${arm.linux.thumb_write_stack(out_fd=out_fd, size='r0')}
	bgt ${looplabel}

${nextlabel}:
