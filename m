Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1OEXHm-0002kQ-37
	for kexec@lists.infradead.org; Wed, 19 May 2010 00:37:23 +0000
Date: Wed, 19 May 2010 09:37:16 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] kexec-tools: Fix option/argument parsing
Message-ID: <20100519003716.GE8536@verge.net.au>
References: <4BECCE4D.2030905@ozlabs.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4BECCE4D.2030905@ozlabs.org>
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
To: Matt Evans <matt@ozlabs.org>
Cc: Michael Neuling <mikey@neuling.org>, kexec@lists.infradead.org

On Fri, May 14, 2010 at 02:15:09PM +1000, Matt Evans wrote:
> Hi,
> 
> v2 changes:
> - Fixed ARM's multiline KEXEC_ALL_OPTIONS #define
> - Removed opterr=0 from main()'s getopts_long() scan, and handle 
>   unknown options in main() (as it now knows about all allowed opts).  
>   Previously it relied on the file_type->load()er parsing & complaining
>   about unknown options; if the loader didn't parse them, no complaint.
> 
> Tested on x86, ppc and compile-tested on my new crisv32-axis-linux-gnu
> crosscompiler :-)
> 
> 
> Cheers,
> 
> 
> Matt
> 
> 
> ---
> The argument parsing is currently a bit broken as main()'s getopt_long()
> knows nothing about either the architecture-specific options or, even
> more specifically, the architecture-and-loader-specific options.
> 
> This patch introduces new #defines for all architectures,
> KEXEC_ALL_OPTIONS and KEXEC_ALL_OPT_STR.  These contain all possible
> options for a given build, and the getopt_long() passes in main() and
> arch_process_options() will now recognise arch- and loader-specific
> options; these will not be re-ordered in argv[], there is no confusion
> over which argv[] entry is the kernel filename, and using '--opt=foo' and
> '--opt foo' both work.
> 
> All architectures have command line options (and #define OPT_BLAHs)
> consolidated into their include/arch/option.h files.  x86_64 builds
> parts of i386/ as well, so now both share a single option.h file (with
> a symlink).
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---

[snip]

> diff --git a/kexec/arch/sh/include/arch/options.h b/kexec/arch/sh/include/arch/options.h
> index e02960d..4bdd6a3 100644
> --- a/kexec/arch/sh/include/arch/options.h
> +++ b/kexec/arch/sh/include/arch/options.h
> @@ -7,16 +7,36 @@
>  #define OPT_NBSD_HOWTO   (OPT_ARCH_MAX+3)
>  #define OPT_NBSD_MROOT   (OPT_ARCH_MAX+4)
>  
> -
> +/* Options relevant to the architecture (excluding loader-specific ones): */
>  #define KEXEC_ARCH_OPTIONS \
>  	KEXEC_OPTIONS \
>          {"command-line",   1, 0, OPT_APPEND}, \
>          {"append",         1, 0, OPT_APPEND}, \
>          {"empty-zero",     1, 0, OPT_APPEND}, \
>          {"howto",          1, 0, OPT_NBSD_HOWTO}, \
> -        {"miniroot",       1, 0, OPT_NBSD_MROOT}, \
> -
> +        {"miniroot",       1, 0, OPT_NBSD_MROOT},
> +/* These options seem to be loader-specific rather than cris-specific, so
> + * ought to be moved to KEXEC_ALL_OPTIONS below and parsed in the relevant 

The line above has a trailing space.

> + * loader, e.g. kexec-netbsd-sh.c
> + */
>  
>  #define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR ""
>  
> +/* The following two #defines list ALL of the options added by all of the
> + * architecture's loaders.
> + * o	main() uses this complete list to scan for its options, ignoring
> + *	arch-specific/loader-specific ones.
> + * o	Then, arch_process_options() uses this complete list to scan for its
> + *	options, ignoring general/loader-specific ones.
> + * o	Then, the file_type[n].load re-scans for options, using
> + *	KEXEC_ARCH_OPTIONS plus its loader-specific options subset.
> + *	Any unrecognised options cause an error here.
> + *
> + * This is done so that main()'s/arch_process_options()'s getopt_long() calls
> + * don't choose a kernel filename from random arguments to options they don't
> + * recognise -- as they now recognise (if not act upon) all possible options.
> + */
> +#define KEXEC_ALL_OPTIONS KEXEC_ARCH_OPTIONS
> +#define KEXEC_ALL_OPT_STR KEXEC_ARCH_OPT_STR
> +
>  #endif /* KEXEC_ARCH_SH_OPTIONS_H */

[snip]

> diff --git a/kexec/arch/x86_64/include/arch/options.h b/kexec/arch/x86_64/include/arch/options.h
> deleted file mode 100644
> index 75065b9..0000000
> --- a/kexec/arch/x86_64/include/arch/options.h
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -#ifndef KEXEC_ARCH_X86_64_OPTIONS_H
> -#define KEXEC_ARCH_X86_64_OPTIONS_H
> -
> -#define OPT_RESET_VGA      (OPT_MAX+0)
> -#define OPT_SERIAL         (OPT_MAX+1)
> -#define OPT_SERIAL_BAUD    (OPT_MAX+2)
> -#define OPT_CONSOLE_VGA    (OPT_MAX+3)
> -#define OPT_CONSOLE_SERIAL (OPT_MAX+4)
> -#define OPT_ARCH_MAX       (OPT_MAX+5)
> -
> -#define KEXEC_ARCH_OPTIONS \
> -	KEXEC_OPTIONS \
> -	{ "reset-vga",	    0, 0, OPT_RESET_VGA }, \
> -	{ "serial",	    1, 0, OPT_SERIAL }, \
> -	{ "serial-baud",    1, 0, OPT_SERIAL_BAUD }, \
> -	{ "console-vga",    0, 0, OPT_CONSOLE_VGA }, \
> -	{ "console-serial", 0, 0, OPT_CONSOLE_SERIAL }, \
> -
> -#define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR ""
> -
> -#endif /* KEXEC_ARCH_X86_64_OPTIONS_H */
> -
> diff --git a/kexec/arch/x86_64/include/arch/options.h b/kexec/arch/x86_64/include/arch/options.h
> new file mode 120000
> index 0000000..047b0f9
> --- /dev/null
> +++ b/kexec/arch/x86_64/include/arch/options.h
> @@ -0,0 +1 @@
> +../../../i386/include/arch/options.h
> \ No newline at end of file

The fragment above seems to a) belong in the previous fragment and
b) be bogus. In any case x86_64 fails to build.

kexec/kexec.c: In function 'main':
kexec/kexec.c:1061: error: 'KEXEC_ALL_OPTIONS' undeclared (first use in this function)
...

[snip]

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
