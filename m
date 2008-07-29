Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KNkOz-0005hs-1J
	for kexec@lists.infradead.org; Tue, 29 Jul 2008 08:17:50 +0000
Message-Id: <20080729081629.715923799@vergenet.net>
References: <20080729081235.293361145@vergenet.net>
Date: Tue, 29 Jul 2008 18:12:38 +1000
From: Simon Horman <horms@verge.net.au>
Subject: [patch 3/3] kdump: use is_vmcore_usable() and vmcore_unusable() in
	reserve_elfcorehdr()
Content-Disposition: inline; filename=use-is_vmcore_usable.patch
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, linux-ia64@vger.kernel.org, lkml@vger.kernel.org
Cc: Vivek Goyal <vgoyal@redhat.com>

After recent changes setting elfcorehdr_addr to ELFCORE_ADDR_MAX
will cause is_kdump_kernel() to return 0 when it should return 1.
Instead use vmcore_unusable(), which has been added for this purpose.

Signed-off-by: Simon Horman <horms@verge.net.au>

Index: linux-2.6/arch/ia64/kernel/setup.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/setup.c	2008-07-29 17:27:43.000000000 +1000
+++ linux-2.6/arch/ia64/kernel/setup.c	2008-07-29 17:50:50.000000000 +1000
@@ -502,11 +502,11 @@ int __init reserve_elfcorehdr(unsigned l
 	 * to work properly.
 	 */
 
-	if (elfcorehdr_addr >= ELFCORE_ADDR_MAX)
+	if (!is_vmcore_usable())
 		return -EINVAL;
 
 	if ((length = vmcore_find_descriptor_size(elfcorehdr_addr)) == 0) {
-		elfcorehdr_addr = ELFCORE_ADDR_MAX;
+		vmcore_unusable();
 		return -EINVAL;
 	}
 

-- 

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
