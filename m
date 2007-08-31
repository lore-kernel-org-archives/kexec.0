Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IR6Dt-0005vX-0S
	for kexec@lists.infradead.org; Fri, 31 Aug 2007 14:07:46 +0100
Subject: Re: [RFC] makedumpfile-1.1.4-rc: ia64 DISCONTIGMEM support
In-reply-to: <20070830125805.19c739a5.rdunlap@xenotime.net>
Message-Id: <20070831220728tachibana@mail.jp.nec.com>
References: <20070830125805.19c739a5.rdunlap@xenotime.net>
Mime-Version: 1.0
From: tachibana@mxm.nes.nec.co.jp
Date: Fri, 31 Aug 2007 22:07:28 +0900
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

On Thu, 30 Aug 2007 12:58:05 -0700, Randy Dunlap <rdunlap@xenotime.net> wrote:
> On Thu, 30 Aug 2007 12:49:51 -0700 Randy Dunlap wrote:
> 
> > On Fri, 1 Jun 2007 18:11:14 +0900 Ken'ichi Ohmichi wrote:
> > 
> > > Hi,
> > > 
> > > The attached patch is for the development, and it isn't stable yet.
> > > This patch can be applied to makedumpfile version 1.1.3.
> > > If you find some problems in this patch, please let me know.
> > > If there aren't any problems, I will release a new makedumpfile
> > > by next weekend.
> > > 
> > > diff -puN backup/v1.1.3/README makedumpfile/README
> > > --- backup/v1.1.3/README	2007-04-13 15:44:55.000000000 +0900
> > > +++ makedumpfile/README	2007-06-01 13:05:19.000000000 +0900
> > > @@ -3,6 +3,10 @@
> > >   makdumpfile's README
> > >  ======================
> > >  
> > > +* REQUIREMENTS
> > > +  Please download the following library file and install it:
> > > +  - elfutils-0.125.tar.gz
> > > +
> > 
> > Is elfutils-0.125 (precisely that version number) required, or

Yes.  Please use the specified version.

Thanks
tachibana


> > could this be elfutils-0.125.tar.gz or later?
> > I.e., is there something special/specific about elfutils-0.125 ?
> > 
> > It's a bit difficult to find 0.125 on the internet...
> 
> The reason that I ask the question(s) is that after I build
> elfutils-0.128 and then do 'make install', I can no longer
> build a kernel, i.e., kernel 'make' has errors, like:
> 
>   CC      init/main.o
>   CC      init/do_mounts.o
>   CC      init/do_mounts_rd.o
>   AS      usr/initramfs_data.o
>   LD      usr/built-in.o
> ld: cannot load ld backend library 'libld_elf_x86_64.so': libld_elf_x86_64.so: cannot open shared object file: No such
 file or directory
> make[1]: *** [usr/built-in.o] Error 1
> make: *** [usr] Error 2
> make: *** Waiting for unfinished jobs....
>   CC      init/do_mounts_initrd.o
>   CC      init/initramfs.o
>   CC      init/calibrate.o
>   CC      init/version.o
>   LD      init/mounts.o
> ld: cannot load ld backend library 'libld_elf_x86_64.so': libld_elf_x86_64.so: cannot open shared object file: No such
 file or directory
> make[1]: *** [init/mounts.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [init] Error 2
> 
> 
> on x86_64.
> 
> 
> > >  * BUILD & INSTALL
> > >    1.Get the latest makedumpfile from the following site:
> > >      https://sourceforge.net/projects/makedumpfile/
> 
> 
> ---
> ~Randy
> *** Remember to use Documentation/SubmitChecklist when testing your code ***
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
