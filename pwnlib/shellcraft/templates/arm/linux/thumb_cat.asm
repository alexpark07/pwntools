<% from pwnlib.shellcraft import common, arm %>
<% from pwnlib.asm import cpp %>
<%page args="filepath='./secret', in_fd = None, out_fd = None"/>
<%docstring>
``cat`` a file like UNIX Command

	Args: 
		filepath (str)  : target file name
		in_fd  (int/str): in  file descriptor
		out_fd (int/str): out file descriptor
</%docstring>
<%
	looplabel = common.label("loop")
%>

${arm.linux.thumb_open_file(filepath)}
	.code 16
	subs r4, r4, r4
${looplabel}:
	${arm.linux.thumb_sendfile(in_fd=in_fd, out_fd=out_fd, size=255)}
	cmp r0, r4
	bgt ${looplabel}

