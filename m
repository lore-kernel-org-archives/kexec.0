Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from wm14.inbox.com ([208.50.6.14])
	by canuck.infradead.org with smtp (Exim 4.63 #1 (Red Hat Linux))
	id 1I5OOE-0008NR-Lf
	for kexec@lists.infradead.org; Mon, 02 Jul 2007 12:04:41 -0400
Received: from inbox.com (127.0.0.1:25)
	by inbox.com with [InBox.Com SMTP Server]
	id <707020042994.WM14> for <kexec@lists.infradead.org> from
	<dseetharam@inbox.com>; Mon, 2 Jul 2007 8:04:08 AM -0800
Mime-Version: 1.0
Date: Mon, 2 Jul 2007 08:04:08 -0800
Message-ID: <A96B39B9BF4.000001A6dseetharam@inbox.com>
From: Dharmosoth Seetharam <dseetharam@inbox.com>
Subject: Re: problem with elfutils-0.125 for makedumpfile
In-Reply-To: <20070615164557oomichi@mail.jp.nec.com>
References: <c6430f72a46.000002f9dseetharam@inbox.com>
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: vgoyal@in.ibm.com, kexec@lists.infradead.org

Hi Ken'ichi Ohmichi,

Sorry for delayed reply!! I was not at work.


No, I tried with what you say but I am getting many error!!

I think this is the problem with the PATH (?).


[makedumpfile]# make
gcc -g -O2 -Wall -D_FILE_OFFSET_BITS=64 -DVERSION='"1.1.4"' -DRELEASE_DATE='"08 June 2007"' -D__x86_64__ x86.o x86_64.o ia64.o ppc64.o -o makedumpfile makedumpfile.c -static -ldw -lelf -lz
makedumpfile.c: In function `write_kdump_pages':
makedumpfile.c:4102: warning: implicit declaration of function `compressBound'
/tmp/ccwAfYOX.o(.text+0xa082): In function `write_kdump_pages':
/root/makedumpfile/makedumpfile.c:4102: undefined reference to `compressBound'
collect2: ld returned 1 exit status
make: *** [makedumpfile] Error 1
[root@ssn258 makedumpfile]# gcc -g -O2 -Wall -D_FILE_OFFSET_BITS=64 -DVERSION='"1.1.4"' -DRELEASE_DATE='"08 June 2007"' -D__x86_64__ x86.o x86_64.o ia64.o ppc64.o -o makedumpfile makedumpfile.c -static -lelf -lz
makedumpfile.c: In function `write_kdump_pages':
makedumpfile.c:4102: warning: implicit declaration of function `compressBound'
/tmp/ccFds0fs.o(.text+0x29f7): In function `get_data_member_location':
/root/makedumpfile/makedumpfile.c:967: undefined reference to `dwarf_attr'
/tmp/ccFds0fs.o(.text+0x2a1a):/root/makedumpfile/makedumpfile.c:970: undefined reference to `dwarf_getlocation'
/tmp/ccFds0fs.o(.text+0x2a6f): In function `get_die_type':
/root/makedumpfile/makedumpfile.c:984: undefined reference to `dwarf_dieoffset'
/tmp/ccFds0fs.o(.text+0x2a7a):/root/makedumpfile/makedumpfile.c:984: undefined reference to `dwarf_cuoffset'
/tmp/ccFds0fs.o(.text+0x2a8d):/root/makedumpfile/makedumpfile.c:989: undefined reference to `dwarf_attr'
/tmp/ccFds0fs.o(.text+0x2ac1):/root/makedumpfile/makedumpfile.c:992: undefined reference to `dwarf_formref'
/tmp/ccFds0fs.o(.text+0x2ada):/root/makedumpfile/makedumpfile.c:995: undefined reference to `dwarf_offdie'
/tmp/ccFds0fs.o(.text+0x2bd7): In function `get_data_array_length':
/root/makedumpfile/makedumpfile.c:1014: undefined reference to `dwarf_tag'
/tmp/ccFds0fs.o(.text+0x2beb):/root/makedumpfile/makedumpfile.c:1025: undefined reference to `dwarf_child'
/tmp/ccFds0fs.o(.text+0x2bf4):/root/makedumpfile/makedumpfile.c:1027: undefined reference to `dwarf_tag'
/tmp/ccFds0fs.o(.text+0x2c04):/root/makedumpfile/makedumpfile.c:1030: undefined reference to `dwarf_siblingof'
/tmp/ccFds0fs.o(.text+0x2c21):/root/makedumpfile/makedumpfile.c:1035: undefined reference to `dwarf_attr'
/tmp/ccFds0fs.o(.text+0x2c35):/root/makedumpfile/makedumpfile.c:1038: undefined reference to `dwarf_formudata'
/tmp/ccFds0fs.o(.text+0x2cd6): In function `check_array_type':
/root/makedumpfile/makedumpfile.c:1059: undefined reference to `dwarf_tag'
/tmp/ccFds0fs.o(.text+0x2d15): In function `search_member':
/root/makedumpfile/makedumpfile.c:1073: undefined reference to `dwarf_child'
/tmp/ccFds0fs.o(.text+0x2d2a):/root/makedumpfile/makedumpfile.c:1079: undefined reference to `dwarf_tag'
/tmp/ccFds0fs.o(.text+0x2d34):/root/makedumpfile/makedumpfile.c:1080: undefined reference to `dwarf_diename'
/tmp/ccFds0fs.o(.text+0x2d44):/root/makedumpfile/makedumpfile.c:1114: undefined reference to `dwarf_siblingof'
/tmp/ccFds0fs.o(.text+0x2e07): In function `search_structure':
/root/makedumpfile/makedumpfile.c:1164: undefined reference to `dwarf_tag'
/tmp/ccFds0fs.o(.text+0x2e11):/root/makedumpfile/makedumpfile.c:1165: undefined reference to `dwarf_diename'
/tmp/ccFds0fs.o(.text+0x2e21):/root/makedumpfile/makedumpfile.c:1177: undefined reference to `dwarf_siblingof'
/tmp/ccFds0fs.o(.text+0x2e8c):/root/makedumpfile/makedumpfile.c:1172: undefined reference to `dwarf_bytesize'
/tmp/ccFds0fs.o(.text+0x2ed8): In function `search_srcfile':
/root/makedumpfile/makedumpfile.c:1219: undefined reference to `dwarf_tag'
/tmp/ccFds0fs.o(.text+0x2ee2):/root/makedumpfile/makedumpfile.c:1220: undefined reference to `dwarf_diename'
/tmp/ccFds0fs.o(.text+0x2ef2):/root/makedumpfile/makedumpfile.c:1231: undefined reference to `dwarf_siblingof'
/tmp/ccFds0fs.o(.text+0x2f3f):/root/makedumpfile/makedumpfile.c:1226: undefined reference to `dwarf_decl_file'
/tmp/ccFds0fs.o(.text+0x2f65): In function `search_symbol':
/root/makedumpfile/makedumpfile.c:1255: undefined reference to `dwarf_tag'
/tmp/ccFds0fs.o(.text+0x2f70):/root/makedumpfile/makedumpfile.c:1256: undefined reference to `dwarf_diename'
/tmp/ccFds0fs.o(.text+0x2f84):/root/makedumpfile/makedumpfile.c:1262: undefined reference to `dwarf_siblingof'
/tmp/ccFds0fs.o(.text+0x3048): In function `search_die_tree':
/root/makedumpfile/makedumpfile.c:1294: undefined reference to `dwarf_child'
/tmp/ccFds0fs.o(.text+0x3155): In function `get_debug_info':
/root/makedumpfile/makedumpfile.c:1337: undefined reference to `dwarf_begin_elf'
/tmp/ccFds0fs.o(.text+0x31ef):/root/makedumpfile/makedumpfile.c:1363: undefined reference to `dwarf_nextcu'
/tmp/ccFds0fs.o(.text+0x320b):/root/makedumpfile/makedumpfile.c:1366: undefined reference to `dwarf_offdie'
/tmp/ccFds0fs.o(.text+0x3242):/root/makedumpfile/makedumpfile.c:1378: undefined reference to `dwarf_end'
/tmp/ccFds0fs.o(.text+0xa082): In function `write_kdump_pages':
/root/makedumpfile/makedumpfile.c:4102: undefined reference to `compressBound'
collect2: ld returned 1 exit status

The following is the PATH:

/usr/kerberos/sbin:/usr/kerberos/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:
/usr/X11R6/bin:/opt/filer/bin:/root/bin:/usr/local/include/:/usr/local:/usr/local/include/elfutils

I have copied those files to /usr/local/include/elfutils


Any comments ??

Thanks
Seetharam




> -----Original Message-----
> From: oomichi@mxs.nes.nec.co.jp
> Sent: Fri, 15 Jun 2007 16:45:57 +0900
> To: dseetharam@inbox.com
> Subject: Re: problem with elfutils-0.125 for makedumpfile
> 
> 
> Hi Dharmosoth,
> 
> 
> 2007/06/14 06:27:18 -0800, Dharmosoth Seetharam <dseetharam@inbox.com>
> wrote:
> >I tryinging to install makedumpfile utility program.
> >For this elfutils-0.125 should be installed on the same machine.
>> 
> >So, i have done the same thing.
>> 
> >After installing the "elfutils-0.125", I am getting the following error.
>> 
> >Can any one please tell me what should be the mistake i have done?
>> 
>> 
> >[root@tc210 makedumpfile]# make
> >gcc -g -O2 -Wall -D_FILE_OFFSET_BITS=64 -DVERSION='"1.1.4"'
> -DRELEASE_DATE='"08 June 2007"' -D__x86_64__ x86.o x86_64.o
>  ia64.o ppc64.o -o makedumpfile makedumpfile.c -static -ldw -lelf -lz
> >makedumpfile.c: In function `write_kdump_pages':
> >makedumpfile.c:4102: warning: implicit declaration of function
> `compressBound'
> >/usr/local/bin/ld: invalid option -- Y
> >Try `ld --help' or `ld --usage' for more information.
> >collect2: ld returned 64 exit status
> >make: *** [makedumpfile] Error 1
> 
> I think the cause is 'ld' installed by elfutils-0.125.
> elfutils-0.125 installs 'ld' into /usr/local/bin/ with the library files.
> For installing only necessary files, could you please try follows ?
> 
> - Uninstall elfutils-0.125
>   # cd elfutils-0.125
>   # make uninstall
>   #
> 
> - Make elfutils-0.125, and install only the library files.
>   # make clean
>   # ./configure
>   # make
>   #
>   # mkdir /usr/local/include/elfutils/
>   # cp ./libdw/libdw.h   /usr/local/include/elfutils/libdw.h
>   # cp ./libdw/dwarf.h   /usr/local/include/dwarf.h
>   # cp ./libelf/libelf.h /usr/local/include/libelf.h
>   # cp ./libelf/gelf.h   /usr/local/include/gelf.h
>   #
>   # cp ./libelf/libelf.a /usr/local/lib/libelf.a
>   # cp ./libdw/libdw.a   /usr/local/lib/libdw.a
>   # cp ./libasm/libasm.a /usr/local/lib/libasm.a
>   # cp ./libebl/libebl.a /usr/local/lib/libebl.a
>   #
> 
> If there are not any problems, I will add the above method to README
> file.
> 
> 
> Thanks
> Ken'ichi Ohmichi

____________________________________________________________
Listen & Record Music from Internet Radio - Get Free Radio & MP3 Player & Recorder
Learn more at http://www.inbox.com/radio

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
