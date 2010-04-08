Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1O00HN-0002qe-FX
	for kexec@lists.infradead.org; Thu, 08 Apr 2010 22:32:55 +0000
Date: Fri, 9 Apr 2010 08:32:48 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: fix 64Gb limit on x86 w/ PAE
Message-ID: <20100408223245.GA4795@verge.net.au>
References: <20100408164644.GB16868@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100408164644.GB16868@hmsreliant.think-freely.org>
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
To: Neil Horman <nhorman@tuxdriver.com>
Cc: anderson@redhat.com, kexec@lists.infradead.org, vgoyal@redhat.com

On Thu, Apr 08, 2010 at 12:46:44PM -0400, Neil Horman wrote:
> Fix up x86 kexec to exclude memory on i686 kernels beyond 64GB limit
> 
> We found a problem recently on x86 systems.  If a 32 bit PAE enabled system
> contains more then 64GB of physical ram, the kernel will truncate the max_pfn
> value to 64GB.  Unfortunately it still leaves all the physical memory regions
> present in /proc/iomem.  Since kexec builds its elf headers based on
> /proc/iomem the elf headers indicate the size of memory is larger than what the
> kernel is willing to address.  The result is that, during a copy of
> /proc/vmcore, a read will return -EFAULT when the requested offset is beyond the
> 64GB range, leaving the seemingly truncated vmcore useless, as the elf headers
> indicate memory beyond what the file contains.
> 
> The fix for it is pretty straightforward, just ensure that, when on x86 systems,
> we don't record any entries in the memory_range array that cross  the 64Gb mark.
> This keeps us in line with the kernel and lets the copy finish sucessfully,
> providing a workable core

Hi Neil,

This seems reasonable to me.

> Tested successfully by myself
> Originally-authored-by: Dave Anderson <anderson@redhat.com>
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> 
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index 9d37442..85879a9 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -114,6 +114,15 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
>  		if (end <= 0x0009ffff)
>  			continue;
>  
> +		/*
> +		 *  Exclude any segments starting at or beyond 64GB, and
> +		 *  restrict any segments from ending at or beyond 64GB.
> +		 */
> +		if (start >= 0x1000000000)
> +			continue;
> +		if (end >= 0x1000000000)
> +			end = 0xfffffffff;
> +

Nit picking...

Might it be better to use 0xfffffffff (or 0x1000000000) consistently?

		if (start > 0xfffffffff)
			continue;
		if (end > 0xfffffffff)
			end = 0xfffffffff;

Or even make 0xfffffffff (or 0x1000000000) a #define ?

>  		crash_memory_range[memory_ranges].start = start;
>  		crash_memory_range[memory_ranges].end = end;
>  		crash_memory_range[memory_ranges].type = type;
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
