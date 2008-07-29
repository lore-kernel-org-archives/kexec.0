Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KNyPQ-0005eM-8X
	for kexec@lists.infradead.org; Tue, 29 Jul 2008 23:15:12 +0000
Date: Wed, 30 Jul 2008 09:15:10 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [patch 1/3] kdump: use is_kdump_kernel() in sba_init()
Message-ID: <20080729231507.GF6370@verge.net.au>
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
To: kexec@lists.infradead.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Vivek Goyal <vgoyal@redhat.com>

After recent patches* is_kdump_kernel() should return 1 in the
case where code is executing in a crashkernel and 0 otherwise.
It is safe to use outside of CONFIG_CRASH_DUMP.

* http://lkml.org/lkml/2008/7/28/445

Signed-off-by: Simon Horman <horms@verge.net.au>
Acked-by: Vivek Goyal <vgoyal@redhat.com>

Index: linux-2.6/arch/ia64/hp/common/sba_iommu.c
===================================================================
--- linux-2.6.orig/arch/ia64/hp/common/sba_iommu.c	2008-07-29 10:57:17.000000000 +1000
+++ linux-2.6/arch/ia64/hp/common/sba_iommu.c	2008-07-29 10:57:51.000000000 +1000
@@ -2070,14 +2070,13 @@ sba_init(void)
 	if (!ia64_platform_is("hpzx1") && !ia64_platform_is("hpzx1_swiotlb"))
 		return 0;
 
-#if defined(CONFIG_IA64_GENERIC) && defined(CONFIG_CRASH_DUMP) && \
-        defined(CONFIG_PROC_FS)
+#if defined(CONFIG_IA64_GENERIC)
 	/* If we are booting a kdump kernel, the sba_iommu will
 	 * cause devices that were not shutdown properly to MCA
 	 * as soon as they are turned back on.  Our only option for
 	 * a successful kdump kernel boot is to use the swiotlb.
 	 */
-	if (elfcorehdr_addr < ELFCORE_ADDR_MAX) {
+	if (is_kdump_kernel()) {
 		if (swiotlb_late_init_with_default_size(64 * (1<<20)) != 0)
 			panic("Unable to initialize software I/O TLB:"
 				  " Try machvec=dig boot option");

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
