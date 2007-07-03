Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1I5eFf-0003jy-FP
	for kexec@lists.infradead.org; Tue, 03 Jul 2007 05:00:54 -0400
Subject: Re: problem with elfutils-0.125 for makedumpfile
In-reply-to: <A96B39B9BF4.000001A6dseetharam@inbox.com>
Message-Id: <20070703180026oomichi@mail.jp.nec.com>
References: <A96B39B9BF4.000001A6dseetharam@inbox.com>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Tue, 3 Jul 2007 18:00:26 +0900
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Dharmosoth Seetharam <dseetharam@inbox.com>
Cc: vgoyal@in.ibm.com, kexec@lists.infradead.org


Hi Dharmosoth,

Thank you for the information.


2007/07/02 08:04:08 -0800, Dharmosoth Seetharam <dseetharam@inbox.com> wrote:
>No, I tried with what you say but I am getting many error!!
>
>I think this is the problem with the PATH (?).
>
>
>[makedumpfile]# make
>gcc -g -O2 -Wall -D_FILE_OFFSET_BITS=64 -DVERSION='"1.1.4"' -DRELEASE_DATE='"08 June 2007"' -D__x86_64__ x86.o x86_64.o
 ia64.o ppc64.o -o makedumpfile makedumpfile.c -static -ldw -lelf -lz
>makedumpfile.c: In function `write_kdump_pages':
>makedumpfile.c:4102: warning: implicit declaration of function `compressBound'
>/tmp/ccwAfYOX.o(.text+0xa082): In function `write_kdump_pages':
>/root/makedumpfile/makedumpfile.c:4102: undefined reference to `compressBound'
>collect2: ld returned 1 exit status
>make: *** [makedumpfile] Error 1
>[root@ssn258 makedumpfile]# gcc -g -O2 -Wall -D_FILE_OFFSET_BITS=64 -DVERSION='"1.1.4"' -DRELEASE_DATE='"08 June 2007"'
 -D__x86_64__ x86.o x86_64.o ia64.o ppc64.o -o makedumpfile makedumpfile.c -static -lelf -lz
>makedumpfile.c: In function `write_kdump_pages':
>makedumpfile.c:4102: warning: implicit declaration of function `compressBound'
>/tmp/ccFds0fs.o(.text+0x29f7): In function `get_data_member_location':
>/root/makedumpfile/makedumpfile.c:967: undefined reference to `dwarf_attr'
>/tmp/ccFds0fs.o(.text+0x2a1a):/root/makedumpfile/makedumpfile.c:970: undefined reference to `dwarf_getlocation'
>/tmp/ccFds0fs.o(.text+0x2a6f): In function `get_die_type':
>/root/makedumpfile/makedumpfile.c:984: undefined reference to `dwarf_dieoffset'
>/tmp/ccFds0fs.o(.text+0x2a7a):/root/makedumpfile/makedumpfile.c:984: undefined reference to `dwarf_cuoffset'
>/tmp/ccFds0fs.o(.text+0x2a8d):/root/makedumpfile/makedumpfile.c:989: undefined reference to `dwarf_attr'
>/tmp/ccFds0fs.o(.text+0x2ac1):/root/makedumpfile/makedumpfile.c:992: undefined reference to `dwarf_formref'
>/tmp/ccFds0fs.o(.text+0x2ada):/root/makedumpfile/makedumpfile.c:995: undefined reference to `dwarf_offdie'
>/tmp/ccFds0fs.o(.text+0x2bd7): In function `get_data_array_length':
>/root/makedumpfile/makedumpfile.c:1014: undefined reference to `dwarf_tag'
>/tmp/ccFds0fs.o(.text+0x2beb):/root/makedumpfile/makedumpfile.c:1025: undefined reference to `dwarf_child'
>/tmp/ccFds0fs.o(.text+0x2bf4):/root/makedumpfile/makedumpfile.c:1027: undefined reference to `dwarf_tag'
>/tmp/ccFds0fs.o(.text+0x2c04):/root/makedumpfile/makedumpfile.c:1030: undefined reference to `dwarf_siblingof'
>/tmp/ccFds0fs.o(.text+0x2c21):/root/makedumpfile/makedumpfile.c:1035: undefined reference to `dwarf_attr'
>/tmp/ccFds0fs.o(.text+0x2c35):/root/makedumpfile/makedumpfile.c:1038: undefined reference to `dwarf_formudata'
>/tmp/ccFds0fs.o(.text+0x2cd6): In function `check_array_type':
>/root/makedumpfile/makedumpfile.c:1059: undefined reference to `dwarf_tag'
>/tmp/ccFds0fs.o(.text+0x2d15): In function `search_member':
>/root/makedumpfile/makedumpfile.c:1073: undefined reference to `dwarf_child'
>/tmp/ccFds0fs.o(.text+0x2d2a):/root/makedumpfile/makedumpfile.c:1079: undefined reference to `dwarf_tag'
>/tmp/ccFds0fs.o(.text+0x2d34):/root/makedumpfile/makedumpfile.c:1080: undefined reference to `dwarf_diename'
>/tmp/ccFds0fs.o(.text+0x2d44):/root/makedumpfile/makedumpfile.c:1114: undefined reference to `dwarf_siblingof'
>/tmp/ccFds0fs.o(.text+0x2e07): In function `search_structure':
>/root/makedumpfile/makedumpfile.c:1164: undefined reference to `dwarf_tag'
>/tmp/ccFds0fs.o(.text+0x2e11):/root/makedumpfile/makedumpfile.c:1165: undefined reference to `dwarf_diename'
>/tmp/ccFds0fs.o(.text+0x2e21):/root/makedumpfile/makedumpfile.c:1177: undefined reference to `dwarf_siblingof'
>/tmp/ccFds0fs.o(.text+0x2e8c):/root/makedumpfile/makedumpfile.c:1172: undefined reference to `dwarf_bytesize'
>/tmp/ccFds0fs.o(.text+0x2ed8): In function `search_srcfile':
>/root/makedumpfile/makedumpfile.c:1219: undefined reference to `dwarf_tag'
>/tmp/ccFds0fs.o(.text+0x2ee2):/root/makedumpfile/makedumpfile.c:1220: undefined reference to `dwarf_diename'
>/tmp/ccFds0fs.o(.text+0x2ef2):/root/makedumpfile/makedumpfile.c:1231: undefined reference to `dwarf_siblingof'
>/tmp/ccFds0fs.o(.text+0x2f3f):/root/makedumpfile/makedumpfile.c:1226: undefined reference to `dwarf_decl_file'
>/tmp/ccFds0fs.o(.text+0x2f65): In function `search_symbol':
>/root/makedumpfile/makedumpfile.c:1255: undefined reference to `dwarf_tag'
>/tmp/ccFds0fs.o(.text+0x2f70):/root/makedumpfile/makedumpfile.c:1256: undefined reference to `dwarf_diename'
>/tmp/ccFds0fs.o(.text+0x2f84):/root/makedumpfile/makedumpfile.c:1262: undefined reference to `dwarf_siblingof'
>/tmp/ccFds0fs.o(.text+0x3048): In function `search_die_tree':
>/root/makedumpfile/makedumpfile.c:1294: undefined reference to `dwarf_child'
>/tmp/ccFds0fs.o(.text+0x3155): In function `get_debug_info':
>/root/makedumpfile/makedumpfile.c:1337: undefined reference to `dwarf_begin_elf'
>/tmp/ccFds0fs.o(.text+0x31ef):/root/makedumpfile/makedumpfile.c:1363: undefined reference to `dwarf_nextcu'
>/tmp/ccFds0fs.o(.text+0x320b):/root/makedumpfile/makedumpfile.c:1366: undefined reference to `dwarf_offdie'
>/tmp/ccFds0fs.o(.text+0x3242):/root/makedumpfile/makedumpfile.c:1378: undefined reference to `dwarf_end'
>/tmp/ccFds0fs.o(.text+0xa082): In function `write_kdump_pages':
>/root/makedumpfile/makedumpfile.c:4102: undefined reference to `compressBound'
>collect2: ld returned 1 exit status
>
>The following is the PATH:
>
>/usr/kerberos/sbin:/usr/kerberos/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:
>/usr/X11R6/bin:/opt/filer/bin:/root/bin:/usr/local/include/:/usr/local:/usr/local/include/elfutils
>
>I have copied those files to /usr/local/include/elfutils

Did you copy all files (libdw.h, dwarf.h, libelf.h, gelf.h, libelf.a, libdw.a,
libasm.a, and libebl.a) to the paths I specified ?

>>   # cp ./libdw/libdw.h   /usr/local/include/elfutils/libdw.h
>>   # cp ./libdw/dwarf.h   /usr/local/include/dwarf.h
>>   # cp ./libelf/libelf.h /usr/local/include/libelf.h
>>   # cp ./libelf/gelf.h   /usr/local/include/gelf.h
>>   #
>>   # cp ./libelf/libelf.a /usr/local/lib/libelf.a
>>   # cp ./libdw/libdw.a   /usr/local/lib/libdw.a
>>   # cp ./libasm/libasm.a /usr/local/lib/libasm.a
>>   # cp ./libebl/libebl.a /usr/local/lib/libebl.a


If you do it and get the above error, could you please change makedumpfile's
Makefile like the following (-L/usr/local/lib/ is added) ?
And let me know the result.

CFLAGS = -g -O2 -Wall -D_FILE_OFFSET_BITS=64 -L/usr/local/lib/ \
          -DVERSION='"$(VERSION)"' -DRELEASE_DATE='"$(DATE)"'

And I guess your system doesn't have zlib library.
Could you check it also ?


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
