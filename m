Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KGNkc-0005Er-6p
	for kexec@lists.infradead.org; Wed, 09 Jul 2008 00:41:42 +0000
Date: Wed, 9 Jul 2008 10:41:39 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/3] Remove redundancy between
	get_memory_ranges_proc_iomem() and get_memory_ranges_sysfs()
Message-ID: <20080709004138.GD13710@verge.net.au>
References: <20080707070621.GD788@verge.net.au>
	<1215441822-13820-3-git-send-email-bwalle@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1215441822-13820-3-git-send-email-bwalle@suse.de>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org

On Mon, Jul 07, 2008 at 04:43:41PM +0200, Bernhard Walle wrote:
> With the previous patch, we have a duplication between that both functions
> for following tasks:
> 
>  - don't report the interrupt table as RAM,
>  - set the mem_min and mem_max limits for kdump.
> 
> This patch removes that redundancy into the function get_memory_ranges()
> that calls both functions internally.

Hi Bernhard,

these patches seem fine to me, but I am still having minor troubles
with missing defines. For the record, I am seeing the problems with
gcc-3.4.5 + glibc-2.3.6. Yes, I know this is old, but it would
be nice if this minor issue didn't break it.

1. The snippet below looks good, but it needs to be included
   in or berfore " [PATCH 1/3] Parse /sys/firmware/memmap".

> diff --git a/kexec/firmware_memmap.c b/kexec/firmware_memmap.c
> index cdac6f3..2ad450d 100644
> --- a/kexec/firmware_memmap.c
> +++ b/kexec/firmware_memmap.c
> @@ -31,6 +31,13 @@
>  #include "firmware_memmap.h"
>  #include "kexec.h"
>  
> +/*
> + * If the system is too old for ULLONG_MAX, define it here.
> + */
> +#ifndef ULLONG_MAX
> +#    define ULLONG_MAX (~0ULL)
> +#endif
> +
>  /**
>   * The full path to the sysfs interface that provides the memory map.
>   */

2. I did not realise this at the time that I sent my previous response,
   but LLONG_MAX is also a problem. I believe that the following
   code, based on your code above, fixes the problem.

/*
 * If the system is too old for LLONG_MAX, define it here.
 */
#ifndef LLONG_MAX
#define LLONG_MAX     (~0ULL >> 1)
#endif

I have verified on i386 using gcc-3.4.5 + glibc-2.3.6 and gcc-4.3.1 +
glibc-2.7 that this value is 9223372036854775807 (=2^63-1), which is
what the latter provides as LLONG_MAX.

Just for good measure, I have also verified, using the same method, that
your code gives 18446744073709551615 (=2^64-1), which matches the value
internally provided by gcc-4.3.1 + glibc-2.7.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
