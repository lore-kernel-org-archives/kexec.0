Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by casper.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RnJSr-0007tH-Fq
 for kexec@lists.infradead.org; Wed, 18 Jan 2012 00:33:23 +0000
Message-ID: <4F1613CC.9040405@cn.fujitsu.com>
Date: Wed, 18 Jan 2012 08:35:24 +0800
From: Wen Congyang <wency@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: makedumpfile can't build on Fedora 16
References: <4F15A377.3090302@gmail.com>
In-Reply-To: <4F15A377.3090302@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: kexec@lists.infradead.org, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>

At 01/18/2012 12:36 AM, Cong Wang Wrote:
> Hello, Atsushi,
> =

> I can't build the latest makedumpfile on Fedora 16,
> =

> [wangcong@cr0]~/makedumpfile% make
> ...
> gcc -g -O2 -Wall -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE
> -D_LARGEFILE64_SOURCE -DVERSION=3D'"1.4.1"' -DRELEASE_DATE=3D'"6 January
> 2012"' -D__x86_64__  print_info.o dwarf_info.o elf_info.o erase_info.o
> sadump_info.o arch/arm.o arch/x86.o arch/x86_64.o arch/ia64.o
> arch/ppc64.o arch/s390x.o -o makedumpfile makedumpfile.c -static -ldw
> -lbz2 -lebl -ldl -lelf -lz

The parameter has -static, so you need libc.a, libdw.a and ...
Or you can remove -static, but you should ensure that there are these
dynamic librarys in the second os.

Thanks
Wen Congyang

> makedumpfile.c: In function =91__exclude_unnecessary_pages=92:
> makedumpfile.c:3625:15: warning: variable =91_count=92 set but not used
> [-Wunused-but-set-variable]
> /usr/bin/ld: cannot find -lbz2
> /usr/bin/ld: cannot find -ldl
> /usr/bin/ld: cannot find -lc
> collect2: ld returned 1 exit status
> make: *** [makedumpfile] Error 1
> =

> [wangcong@cr0]~/makedumpfile% rpm -ql bzip2-libs
> /lib64/libbz2.so.1
> /lib64/libbz2.so.1.0.6
> /usr/share/doc/bzip2-libs-1.0.6
> /usr/share/doc/bzip2-libs-1.0.6/LICENSE
> =

> So, I don't know why ld can't find libbz2 and libc... Any hints?
> =

> Thanks!
> =

> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> =



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
