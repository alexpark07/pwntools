<% from pwnlib.shellcraft import common %>
<%docstring>nop in thumb mode</%docstring>

	.code 16
	orrs r4, r4
