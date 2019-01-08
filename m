Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggnGh-0001vm-QM
 for kexec@lists.infradead.org; Tue, 08 Jan 2019 09:01:57 +0000
Date: Tue, 8 Jan 2019 17:01:38 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCHv5] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190108090138.GB18718@MiWiFi-R3L-srv>
References: <1546848299-23628-1-git-send-email-kernelfans@gmail.com>
 <20190108080538.GB4396@rapoport-lnx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190108080538.GB4396@rapoport-lnx>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: Stefan Agner <stefan@agner.ch>, Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Mathieu Malaterre <malat@debian.org>, kexec@lists.infradead.org, Daniel Vacek <neelx@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Tatashin <pasha.tatashin@oracle.com>, Pingfan Liu <kernelfans@gmail.com>, Tang Chen <tangchen@cn.fujitsu.com>, linux-mm@kvack.org, Mike Rapoport <rppt@linux.vnet.ibm.com>, yinghai@kernel.org, Nicholas Piggin <npiggin@gmail.com>, Yaowei Bai <baiyaowei@cmss.chinamobile.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, vgoyal@redhat.com, Len Brown <lenb@kernel.org>

Hi Mike,

On 01/08/19 at 10:05am, Mike Rapoport wrote:
> I'm not thrilled by duplicating this code (yet again).
> I liked the v3 of this patch [1] more, assuming we allow bottom-up mode to
> allocate [0, kernel_start) unconditionally. 
> I'd just replace you first patch in v3 [2] with something like:

In initmem_init(), we will restore the top-down allocation style anyway.
While reserve_crashkernel() is called after initmem_init(), it's not
appropriate to adjust memblock_find_in_range_node(), and we really want
to find region bottom up for crashkernel reservation, no matter where
kernel is loaded, better call __memblock_find_range_bottom_up().

Create a wrapper to do the necessary handling, then call
__memblock_find_range_bottom_up() directly, looks better.

Thanks
Baoquan

> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 7df468c..d1b30b9 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -274,24 +274,14 @@ phys_addr_t __init_memblock memblock_find_in_range_node(phys_addr_t size,
>  	 * try bottom-up allocation only when bottom-up mode
>  	 * is set and @end is above the kernel image.
>  	 */
> -	if (memblock_bottom_up() && end > kernel_end) {
> -		phys_addr_t bottom_up_start;
> -
> -		/* make sure we will allocate above the kernel */
> -		bottom_up_start = max(start, kernel_end);
> -
> +	if (memblock_bottom_up()) {
>  		/* ok, try bottom-up allocation first */
> -		ret = __memblock_find_range_bottom_up(bottom_up_start, end,
> +		ret = __memblock_find_range_bottom_up(start, end,
>  						      size, align, nid, flags);
>  		if (ret)
>  			return ret;
>  
>  		/*
> -		 * we always limit bottom-up allocation above the kernel,
> -		 * but top-down allocation doesn't have the limit, so
> -		 * retrying top-down allocation may succeed when bottom-up
> -		 * allocation failed.
> -		 *
>  		 * bottom-up allocation is expected to be fail very rarely,
>  		 * so we use WARN_ONCE() here to see the stack trace if
>  		 * fail happens.
> 
> [1] https://lore.kernel.org/lkml/1545966002-3075-3-git-send-email-kernelfans@gmail.com/
> [2] https://lore.kernel.org/lkml/1545966002-3075-2-git-send-email-kernelfans@gmail.com/
> 
> > +
> > +	return ret;
> > +}
> > +
> >  /**
> >   * __memblock_find_range_top_down - find free area utility, in top-down
> >   * @start: start of candidate range
> > -- 
> > 2.7.4
> > 
> 
> -- 
> Sincerely yours,
> Mike.
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
