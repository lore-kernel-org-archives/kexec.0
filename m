Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gFyYM-0003CG-Gu
 for kexec@lists.infradead.org; Fri, 26 Oct 2018 09:37:16 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
Date: Fri, 26 Oct 2018 17:36:30 +0800
Message-Id: <20181026093630.8520-1-lijiang@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, mingo@redhat.com, bp@alien8.de, tglx@linutronix.de, dyoung@redhat.com

For AMD machine with SME feature, makedumpfile tools need to know
whether the crash kernel was encrypted or not. So it is necessary
to write the sme_me_mask to vmcoreinfo.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 4c8acdfdc5a7..dcfdb64d1097 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -357,6 +357,8 @@ void arch_crash_save_vmcoreinfo(void)
 	vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
 			pgtable_l5_enabled());
 
+	VMCOREINFO_NUMBER(sme_me_mask);
+
 #ifdef CONFIG_NUMA
 	VMCOREINFO_SYMBOL(node_data);
 	VMCOREINFO_LENGTH(node_data, MAX_NUMNODES);
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
