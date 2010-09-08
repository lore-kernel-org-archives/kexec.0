Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay2.sgi.com ([192.48.179.30] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OtMKW-0005W9-BU
	for kexec@lists.infradead.org; Wed, 08 Sep 2010 15:12:57 +0000
Subject: [PATCH] x86: copy_oldmem_page using cached addressing
Message-Id: <E1OtMLz-0001yp-Ia@eag09.americas.sgi.com>
From: Cliff Wickman <cpw@sgi.com>
Date: Wed, 08 Sep 2010 10:14:27 -0500
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, mingo@elte.hu
Cc: linux-kernel@vger.kernel.org

From: Cliff Wickman <cpw@sgi.com>

The copy of /proc/vmcore to a user buffer proceeds much faster
if the kernel addresses memory as cached.

With this patch we have seen an increase in transfer rate from less than
15MB/s to 80-460MB/s, depending on size of the transfer.  This makes
a big difference in time needed to save a system dump.

(Does anyone know of a reason why copy_oldmem_page() would need
 to use uncached addresses?)

Diffed against 2.6.36-rc3

Signed-off-by: Cliff Wickman <cpw@sgi.com>
---
 arch/x86/kernel/crash_dump_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linus.current/arch/x86/kernel/crash_dump_64.c
===================================================================
--- linus.current.orig/arch/x86/kernel/crash_dump_64.c
+++ linus.current/arch/x86/kernel/crash_dump_64.c
@@ -34,7 +34,7 @@ ssize_t copy_oldmem_page(unsigned long p
 	if (!csize)
 		return 0;
 
-	vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
+	vaddr = ioremap_cache(pfn << PAGE_SHIFT, PAGE_SIZE);
 	if (!vaddr)
 		return -ENOMEM;
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
