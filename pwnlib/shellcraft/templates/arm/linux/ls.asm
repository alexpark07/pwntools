<% from pwnlib.shellcraft import common, arm %>
<%page args="filepath='.', in_fd = None, out_fd = None"/>
<%docstring>
``ls`` a directory list like UNIX Command

	Args: 
		filepath (str)  : target directory name (default: ``.``)
		in_fd  (int/str): in  file descriptor
		out_fd (int/str): out file descriptor
</%docstring>
<%
	looplabel = common.label("loop")
	nextlabel = common.label("next")
%>

${arm.linux.open_file(filepath)}

	sub r4, r4, r4
${looplabel}:
	${arm.linux.getdents(in_fd=in_fd)}
	cmp r0, r4
	ble ${nextlabel}
	${arm.linux.write_stack(out_fd=out_fd, size="r2")}
	bgt ${looplabel}

${nextlabel}:
