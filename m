Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdtDL-0004EN-8V
 for kexec@lists.infradead.org; Mon, 31 Dec 2018 08:46:25 +0000
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBV8iHNP012762
 for <kexec@lists.infradead.org>; Mon, 31 Dec 2018 03:46:22 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2pqdpnmcgq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 31 Dec 2018 03:46:22 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <rppt@linux.ibm.com>;
 Mon, 31 Dec 2018 08:46:20 -0000
Date: Mon, 31 Dec 2018 10:46:09 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCHv3 2/2] x86/kdump: bugfix, make the behavior of
 crashkernel=X consistent with kaslr
References: <1545966002-3075-1-git-send-email-kernelfans@gmail.com>
 <1545966002-3075-3-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545966002-3075-3-git-send-email-kernelfans@gmail.com>
Message-Id: <20181231084608.GB28478@rapoport-lnx>
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
To: Pingfan Liu <kernelfans@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stefan Agner <stefan@agner.ch>, Tang Chen <tangchen@cn.fujitsu.com>, linux-mm@kvack.org, Yaowei Bai <baiyaowei@cmss.chinamobile.com>, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Pavel Tatashin <pasha.tatashin@oracle.com>, linux-acpi@vger.kernel.org, Dave Young <dyoung@redhat.com>, Daniel Vacek <neelx@redhat.com>, vgoyal@redhat.com, Len Brown <lenb@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, yinghai@kernel.org, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Mathieu Malaterre <malat@debian.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Fri, Dec 28, 2018 at 11:00:02AM +0800, Pingfan Liu wrote:
> Customer reported a bug on a high end server with many pcie devices, where
> kernel bootup with crashkernel=384M, and kaslr is enabled. Even
> though we still see much memory under 896 MB, the finding still failed
> intermittently. Because currently we can only find region under 896 MB,
> if w/0 ',high' specified. Then KASLR breaks 896 MB into several parts
> randomly, and crashkernel reservation need be aligned to 128 MB, that's
> why failure is found. It raises confusion to the end user that sometimes
> crashkernel=X works while sometimes fails.
> If want to make it succeed, customer can change kernel option to
> "crashkernel=384M, high". Just this give "crashkernel=xx@yy" a very
> limited space to behave even though its grammer looks more generic.
> And we can't answer questions raised from customer that confidently:
> 1) why it doesn't succeed to reserve 896 MB;
> 2) what's wrong with memory region under 4G;
> 3) why I have to add ',high', I only require 384 MB, not 3840 MB.
> 
> This patch simplifies the method suggested in the mail [1]. It just goes
> bottom-up to find a candidate region for crashkernel. The bottom-up may be
> better compatible with the old reservation style, i.e. still want to get
> memory region from 896 MB firstly, then [896 MB, 4G], finally above 4G.
> 
> There is one trivial thing about the compatibility with old kexec-tools:
> if the reserved region is above 896M, then old tool will fail to load
> bzImage. But without this patch, the old tool also fail since there is no
> memory below 896M can be reserved for crashkernel.
> 
> [1]: http://lists.infradead.org/pipermail/kexec/2017-October/019571.html
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Tang Chen <tangchen@cn.fujitsu.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Cc: Daniel Vacek <neelx@redhat.com>
> Cc: Mathieu Malaterre <malat@debian.org>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: yinghai@kernel.org,
> Cc: vgoyal@redhat.com
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/x86/kernel/setup.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index d494b9b..165f9c3 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -541,15 +541,18 @@ static void __init reserve_crashkernel(void)
> 
>  	/* 0 means: find the address automatically */
>  	if (crash_base <= 0) {
> +		bool bottom_up = memblock_bottom_up();
> +
> +		memblock_set_bottom_up(true);
>
>  		/*
>  		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
>  		 * as old kexec-tools loads bzImage below that, unless
>  		 * "crashkernel=size[KMG],high" is specified.
>  		 */
>  		crash_base = memblock_find_in_range(CRASH_ALIGN,
> -						    high ? CRASH_ADDR_HIGH_MAX
> -							 : CRASH_ADDR_LOW_MAX,
> -						    crash_size, CRASH_ALIGN);
> +			(max_pfn * PAGE_SIZE), crash_size, CRASH_ALIGN);
> +		memblock_set_bottom_up(bottom_up);

Using bottom-up does not guarantee that the allocation won't fall into a
removable memory, it only makes it highly probable.

I think that the 'max_pfn * PAGE_SIZE' limit should be replaced with the
end of the non-removable memory node.

> +
>  		if (!crash_base) {
>  			pr_info("crashkernel reservation failed - No suitable area found.\n");
>  			return;
> -- 
> 2.7.4
> 

-- 
Sincerely yours,
Mike.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
