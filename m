Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IS6ns-0004Vg-3t
	for kexec@lists.infradead.org; Mon, 03 Sep 2007 08:57:05 +0100
Subject: Re: [RFC] makedumpfile-1.1.4-rc: ia64 DISCONTIGMEM support
In-reply-to: <20070831104951.f88cc3ba.rdunlap@xenotime.net>
Message-Id: <20070903165708tachibana@mail.jp.nec.com>
References: <20070831104951.f88cc3ba.rdunlap@xenotime.net>
Mime-Version: 1.0
From: tachibana@mxm.nes.nec.co.jp
Date: Mon, 3 Sep 2007 16:57:08 +0900
Reply-To: tachibana@mxm.nes.nec.co.jp
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
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org

Hi Randy,

On Fri, 31 Aug 2007 10:49:51 -0700, Randy Dunlap <rdunlap@xenotime.net> wrote:
> On Fri, 31 Aug 2007 09:49:28 -0700 Randy Dunlap wrote:
> 
> > On Fri, 31 Aug 2007 22:07:28 +0900 tachibana@mxm.nes.nec.co.jp wrote:
> > 
> > > Hi Randy,
> > > 
> > > On Thu, 30 Aug 2007 12:58:05 -0700, Randy Dunlap <rdunlap@xenotime.net> wrote:
> > > > On Thu, 30 Aug 2007 12:49:51 -0700 Randy Dunlap wrote:
> > > > 
> > > > > On Fri, 1 Jun 2007 18:11:14 +0900 Ken'ichi Ohmichi wrote:
> > > > > 
> > > > > > Hi,
> > > > > > 
> > > > > > The attached patch is for the development, and it isn't stable yet.
> > > > > > This patch can be applied to makedumpfile version 1.1.3.
> > > > > > If you find some problems in this patch, please let me know.
> > > > > > If there aren't any problems, I will release a new makedumpfile
> > > > > > by next weekend.
> > > > > > 
> > > > > > diff -puN backup/v1.1.3/README makedumpfile/README
> > > > > > --- backup/v1.1.3/README	2007-04-13 15:44:55.000000000 +0900
> > > > > > +++ makedumpfile/README	2007-06-01 13:05:19.000000000 +0900
> > > > > > @@ -3,6 +3,10 @@
> > > > > >   makdumpfile's README
> > > > > >  ======================
> > > > > >  
> > > > > > +* REQUIREMENTS
> > > > > > +  Please download the following library file and install it:
> > > > > > +  - elfutils-0.125.tar.gz
> > > > > > +
> > > > > 
> > > > > Is elfutils-0.125 (precisely that version number) required, or
> > > 
> > > Yes.  Please use the specified version.
> > 
> > Hi,
> > 
> > I did that, but I still cannot build a kernel, although the problem
> > is different now.  The build fails with:
> > 
> > Inconsistent kallsyms data
> > Try setting CONFIG_KALLSYMS_EXTRA_PASS
> > make: *** [vmlinux] Error 1
> > 
> > 
> > even after I set/enable CONFIG_KALLSYMS_EXTRA_PASS.
> > 
> > 
> > Have you tested this on x86_64?

Makefile installs ld command etc. and they influence kernel build.
We installed elfutils-0.125 not by 'make install' but by procedure 
written at README of makedumpfile-1.1.6 in RHEL5.0 environment.
Please uninstall elfutils-0.125 and elfutils-0.128 and try the above
procedure.

The procedure is as follos:
     # tar -zxvf elfutils-0.125.tar.gz
     # cd elfutils-0.125
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


Thanks
tachibana


> 
> Sorry about this.  Above was with the distro-installed 'ld' instead
> of the one built from elfutils-0.125.  When I correct this,
> build fails like this:
> 
>   CHK     include/linux/version.h
>   CHK     include/linux/utsrelease.h
>   CALL    scripts/checksyscalls.sh
>   CHK     include/linux/compile.h
>   SYSCALL arch/x86_64/vdso/vdso.so
> /usr/local/bin/ld: unrecognized option `--hash-style=gnu'
> Try `ld --help' or `ld --usage' for more information.
> collect2: ld returned 64 exit status
> make[1]: *** [arch/x86_64/vdso/vdso.so] Error 1
> make: *** [arch/x86_64/vdso] Error 2
> make: *** Waiting for unfinished jobs....
>   SYSCALL arch/x86_64/ia32/vsyscall-sysenter.so
> /usr/local/bin/ld: unrecognized option `--hash-style=gnu'
> Try `ld --help' or `ld --usage' for more information.
> collect2: ld returned 64 exit status
> make[1]: *** [arch/x86_64/ia32/vsyscall-sysenter.so] Error 1
> make: *** [arch/x86_64/ia32] Error 2
> 
> 
> > Thanks.
> > 
> > > > > could this be elfutils-0.125.tar.gz or later?
> > > > > I.e., is there something special/specific about elfutils-0.125 ?
> > > > > 
> > > > > It's a bit difficult to find 0.125 on the internet...
> > > > 
> > > > The reason that I ask the question(s) is that after I build
> > > > elfutils-0.128 and then do 'make install', I can no longer
> > > > build a kernel, i.e., kernel 'make' has errors, like:
> > > > 
> > > >   CC      init/main.o
> > > >   CC      init/do_mounts.o
> > > >   CC      init/do_mounts_rd.o
> > > >   AS      usr/initramfs_data.o
> > > >   LD      usr/built-in.o
> > > > ld: cannot load ld backend library 'libld_elf_x86_64.so': libld_elf_x86_64.so: cannot open shared object file: N
o such
> > >  file or directory
> > > > make[1]: *** [usr/built-in.o] Error 1
> > > > make: *** [usr] Error 2
> > > > make: *** Waiting for unfinished jobs....
> > > >   CC      init/do_mounts_initrd.o
> > > >   CC      init/initramfs.o
> > > >   CC      init/calibrate.o
> > > >   CC      init/version.o
> > > >   LD      init/mounts.o
> > > > ld: cannot load ld backend library 'libld_elf_x86_64.so': libld_elf_x86_64.so: cannot open shared object file: N
o such
> > >  file or directory
> > > > make[1]: *** [init/mounts.o] Error 1
> > > > make[1]: *** Waiting for unfinished jobs....
> > > > make: *** [init] Error 2
> > > > 
> > > > 
> > > > on x86_64.
> > > > 
> > > > 
> > > > > >  * BUILD & INSTALL
> > > > > >    1.Get the latest makedumpfile from the following site:
> > > > > >      https://sourceforge.net/projects/makedumpfile/
> > 
> > 
> > ---
> > ~Randy
> > *** Remember to use Documentation/SubmitChecklist when testing your code ***
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> > 
> 
> 
> ---
> ~Randy
> *** Remember to use Documentation/SubmitChecklist when testing your code ***

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
