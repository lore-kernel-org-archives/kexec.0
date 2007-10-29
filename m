Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.66 #1 (Red Hat Linux))
	id 1ImPiQ-0004tU-ST
	for kexec@lists.infradead.org; Mon, 29 Oct 2007 04:11:26 -0400
Date: Mon, 29 Oct 2007 17:10:29 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH] vmcore_find_descriptor_size should be in __init
Message-ID: <20071029081027.GA30256@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-ia64@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Tony Luck <tony.luck@intel.com>, Eric Biederman <ebiederm@xmission.com>

vmcore_find_descriptor_size() is only called by
reserve_elfcorehdr(), which is in __init, so it seems to me that
vmcore_find_descriptor_size() should be there too.

Signed-off-by: Simon Horman <horms@verge.net.au>

Index: linux-2.6/arch/ia64/kernel/efi.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/efi.c	2007-03-06 16:43:11.000000000 +0900
+++ linux-2.6/arch/ia64/kernel/efi.c	2007-03-06 16:43:25.000000000 +0900
@@ -1180,7 +1180,7 @@
 
 #ifdef CONFIG_PROC_VMCORE
 /* locate the size find a the descriptor at a certain address */
-unsigned long
+unsigned long __init
 vmcore_find_descriptor_size (unsigned long address)
 {
 	void *efi_map_start, *efi_map_end, *p;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
