Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RoBYl-0004YH-Kq
 for kexec@lists.infradead.org; Fri, 20 Jan 2012 10:19:08 +0000
Date: Fri, 20 Jan 2012 16:35:05 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: makedumpfile can't build on Fedora 16
Message-Id: <20120120163505.7ca68741.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <20120120160322.d5dbd362.kumagai-atsushi@mxc.nes.nec.co.jp>
References: <4F15A377.3090302@gmail.com> <4F1613CC.9040405@cn.fujitsu.com>
 <20120118094055.239c362d.oomichi@mxs.nes.nec.co.jp>
 <4F16CCE5.1060500@gmail.com>
 <20120119165816.125f11b0.oomichi@mxs.nes.nec.co.jp>
 <20120120160322.d5dbd362.kumagai-atsushi@mxc.nes.nec.co.jp>
Mime-Version: 1.0
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: xiyou.wangcong@gmail.com, kexec@lists.infradead.org, wency@cn.fujitsu.com


Hi,

On Fri, 20 Jan 2012 16:03:22 +0900
Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:
> > 
> > On Wed, 18 Jan 2012 21:45:09 +0800
> > Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > > >>> ...
> > > >>> gcc -g -O2 -Wall -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
> > > >>> -D_LARGEFILE64_SOURCE -DVERSION='"1.4.1"' -DRELEASE_DATE='"6 January
> > > >>> 2012"' -D__x86_64__  print_info.o dwarf_info.o elf_info.o erase_info.o
> > > >>> sadump_info.o arch/arm.o arch/x86.o arch/x86_64.o arch/ia64.o
> > > >>> arch/ppc64.o arch/s390x.o -o makedumpfile makedumpfile.c -static -ldw
> > > >>> -lbz2 -lebl -ldl -lelf -lz
> > > >>
> > > >> The parameter has -static, so you need libc.a, libdw.a and ...
> > > >> Or you can remove -static, but you should ensure that there are these
> > > >> dynamic librarys in the second os.
> > > > 
> > > > That's right.
> > > > It has been written in README file of makedumpfile:
> > > 
> > > Hey,
> > > 
> > > This means we have to patch the source code by ourselves, why not
> > > improve it? Something like below?
> > 
> > I guess someone will send "makedumpfile can't run on ..." even if
> > your patch is merged, because these dynamic libraries should be
> > included in the second os and it is easy to forget that.
> > The compiling error is an easy way to notice it, I feel.
> > What do you think, Kumagai-san ?
> > 
> > 
> > Thanks
> > Ken'ichi Ohmichi
> 
> Thank you for your explanation, Ohmichi-san, I agree with you.
> 
> I think that makedumpfile should be compiled with -static option,
> because it must be executable in many environment as possible, e.g. even if
> there are no dynamic libraries in 2nd kernel environment. (as written in README)
> 
> But I've got some requests to build it using dynamic libraries,
> so I will change the Makefile as attached patch. 
>  
> If you want to build makedumpfile using dynamic libraries,
> you need "LINKTYPE=dynamic"(see below).

I like it. good idea :-)


Thanks
Ken'ichi Ohmichi

> How to build:
>   a) linking static libraries (default)
>     $ make
>     ...
>     $ ldd makedumpfile
>         not a dynamic executable
>   
>   b) linking dynamic libraries
>     $ make LINKTYPE=dynamic
>     ...
>     $ ldd makedumpfile
>         libdw.so.1 => /usr/lib64/libdw.so.1 (0x0000003ca2800000)
>         libbz2.so.1 => /usr/lib64/libbz2.so.1 (0x000000394b200000)
>         libdl.so.2 => /lib64/libdl.so.2 (0x00000031a5a00000)
>         libelf.so.1 => /usr/lib64/libelf.so.1 (0x0000003ca2400000)
>         libz.so.1 => /usr/lib64/libz.so.1 (0x00000031a6200000)
>         libc.so.6 => /lib64/libc.so.6 (0x00000031a5200000)
>         /lib64/ld-linux-x86-64.so.2 (0x00000031a4e00000)
> 
> What do you think, Cong?
> 
> Thanks
> Atsushi Kumagai
> 
> 
> diff --git a/Makefile b/Makefile
> index 9afbe1c..b14f09c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -29,6 +29,12 @@ OBJ_PART = print_info.o dwarf_info.o elf_info.o erase_info.o sadump_info.o
>  SRC_ARCH = arch/arm.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c
>  OBJ_ARCH = arch/arm.o arch/x86.o arch/x86_64.o arch/ia64.o arch/ppc64.o arch/s390x.o
> 
> +ifeq ($(LINKTYPE), dynamic)
> +LIBS = -ldw -lbz2 -lebl -ldl -lelf -lz
> +else
> +LIBS = -static -ldw -lbz2 -lebl -ldl -lelf -lz
> +endif
> +
>  all: makedumpfile
> 
>  $(OBJ_PART): $(SRC_PART)
> @@ -38,7 +44,7 @@ $(OBJ_ARCH): $(SRC_ARCH)
>         $(CC) $(CFLAGS_ARCH) -c -o ./$@ ./$(@:.o=.c)
> 
>  makedumpfile: $(SRC) $(OBJ_PART) $(OBJ_ARCH)
> -       $(CC) $(CFLAGS) $(LDFLAGS) $(OBJ_PART) $(OBJ_ARCH) -o $@ $< -static -ldw -lbz2 -lebl -ldl -lelf -lz
> +       $(CC) $(CFLAGS) $(LDFLAGS) $(OBJ_PART) $(OBJ_ARCH) -o $@ $< $(LIBS)
>         echo .TH MAKEDUMPFILE 8 \"$(DATE)\" \"makedumpfile v$(VERSION)\" \"Linux System Administrator\'s Manual\" > temp.8
>         grep -v "^.TH MAKEDUMPFILE 8" makedumpfile.8 >> temp.8
>         mv temp.8 makedumpfile.8

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
