Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Hz6Vm-0004FU-4x
	for kexec@lists.infradead.org; Fri, 15 Jun 2007 03:46:29 -0400
Subject: Re: problem with elfutils-0.125 for makedumpfile
In-reply-to: <C6430F72A46.000002F9dseetharam@inbox.com>
Message-Id: <20070615164557oomichi@mail.jp.nec.com>
References: <C6430F72A46.000002F9dseetharam@inbox.com>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Fri, 15 Jun 2007 16:45:57 +0900
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


2007/06/14 06:27:18 -0800, Dharmosoth Seetharam <dseetharam@inbox.com> wrote:
>I tryinging to install makedumpfile utility program.
>For this elfutils-0.125 should be installed on the same machine.
>
>So, i have done the same thing.
>
>After installing the "elfutils-0.125", I am getting the following error.
>
>Can any one please tell me what should be the mistake i have done?
>
>
>[root@tc210 makedumpfile]# make
>gcc -g -O2 -Wall -D_FILE_OFFSET_BITS=64 -DVERSION='"1.1.4"' -DRELEASE_DATE='"08 June 2007"' -D__x86_64__ x86.o x86_64.o
 ia64.o ppc64.o -o makedumpfile makedumpfile.c -static -ldw -lelf -lz
>makedumpfile.c: In function `write_kdump_pages':
>makedumpfile.c:4102: warning: implicit declaration of function `compressBound'
>/usr/local/bin/ld: invalid option -- Y
>Try `ld --help' or `ld --usage' for more information.
>collect2: ld returned 64 exit status
>make: *** [makedumpfile] Error 1

I think the cause is 'ld' installed by elfutils-0.125.
elfutils-0.125 installs 'ld' into /usr/local/bin/ with the library files.
For installing only necessary files, could you please try follows ?

- Uninstall elfutils-0.125
  # cd elfutils-0.125
  # make uninstall
  #

- Make elfutils-0.125, and install only the library files.
  # make clean
  # ./configure
  # make
  #
  # mkdir /usr/local/include/elfutils/
  # cp ./libdw/libdw.h   /usr/local/include/elfutils/libdw.h
  # cp ./libdw/dwarf.h   /usr/local/include/dwarf.h
  # cp ./libelf/libelf.h /usr/local/include/libelf.h
  # cp ./libelf/gelf.h   /usr/local/include/gelf.h
  #
  # cp ./libelf/libelf.a /usr/local/lib/libelf.a
  # cp ./libdw/libdw.a   /usr/local/lib/libdw.a
  # cp ./libasm/libasm.a /usr/local/lib/libasm.a
  # cp ./libebl/libebl.a /usr/local/lib/libebl.a
  #

If there are not any problems, I will add the above method to README file.


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
