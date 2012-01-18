Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-gx0-f177.google.com ([209.85.161.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RnVpK-0004pv-S5
 for kexec@lists.infradead.org; Wed, 18 Jan 2012 13:45:23 +0000
Received: by ggnl1 with SMTP id l1so4404775ggn.36
 for <kexec@lists.infradead.org>; Wed, 18 Jan 2012 05:45:21 -0800 (PST)
Message-ID: <4F16CCE5.1060500@gmail.com>
Date: Wed, 18 Jan 2012 21:45:09 +0800
From: Cong Wang <xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Subject: Re: makedumpfile can't build on Fedora 16
References: <4F15A377.3090302@gmail.com> <4F1613CC.9040405@cn.fujitsu.com>
 <20120118094055.239c362d.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <20120118094055.239c362d.oomichi@mxs.nes.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, kexec@lists.infradead.org, Wen Congyang <wency@cn.fujitsu.com>

On 01/18/2012 08:40 AM, Ken'ichi Ohmichi wrote:
> 
> Hi,
> 
> On Wed, 18 Jan 2012 08:35:24 +0800
> Wen Congyang<wency@cn.fujitsu.com>  wrote:
>> At 01/18/2012 12:36 AM, Cong Wang Wrote:
>>> Hello, Atsushi,
>>>
>>> I can't build the latest makedumpfile on Fedora 16,
>>>
>>> [wangcong@cr0]~/makedumpfile% make
>>> ...
>>> gcc -g -O2 -Wall -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
>>> -D_LARGEFILE64_SOURCE -DVERSION='"1.4.1"' -DRELEASE_DATE='"6 January
>>> 2012"' -D__x86_64__  print_info.o dwarf_info.o elf_info.o erase_info.o
>>> sadump_info.o arch/arm.o arch/x86.o arch/x86_64.o arch/ia64.o
>>> arch/ppc64.o arch/s390x.o -o makedumpfile makedumpfile.c -static -ldw
>>> -lbz2 -lebl -ldl -lelf -lz
>>
>> The parameter has -static, so you need libc.a, libdw.a and ...
>> Or you can remove -static, but you should ensure that there are these
>> dynamic librarys in the second os.
> 
> That's right.
> It has been written in README file of makedumpfile:

Hey,

This means we have to patch the source code by ourselves, why not
improve it? Something like below?

diff --git a/Makefile b/Makefile
index 9afbe1c..1361700 100644
--- a/Makefile
+++ b/Makefile
@@ -28,6 +28,11 @@ SRC_PART = print_info.c dwarf_info.c elf_info.c
erase_info.c sadump_info.c
 OBJ_PART = print_info.o dwarf_info.o elf_info.o erase_info.o sadump_info.o
 SRC_ARCH = arch/arm.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c
arch/s390x.c
 OBJ_ARCH = arch/arm.o arch/x86.o arch/x86_64.o arch/ia64.o arch/ppc64.o
arch/s390x.o
+LIBS := $(shell if $(CC) -static -ldw -lbz2 -lebl -ldl -lelf -lz
>&/dev/null; then \
+       echo "-static -ldw -lbz2 -lebl -ldl -lelf -lz"; \
+       else \
+       echo "-ldw -lbz2 -lebl -ldl -lelf -lz"; \
+       fi)

 all: makedumpfile

@@ -38,7 +43,7 @@ $(OBJ_ARCH): $(SRC_ARCH)
        $(CC) $(CFLAGS_ARCH) -c -o ./$@ ./$(@:.o=.c)

 makedumpfile: $(SRC) $(OBJ_PART) $(OBJ_ARCH)
-       $(CC) $(CFLAGS) $(LDFLAGS) $(OBJ_PART) $(OBJ_ARCH) -o $@ $<
-static -ldw -lbz2 -lebl -ldl -lelf -lz
+       $(CC) $(CFLAGS) $(LDFLAGS) $(OBJ_PART) $(OBJ_ARCH) -o $@ $< $(LIBS)
        echo .TH MAKEDUMPFILE 8 \"$(DATE)\" \"makedumpfile v$(VERSION)\"
\"Linux System Administrator\'s Manual\" > temp.8
        grep -v "^.TH MAKEDUMPFILE 8" makedumpfile.8 >> temp.8
        mv temp.8 makedumpfile.8

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
