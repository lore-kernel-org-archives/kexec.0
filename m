Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1OCh20-0001wN-Q9
	for kexec@lists.infradead.org; Thu, 13 May 2010 22:37:30 +0000
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [RFC PATCH] kexec-tools: Fix option/argument parsing
In-reply-to: <20100513144549.GB10534@verge.net.au>
References: <4BEBB4E8.6080000@ozlabs.org> <20100513144549.GB10534@verge.net.au>
Date: Fri, 14 May 2010 08:37:23 +1000
Message-ID: <5224.1273790243@neuling.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Matt Evans <matt@ozlabs.org>



In message <20100513144549.GB10534@verge.net.au> you wrote:
> On Thu, May 13, 2010 at 06:14:32PM +1000, Matt Evans wrote:
> > Hi,
> > 
> > 
> > In playing with kexec-tools I've noticed various problems with the argument
> > passing, meaning one has to be careful to use certain forms of arguments
> > and present them in a certain order.
> > 
> > The arguments end up being parsed three times, each getting more specific
> > than the last.  main() looks for general args, arch_process_options() looks
> > for options common to all loaders for the arch, and then finally many 
> > file_type load() methods check for options specific to that filetype.
> > 
> > As GNU getopt works, it re-orders the argv[] pushing any args it doesn't
> > recognise to the end.  This includes arguments to valid options which
> > are simply not recognised the first time around.
> > 
> > For example, this does not work:
> >   # ./kexec -l --append "init=/bin/foo" /boot/vmlinux
> >   Cannot open `init=/bin/foo': No such file or directory
> > 
> > but this does:
> >   # ./kexec -l --append="init=/bin/foo" /boot/vmlinux
> >   <joy>
> > 
> > Using the --opt<space>arg variant results in the first non-option argument
> > in main() being "init=/bin/foo" which is then used as the kernel filename,
> > failing.  Also, the order affects things in unintuitive ways:
> > 
> >   # ./kexec -l /boot/vmlinux --append "init=/bin/foo" 
> > <appears to load correctly, but command line appended with "/boot/vmlinux"!
>
> > 
> > This behaviour is avoided by using the --opt= forms, but getopt does allow
> > both and hence the user can have a fairly frustrating experience.  (Doing
> > something unexpected (ex. 3) is more annoying than an error exit (ex. 1)
> > in many cases.)
> > 
> > The fix presented here is to create a new #define to encapsulate all possib
le
> > options for an architecture build.  The intention is that this set includes
> > all possible loaders' all possible options.  
> > 
> > main() walks through the options and silently ignores any non-general
> > options (BUT respects that "--arg foo" should remain together, as 
> > getopt_long() does now recognise it).  arch_process_options() walks through
> > them again and responds to any arch-specific options, again ignoring but 
> > respecting any non-arch options.  Finally the loader may look for its
> > options, and find them in-order and present.  Any outside of this combined
> > set are complained-about as usual.
> > 
> > So, comments please.  Is this a reasonable way to do it or is there an
> > obvious better way I've missed? :-)  So far I have been able to test on
> > x86(32,64) and ppc(32,64) but none of the others. :(
> 
> This seems reasonable to me.
> 
> I've compiled tested the code on all architectures except cris (I don't
> have my build environment at the moment). I found a minor problem on arm
> which I have noted below.

I suspect it'll break someones kexec scripts, so maybe we take this
patch (or something like it) but bump up the release revision to 2.1?

Mikey

> 
> [snip]
> 
> > diff --git a/kexec/arch/arm/include/arch/options.h b/kexec/arch/arm/include
/arch/options.h
> > index 248230b..a76539e 100644
> > --- a/kexec/arch/arm/include/arch/options.h
> > +++ b/kexec/arch/arm/include/arch/options.h
> > @@ -3,9 +3,38 @@
> >  
> >  #define OPT_ARCH_MAX   (OPT_MAX+0)
> >  
> > +#define OPT_APPEND	'a'
> > +#define OPT_RAMDISK	'r'
> > +
> > +/* Options relevant to the architecture (excluding loader-specific ones),
> > + * in this case none:
> > + */
> >  #define KEXEC_ARCH_OPTIONS \
> >  	KEXEC_OPTIONS \
> >  
> >  #define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR ""
> >  
> > +/* The following two #defines list ALL of the options added by all of the
> > + * architecture's loaders.
> > + * o	main() uses this complete list to scan for its options, ignorin
g
> > + *	arch-specific/loader-specific ones.
> > + * o	Then, arch_process_options() uses this complete list to scan fo
r its
> > + *	options, ignoring general/loader-specific ones.
> > + * o	Then, the file_type[n].load re-scans for options, using
> > + *	KEXEC_ARCH_OPTIONS plus its loader-specific options subset.
> > + *	Any unrecognised options cause an error here.
> > + *
> > + * This is done so that main()'s/arch_process_options()'s getopt_long() ca
lls
> > + * don't choose a kernel filename from random arguments to options they do
n't
> > + * recognise -- as they now recognise (if not act upon) all possible optio
ns.
> > + */
> > +#define KEXEC_ALL_OPTIONS \
> > +	KEXEC_ARCH_OPTIONS
> > +	{ "command-line",	1, 0, OPT_APPEND },
> > +	{ "append",		1, 0, OPT_APPEND },
> > +	{ "initrd",		1, 0, OPT_RAMDISK },
> 
> The above 4 lines seem to be missing a trailing '\'
> 
> > +	{ "ramdisk",		1, 0, OPT_RAMDISK },
> > +
> > +#define KEXEC_ALL_OPT_STR KEXEC_ARCH_OPT_STR "a:r:"
> > +
> >  #endif /* KEXEC_ARCH_ARM_OPTIONS_H */
> 
> [snip]
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
