Return-path: <kexec-bounces@lists.infradead.org>
Received: from gateway-1237.mvista.com ([63.81.120.158])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Ij328-0007NQ-HI
	for kexec@lists.infradead.org; Sat, 20 Oct 2007 02:21:46 +0100
Message-ID: <47195807.6030809@ct.jp.nec.com>
Date: Fri, 19 Oct 2007 18:21:11 -0700
From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] x86: add lapic_shutdown for x86_64
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
 arch/x86/kernel/apic_64.c |   14 ++++++++++++++
 include/asm-x86/apic_64.h |    1 +
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/apic_64.c b/arch/x86/kernel/apic_64.c
index f47bc49..f28ccb5 100644
--- a/arch/x86/kernel/apic_64.c
+++ b/arch/x86/kernel/apic_64.c
@@ -287,6 +287,20 @@ void disable_local_APIC(void)
 	apic_write(APIC_SPIV, value);
 }
 
+void lapic_shutdown(void)
+{
+	unsigned long flags;
+
+	if (!cpu_has_apic)
+		return;
+
+	local_irq_save(flags);
+
+	disable_local_APIC();
+
+	local_irq_restore(flags);
+}
+
 /*
  * This is to verify that we're looking at a real local APIC.
  * Check these against your board if the CPUs aren't getting
diff --git a/include/asm-x86/apic_64.h b/include/asm-x86/apic_64.h
index 3c8f21e..2747a11 100644
--- a/include/asm-x86/apic_64.h
+++ b/include/asm-x86/apic_64.h
@@ -69,6 +69,7 @@ extern void clear_local_APIC (void);
 extern void connect_bsp_APIC (void);
 extern void disconnect_bsp_APIC (int virt_wire_setup);
 extern void disable_local_APIC (void);
+extern void lapic_shutdown (void);
 extern int verify_local_APIC (void);
 extern void cache_APIC_registers (void);
 extern void sync_Arb_IDs (void);
-- 
1.5.2.3

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
