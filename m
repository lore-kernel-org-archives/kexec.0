Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10] helo=mail.zytor.com)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1P3G24-0001di-07
	for kexec@lists.infradead.org; Tue, 05 Oct 2010 22:30:48 +0000
Message-ID: <4CABA6E5.6030601@zytor.com>
Date: Tue, 05 Oct 2010 15:29:57 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/4] x86, memblock: Fix crashkernel allocation
References: <4CAA4BD5.4020505@kernel.org> <4CAA4DE2.1020406@kernel.org>
In-Reply-To: <4CAA4DE2.1020406@kernel.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Vivek Goyal <vgoyal@redhat.com>

On 10/04/2010 02:57 PM, Yinghai Lu wrote:
>
> +#define DEFAULT_BZIMAGE_ADDR_MAX 0x37FFFFFF
>  static void __init reserve_crashkernel(void)
>  {
>  	unsigned long long total_mem;
> @@ -518,17 +519,28 @@ static void __init reserve_crashkernel(v
>  	if (crash_base <= 0) {
>  		const unsigned long long alignment = 16<<20;	/* 16M */
>  
> -		crash_base = memblock_find_in_range(alignment, ULONG_MAX, crash_size,
> -				 alignment);
> +		/*
> +		 * Assume half crash_size is for bzImage
> +		 *  kexec want bzImage is below DEFAULT_BZIMAGE_ADDR_MAX
> +		 */
> +		crash_base = memblock_find_in_range(alignment,
> +				DEFAULT_BZIMAGE_ADDR_MAX + crash_size/2,
> +				crash_size, alignment);
> +
>  		if (crash_base == MEMBLOCK_ERROR) {
> -			pr_info("crashkernel reservation failed - No suitable area found.\n");
> -			return;
> +			crash_base = memblock_find_in_range(alignment,
> +					 ULONG_MAX, crash_size, alignment);
> +
> +			if (crash_base == MEMBLOCK_ERROR) {
> +				pr_info("crashkernel reservation failed - No suitable area found.\n");
> +				return;
> +			}
>  		}
>  

Okay, this *really* doesn't make sense.

It's bad enough that kexec doesn't know what memory is safe for it, but
why the heck the heuristic that "half is for bzImage and the rest can go
beyond the heuristic limit"?  Can't we at least simply cap the region to
the default, unless the kexec system has passed in some knowable
alternative?  Furthermore, why bother having the "fallback" at all
(certainly without having a message!?)  If we don't get the memory area
we need we're likely to randomly fail anyway.

Let me be completely clear -- it's obvious from all of this that kexec
is fundamentally broken by design: if kexec can't communicate the safe
memory to use it's busted seven ways to Sunday and it needs to be fixed.
 However, in the meantime I can see capping the memory available to it
as a temporary band-aid, but a fallback to picking random memory is
nuts, especially on the motivation that "a future kexec version might be
able to use it."  If so, the "future kexec tools" should SAY SO.

This is beyond crazy -- it's complete and total bonkers.

	-hpa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
