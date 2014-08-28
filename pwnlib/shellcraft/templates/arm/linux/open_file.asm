<<<<<<< HEAD
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
=======
<%page args="filepath, flags = 'O_RDONLY', mode = 0644"/>
<%docstring>Opens a file. Leaves the file descriptor in r0.

Args:
  filepath(str): The file to open.
  flags(int/str): The flags to call open with.
  mode(int/str): The attribute to create the flag. Only matters of ``flags & O_CREAT`` is set.
</%docstring>
<%
  from pwnlib.shellcraft.common import label
  from pwnlib.asm import cpp
  from pwnlib.util.safeeval import expr
  from pwnlib.constants.linux import arm as consts
  filepath_lab, after = label("filepath"), label("after")
  filepath_out = [hex(ord(c)) for c in filepath]
  while True:
      filepath_out.append("0")
      if len(filepath_out) % 4 == 0:
          break
  filepath_out = ', '.join(filepath_out)

  if isinstance(mode, (int, long)):
      mode = hex(mode)
%>
%if expr(cpp("%s & O_CREAT" % flags, arch = 'arm', os = 'linux')):
    mov r2, #(${mode})
%endif
    mov r1, #(${flags})
    adr r0, ${filepath_lab}
    svc SYS_open
    b ${after}

    /* The string ${repr(str(filepath))} */
${filepath_lab}: .byte ${filepath_out}

${after}:
>>>>>>> upstream/master
