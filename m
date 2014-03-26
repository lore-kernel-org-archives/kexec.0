Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WSkYi-0008OM-0u
 for kexec@lists.infradead.org; Wed, 26 Mar 2014 09:55:45 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id EC9013EE0BB
 for <kexec@lists.infradead.org>; Wed, 26 Mar 2014 18:55:17 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id DC04F45DE55
 for <kexec@lists.infradead.org>; Wed, 26 Mar 2014 18:55:17 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.nic.fujitsu.com [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id A8E8D45DE60
 for <kexec@lists.infradead.org>; Wed, 26 Mar 2014 18:55:17 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 9B684E08004
 for <kexec@lists.infradead.org>; Wed, 26 Mar 2014 18:55:17 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 43EA5E08001
 for <kexec@lists.infradead.org>; Wed, 26 Mar 2014 18:55:17 +0900 (JST)
Date: Wed, 26 Mar 2014 10:55:07 +0100 (a/T)
Message-Id: <20140326.105507.429853525.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH 2/2] makedumpfile: Use max_pfn from mem_map array
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20140325171420.6b558576@holzheu>
References: <20140325171420.6b558576@holzheu>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: holzheu@linux.vnet.ibm.com
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [PATCH 2/2] makedumpfile: Use max_pfn from mem_map array
Date: Tue, 25 Mar 2014 17:14:20 +0100

> There are dump mechansims like s390 stand-alond dump or KVM virsh dump
> that write the physical memory of a machine and are not aware of the
> dumped operating system. For those dump mechanisms it can happen
> that for the Linux kernel of the dumped system the "mem=" kernel
> parameter has been specified. In this case max_mapnr that makedumpfile
> gets from the ELF header can be bigger than the maximum page frame number
> used by the dumped Linux kernel.
> 
> With this patch makedumpfile gets the maximum page frame number from
> the mem_map array and adjusts info->max_mapnr if this value is smaller
> than the value calculated from the ELF header.
> 
> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> ---
>  makedumpfile.c |   14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -2829,7 +2829,8 @@ get_mem_map_without_mm(void)
>  int
>  get_mem_map(void)
>  {
> -	int ret;
> +	unsigned long max_pfn = 0;
> +	int ret, i;

Please define max_pfn as unsigned long long.

And for i,

>  
>  	switch (get_mem_type()) {
>  	case SPARSEMEM:
> @@ -2861,6 +2862,17 @@ get_mem_map(void)
>  		ret = FALSE;
>  		break;
>  	}
> +	/*
> +	 * Adjust "max_mapnr" for the case that Linux uses less memory
> +	 * than is dumped. For example when "mem=" has been used for the
> +	 * dumped system.
> +	 */
> +	for (i = 0; i < info->num_mem_map; i++) {

info->num_mem_map is defined as unsigned int. I guess some warning
about comparison with different signedness occurs.

> +		if (info->mem_map_data[i].mem_map == NOT_MEMMAP_ADDR)
> +			continue;
> +		max_pfn = MAX(max_pfn, info->mem_map_data[i].pfn_end);
> +	}
> +	info->max_mapnr = MIN(info->max_mapnr, max_pfn);
>  	return ret;
>  }
>  
> 

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
