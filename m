Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Rpslw-0004KE-C5
 for kexec@lists.infradead.org; Wed, 25 Jan 2012 02:39:42 +0000
Date: Wed, 25 Jan 2012 11:39:30 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: kexec 2.0.2 MIPS
Message-ID: <20120125023929.GK11038@verge.net.au>
References: <F9C551623D2CBB4C9488801D14F864C607154A@ex-mb1.corp.adtran.com>
 <20110920085133.GE15087@verge.net.au>
 <F9C551623D2CBB4C9488801D14F864C6072473@ex-mb1.corp.adtran.com>
 <20110921112837.GF17108@verge.net.au>
 <F9C551623D2CBB4C9488801D14F864C60E2D98@ex-mb1.corp.adtran.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <F9C551623D2CBB4C9488801D14F864C60E2D98@ex-mb1.corp.adtran.com>
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
To: ANDY KENNEDY <ANDY.KENNEDY@adtran.com>
Cc: Maxim Uvarov <muvarov@gmail.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Matt Evans <matt@ozlabs.org>

Hi,

sorry for the extensive delay in responding to this.
I am now back from Christmas, New Year, holidays and
attending LCA 2012.

On Fri, Dec 16, 2011 at 05:27:31AM +0000, ANDY KENNEDY wrote:
> Simon/All,
> 
> After two months, I'm back working on this again.  After 3 hours
> tonight, I have the final result of what you told me to do.  Looks like,
> based on the comment:
> 
>     - remove kexec/arch/mips/mips-setup-simple.S which prepares cmdline for
>       new kernel, it is better to move this work to kernel code. BTW this code was
>       compilable only on o32 because of t4 is not defined on 64-64 or n32 MIPS ABIs.
> 
> The problem is that my 2.6.36.2 apparently doesn't have whatever Maxim
> is talking about.  Therefore, the newer versions must not be backwards
> compatible.  Perhaps this is okay with you guys.  If so, I'll just make
> sure to include a patch to BuildRoot that clearly states that the v2.0.1
> is the only version that works with *some* versions of MIPS.  If you
> guys were expecting this to be backwards compatible, I'll gladly work
> with you to test whatever you need checked out.  Just let me know.

It is not apparent to me that the kernel code Maxim makes mention of
exists in any released kernel. I think that the best option at this
stage would be to revert that portion of his change.

Maxim, do you have any thoughts on this?

Andy, could you prepare a patch to do that?
At the very least it ought to be useful to you.

> There are build errors that I would like (if it hasn't already) to
> be fixed
> 1) in purgatory/Makefile, Near line 71
> 
> $(PURGATORY): LDFLAGS=$($(ARCH)_PURGATORY_EXTRA_CFLAGS)\
>                         --no-undefined -nostartfiles -nostdlib -nodefaultlibs \
>                         -e purgatory_start -r
> 
> 
> The newer gcc's don't like --no-undefined.  I think a fix is
> -Wl,--no-undefined.

Thanks, there is a fix for that in git and 2.0.3.

> 2) In the newer version of the kexec/arch/mips/Makefile, there is
> a -Werror in the CFLAGS.  This causes the build to fail if using a
> newer version of gcc, as many more warnings are available.

Thanks, there is a fix for that in git and 2.0.3.

Due to some quirks in the kexec build system
-Werror was effecting all architectures.

> Now, here is the result of the bisect:
> 
> root@akennedy_lin:~/src/kexec/kexec-tools# git bisect good
> 6adc05c6e3fdbc8b9f5d915af78ca05d0a09cb17 is the first bad commit
> commit 6adc05c6e3fdbc8b9f5d915af78ca05d0a09cb17
> Author: Maxim Uvarov <muvarov@gmail.com>
> Date:   Wed Mar 3 14:05:53 2010 +0300
> 
>     some kexec MIPS improvements
>     
>     -  using simple   mips* ) in configure.ac to make it compilable on mips2
>        and mips64
>     - remove kexec/arch/mips/mips-setup-simple.S which prepares cmdline for
>       new kernel, it is better to move this work to kernel code. BTW this code was
>       compilable only on o32 because of t4 is not defined on 64-64 or n32 MIPS ABIs.
>     - simple put cmdline as string, kernel code should catch cmdline like this
>     
>     int board_kexec_prepare(struct kimage *image)
>     {
>         int i;
>         char *bootloader = "kexec";
>         board_boot_desc_ptr->argc = 0;
>         for(i=0;i<image->nr_segments;i++)
>         {
>             printk("segment %d
>             if (!strncmp(bootloader, (char*)image->segment[i].buf,
>                     strlen(bootloader)))
>             {
>                 /*
>                  * convert command line string to array
>                  * of parameters (as bootloader does).
>                  */
>                 int argc = 0, offt;
>                 char *str = (char *)image->segment[i].buf;
>                 char *ptr = strchr(str, ' ');
>                 while (ptr && (ARGV_MAX_ARGS > argc)) {
>                     *ptr = '\0';
>                     if (ptr[1] != ' ') {
>                         offt = (int)(ptr - str + 1);
>                         boot_desc_ptr->argv[argc] =
>                             image->segment[i].mem + offt;
>                         argc++;
>                     }
>                     ptr = strchr(ptr + 1, ' ');
>                 }
>                 boot_desc_ptr->argc = argc;
>                 break;
>             }
>         }
>        Keep it as string make code simple and more readable.
>     
>     - add crashdump support
>     - do not redefine syscalls numbers if they defined in system
>       remove fixups for /proc/iomem. If your board provides wrong /proc/iomem please
>       fix kernel, or at least you local version of kexec. No need to support it in
>       main line. At least add option --fake-iomem
>     - some minor fixes
>     
>     Signed-off-by: Maxim Uvarov <muvarov@gmail.com>
>     Signed-off-by: Simon Horman <horms@verge.net.au>
> 
> :100644 100644 a911f8ad03c5321faeba93069924fa79aceeba9c 88d2e0bb2479ecd956d0ec31c571d2472fef7721 M      configure.ac
> :040000 040000 4dcef15024daa7ccc62bd6983e127cb87f036c5d 69204c980286b2e08308d4a10eb2bf2775d9d962 M      kexec
> 
> Andy
> 
> > -----Original Message-----
> > From: ANDY KENNEDY
> > Sent: Thursday, September 29, 2011 1:07 PM
> > To: 'Simon Horman'
> > Cc: kexec@lists.infradead.org; Matt Evans; Maxim Uvarov
> > Subject: RE: kexec 2.0.2 MIPS
> > 
> > > My bad, yes the idea is to check between 2.0.1 and 2.0.2.
> > > I will explain git bisect further down. However, it looking at
> > the
> > > logs
> > > it strikes me that there was only one significant MIPS change
> > > between
> > > 2.0.1 and 2.0.2. So that seems like a likely culprit.
> > >
> > > Could you try the following?
> > >
> > > $ git clone git://github.com/horms/kexec-tools.git
> > > $ cd kexec-tools
> > > $ git checkout 6adc05c6e3fdbc8b9f5d915af78ca05d0a09cb17^
> > 
> > Works.
> > 
> > >
> > > Build and see if it works. If so could you then try?
> > >
> > > $ git checkout 6adc05c6e3fdbc8b9f5d915af78ca05d0a09cb17
> > 
> > Works.
> > 
> > >
> > > Build and see if it works. If it does not then
> > > revision 6adc05c6e3fdbc8b9f5d915af78ca05d0a09cb17 starts to smell
> > > a lot like the cause of the problem you have observed.
> > >
> > >
> > > Git Bisect
> > > ----------
> > >
> > > A git bisection works by doing a binary search over a set of
> > > commits
> > > in order to (hopefully) isolate which commit introduces a
> > > regression.
> > >
> > > To this, the git commands are something along these lines:
> > >
> > > $ git clone git://github.com/horms/kexec-tools.git
> > > $ cd kexec-tools
> > > $ git checkout v2.0.1
> > 
> > root@akennedy_lin:~/src/kexec/kexec-tools# git checkout v2.0.1
> > error: pathspec 'v2.0.1' did not match any file(s) known to git.
> > (yes, I run as root.  Have since 1994, so, please no holy wars.)
> > 
> > >
> > > Build and confirm that it does work
> > >
> > > $ git checkout v2.0.2
> > >
> > > Build and confirm that it does not work.
> > >
> > > Now we actually start the bisect
> > >
> > > $ git bisect start
> > > $ git bisect bad v2.0.2
> > > $ git bisect good v2.0.1
> > >
> > > Git should now select a revision between v2.0.1 and v2.0.2
> > > Test it and see if it works or not. If it does run
> > >
> > > $ git bisect good
> > > If not run
> > >
> > > $ git bisect bad
> > >
> > > Git will now select another revision for you to test...
> > 
> > I have some time right now to test, so, when you can get
> > back to me I'll be able to continue.
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
