Return-path: <kexec-bounces@lists.infradead.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Ii6lx-0007wT-Lj
	for kexec@lists.infradead.org; Wed, 17 Oct 2007 12:09:14 +0100
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9HB7Qr7002170
	for <kexec@lists.infradead.org>; Wed, 17 Oct 2007 07:07:26 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9HB5tcC569302
	for <kexec@lists.infradead.org>; Wed, 17 Oct 2007 07:05:55 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9HB5ivq005196
	for <kexec@lists.infradead.org>; Wed, 17 Oct 2007 07:05:45 -0400
Date: Wed, 17 Oct 2007 16:35:51 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [patch 2/3] Introduce BOOTMEM_EXCLUSIVE
Message-ID: <20071017110550.GB17565@in.ibm.com>
References: <20071016162857.635479952@strauss.suse.de>
	<20071016162858.545617122@strauss.suse.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071016162858.545617122@strauss.suse.de>
Reply-To: vgoyal@in.ibm.com
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
Errors-To: kexec-bounces@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ak@suse.de


[..]
> +/*
> + * If flags is 0, then the return value is always 0 (success). If
> + * flags contains BOOTMEM_EXCLUSIVE, then -EBUSY is returned if the
> + * memory already was reserved.
> + */
> +extern int reserve_bootmem(unsigned long addr, unsigned long size, int flags);
>  #define alloc_bootmem(x) \
>  	__alloc_bootmem(x, SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
>  #define alloc_bootmem_low(x) \
> --- a/mm/bootmem.c
> +++ b/mm/bootmem.c
> @@ -111,8 +111,8 @@ static unsigned long __init init_bootmem
>   * might be used for boot-time allocations - or it might get added
>   * to the free page pool later on.
>   */
> -static void __init reserve_bootmem_core(bootmem_data_t *bdata, unsigned long addr,
> -					unsigned long size)
> +static int __init reserve_bootmem_core(bootmem_data_t *bdata, unsigned long addr,
> +					unsigned long size, int flags)
>  {
>  	unsigned long sidx, eidx;
>  	unsigned long i;
> @@ -133,7 +133,11 @@ static void __init reserve_bootmem_core(
>  #ifdef CONFIG_DEBUG_BOOTMEM
>  			printk("hm, page %08lx reserved twice.\n", i*PAGE_SIZE);
>  #endif
> +			if (flags & BOOTMEM_EXCLUSIVE)
> +				return -EBUSY;

I think we should unreserve the chunks of memory we have reserved so
far (Memory reserved from sidx to i), in case of error.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
