Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn1on0118.outbound.protection.outlook.com
 ([157.56.110.118] helo=na01-bn1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zjfj0-00018p-BU
 for kexec@lists.infradead.org; Wed, 07 Oct 2015 03:49:08 +0000
From: Scott Wood <scottwood@freescale.com>
Subject: [PATCH v2 13/18] powerpc/book3e-64: Don't limit paca to 256 MiB
Date: Tue, 6 Oct 2015 22:48:17 -0500
Message-ID: <1444189702-17241-14-git-send-email-scottwood@freescale.com>
In-Reply-To: <1444189702-17241-1-git-send-email-scottwood@freescale.com>
References: <1444189702-17241-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
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
To: linuxppc-dev@lists.ozlabs.org
Cc: Scott Wood <scottwood@freescale.com>, Tiejun Chen <tiejun.chen@intel.com>, kexec@lists.infradead.org, Michael Ellerman <mpe@ellerman.id.au>

This limit only makes sense on book3s, and on book3e it can cause
problems with kdump if we don't have any memory under 256 MiB.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/paca.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 5a23b69..7fdff63 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -206,12 +206,16 @@ void __init allocate_pacas(void)
 {
 	int cpu, limit;
 
+	limit = ppc64_rma_size;
+
+#ifdef CONFIG_PPC_BOOK3S_64
 	/*
 	 * We can't take SLB misses on the paca, and we want to access them
 	 * in real mode, so allocate them within the RMA and also within
 	 * the first segment.
 	 */
-	limit = min(0x10000000ULL, ppc64_rma_size);
+	limit = min(0x10000000ULL, limit);
+#endif
 
 	paca_size = PAGE_ALIGN(sizeof(struct paca_struct) * nr_cpu_ids);
 
-- 
2.1.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
