Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KNqYQ-0006ms-Ch
	for kexec@lists.infradead.org; Tue, 29 Jul 2008 14:51:59 +0000
Date: Tue, 29 Jul 2008 10:51:56 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch 1/3] kdump: use is_kdump_kernel() in sba_init()
Message-ID: <20080729145156.GO25975@redhat.com>
References: <20080729081235.293361145@vergenet.net>
	<20080729081629.356523305@vergenet.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080729081629.356523305@vergenet.net>
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
To: Simon Horman <horms@verge.net.au>
Cc: linux-ia64@vger.kernel.org, kexec@lists.infradead.org, lkml@vger.kernel.org

On Tue, Jul 29, 2008 at 06:12:36PM +1000, Simon Horman wrote:
> After recent patches* is_kdump_kernel() should return 1 in the
> case where code is executing in a crashkernel and 0 otherwise.
> It is save to use outside of CONFIG_KDUMP.
> 
> * http://lkml.org/lkml/2008/7/28/445
> 

Hi Simon,

is_kdump_kernel() returns 1 when both the following conditions are true.

- CONFIG_CRASH_DUMP is enabled
- And kernel is booting after a panic.

If any of the above condition is not true, it returns 0.

So for the cases where, CONFIG_CRASH_DUMP=n and kernel is booting after
panic, is_kdump_kernel() will still return 0.

This essentially means that any kernel which is booting after a panic,
but does not have CONFIG_CRASH_DUMP enabled, will not take special actions
required for booting that kernel. Until, somebody can come up with another
usage of booting a kernel after a panic (apart from crash dump), I think
this is good enough an assumption.

So your changes will work. I just wanted to clarify the semantics more
explicitly.

> Signed-off-by: Simon Horman <horms@verge.net.au>
> 
> 
> Index: linux-2.6/arch/ia64/hp/common/sba_iommu.c
> ===================================================================
> --- linux-2.6.orig/arch/ia64/hp/common/sba_iommu.c	2008-07-29 10:57:17.000000000 +1000
> +++ linux-2.6/arch/ia64/hp/common/sba_iommu.c	2008-07-29 10:57:51.000000000 +1000
> @@ -2070,14 +2070,13 @@ sba_init(void)
>  	if (!ia64_platform_is("hpzx1") && !ia64_platform_is("hpzx1_swiotlb"))
>  		return 0;
>  
> -#if defined(CONFIG_IA64_GENERIC) && defined(CONFIG_CRASH_DUMP) && \
> -        defined(CONFIG_PROC_FS)
> +#if defined(CONFIG_IA64_GENERIC)


Acked-by: Vivek Goyal <vgoyal@redhat.com>

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
