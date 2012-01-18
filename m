Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RnMko-000218-Fm
 for kexec@lists.infradead.org; Wed, 18 Jan 2012 04:04:10 +0000
Date: Wed, 18 Jan 2012 09:40:55 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: makedumpfile can't build on Fedora 16
Message-Id: <20120118094055.239c362d.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <4F1613CC.9040405@cn.fujitsu.com>
References: <4F15A377.3090302@gmail.com>
	<4F1613CC.9040405@cn.fujitsu.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Wen Congyang <wency@cn.fujitsu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, kexec@lists.infradead.org


Hi,

On Wed, 18 Jan 2012 08:35:24 +0800
Wen Congyang <wency@cn.fujitsu.com> wrote:
> At 01/18/2012 12:36 AM, Cong Wang Wrote:
> > Hello, Atsushi,
> > 
> > I can't build the latest makedumpfile on Fedora 16,
> > 
> > [wangcong@cr0]~/makedumpfile% make
> > ...
> > gcc -g -O2 -Wall -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
> > -D_LARGEFILE64_SOURCE -DVERSION='"1.4.1"' -DRELEASE_DATE='"6 January
> > 2012"' -D__x86_64__  print_info.o dwarf_info.o elf_info.o erase_info.o
> > sadump_info.o arch/arm.o arch/x86.o arch/x86_64.o arch/ia64.o
> > arch/ppc64.o arch/s390x.o -o makedumpfile makedumpfile.c -static -ldw
> > -lbz2 -lebl -ldl -lelf -lz
> 
> The parameter has -static, so you need libc.a, libdw.a and ...
> Or you can remove -static, but you should ensure that there are these
> dynamic librarys in the second os.

That's right.
It has been written in README file of makedumpfile:

  002: makedumpfile is compiled with -static option, because the command should
       run while the second kernel, which may not mount root filesystem and may
       not contain dynamic library files, is running.
       If the dynamic library files, which are needed by makedumpfile, exist
       while the second kernel is running, we can remove -static option from
       Makefile. This is a workaround for some linux distributions which does
       not contain static library files needed by makedumpfile.


Thanks
Ken'ichi Ohmichi

> > makedumpfile.c: In function ‘__exclude_unnecessary_pages’:
> > makedumpfile.c:3625:15: warning: variable ‘_count’ set but not used
> > [-Wunused-but-set-variable]
> > /usr/bin/ld: cannot find -lbz2
> > /usr/bin/ld: cannot find -ldl
> > /usr/bin/ld: cannot find -lc
> > collect2: ld returned 1 exit status
> > make: *** [makedumpfile] Error 1
> > 
> > [wangcong@cr0]~/makedumpfile% rpm -ql bzip2-libs
> > /lib64/libbz2.so.1
> > /lib64/libbz2.so.1.0.6
> > /usr/share/doc/bzip2-libs-1.0.6
> > /usr/share/doc/bzip2-libs-1.0.6/LICENSE
> > 
> > So, I don't know why ld can't find libbz2 and libc... Any hints?
> > 
> > Thanks!
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> > 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
