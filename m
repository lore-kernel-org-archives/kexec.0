Return-path: <kexec-bounces@lists.infradead.org>
Received: from gateway-1237.mvista.com ([63.81.120.158])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Ij33w-0007PB-I7
	for kexec@lists.infradead.org; Sat, 20 Oct 2007 02:23:38 +0100
Message-ID: <47195876.7080208@ct.jp.nec.com>
Date: Fri, 19 Oct 2007 18:23:02 -0700
From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
MIME-Version: 1.0
Subject: [PATCH 2/3] x86: add safe_smp_processor_id for x86_64
References: <47195763.1090803@ct.jp.nec.com>
In-Reply-To: <47195763.1090803@ct.jp.nec.com>
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
Errors-To: kexec-bounces@lists.infradead.org
To: vgoyal@in.ibm.com, hbabu@us.ibm.com, tglx@linutronix.de
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>

Signed-off-by: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
---
 include/asm-x86/smp_64.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/asm-x86/smp_64.h b/include/asm-x86/smp_64.h
index 6f0e027..ab612b0 100644
--- a/include/asm-x86/smp_64.h
+++ b/include/asm-x86/smp_64.h
@@ -76,6 +76,8 @@ extern unsigned __cpuinitdata disabled_cpus;
 
 #endif /* CONFIG_SMP */
 
+#define safe_smp_processor_id()		smp_processor_id()
+
 static inline int hard_smp_processor_id(void)
 {
 	/* we don't want to mark this access volatile - bad code generation */
-- 
1.5.2.3

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
