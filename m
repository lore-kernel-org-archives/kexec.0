Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1S0wKM-0002yF-8N
 for kexec@lists.infradead.org; Fri, 24 Feb 2012 14:40:55 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH] kexec: crash: don't save swapper_pg_dir for !CONFIG_MMU
 configurations
Date: Fri, 24 Feb 2012 14:40:47 +0000
Message-Id: <1330094447-11900-1-git-send-email-will.deacon@arm.com>
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
To: kexec@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>

nommu platforms don't have very interesting swapper_pg_dir pointers and
usually just #define them to NULL, meaning that we can't include them in
the vmcoreinfo on the kexec crash path.

This patch only saves the swapper_pg_dir if we have an MMU.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 kernel/kexec.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 7b08867..cb5d13c 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1462,7 +1462,9 @@ static int __init crash_save_vmcoreinfo_init(void)
 
 	VMCOREINFO_SYMBOL(init_uts_ns);
 	VMCOREINFO_SYMBOL(node_online_map);
+#ifdef CONFIG_MMU
 	VMCOREINFO_SYMBOL(swapper_pg_dir);
+#endif
 	VMCOREINFO_SYMBOL(_stext);
 	VMCOREINFO_SYMBOL(vmlist);
 
-- 
1.7.4.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
