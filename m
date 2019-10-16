Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iKpTl-0004RF-8c
 for kexec@lists.infradead.org; Wed, 16 Oct 2019 20:01:07 +0000
Received: by mail-qt1-x843.google.com with SMTP id r5so38047987qtd.0
 for <kexec@lists.infradead.org>; Wed, 16 Oct 2019 13:01:05 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v7 17/25] arm64: kexec: cpu_soft_restart change argument types
Date: Wed, 16 Oct 2019 16:00:26 -0400
Message-Id: <20191016200034.1342308-18-pasha.tatashin@soleen.com>
In-Reply-To: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
References: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
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
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com, james.morse@arm.com, vladimir.murzin@arm.com, matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org, mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de

Change argument types from unsigned long to a more descriptive
phys_addr_t.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/cpu-reset.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
index ed50e9587ad8..3a54c4d987f3 100644
--- a/arch/arm64/kernel/cpu-reset.h
+++ b/arch/arm64/kernel/cpu-reset.h
@@ -10,17 +10,17 @@
 
 #include <asm/virt.h>
 
-void __cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
-	unsigned long arg0, unsigned long arg1, unsigned long arg2);
+void __cpu_soft_restart(phys_addr_t el2_switch, phys_addr_t entry,
+	phys_addr_t arg0, phys_addr_t arg1, phys_addr_t arg2);
 
-static inline void __noreturn cpu_soft_restart(unsigned long entry,
-					       unsigned long arg0,
-					       unsigned long arg1,
-					       unsigned long arg2)
+static inline void __noreturn cpu_soft_restart(phys_addr_t entry,
+					       phys_addr_t arg0,
+					       phys_addr_t arg1,
+					       phys_addr_t arg2)
 {
 	typeof(__cpu_soft_restart) *restart;
 
-	unsigned long el2_switch = !is_kernel_in_hyp_mode() &&
+	phys_addr_t el2_switch = !is_kernel_in_hyp_mode() &&
 		is_hyp_mode_available();
 	restart = (void *)__pa_symbol(__cpu_soft_restart);
 
-- 
2.23.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
