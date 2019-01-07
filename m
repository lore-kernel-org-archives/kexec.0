Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggK1O-0000gy-8v
 for kexec@lists.infradead.org; Mon, 07 Jan 2019 01:48:07 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 2/2 v5] kdump,
 vmcoreinfo: Export the value of sme mask to vmcoreinfo
Date: Mon,  7 Jan 2019 09:47:34 +0800
Message-Id: <20190107014734.9730-3-lijiang@redhat.com>
In-Reply-To: <20190107014734.9730-1-lijiang@redhat.com>
References: <20190107014734.9730-1-lijiang@redhat.com>
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
Cc: k-hagio@ab.jp.nec.com, bhe@redhat.com, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, mingo@redhat.com, bp@alien8.de, anderson@redhat.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

For AMD machine with SME feature, makedumpfile tools need to know
whether the crash kernel was encrypted or not. If SME is enabled
in the first kernel, the crash kernel's page table(pgd/pud/pmd/pte)
contains the memory encryption mask, so need to remove the sme mask
to obtain the true physical address.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 4c8acdfdc5a7..bc4108096b18 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -352,10 +352,13 @@ void machine_kexec(struct kimage *image)
 
 void arch_crash_save_vmcoreinfo(void)
 {
+	u64 sme_mask = sme_me_mask;
+
 	VMCOREINFO_NUMBER(phys_base);
 	VMCOREINFO_SYMBOL(init_top_pgt);
 	vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
 			pgtable_l5_enabled());
+	VMCOREINFO_NUMBER(sme_mask);
 
 #ifdef CONFIG_NUMA
 	VMCOREINFO_SYMBOL(node_data);
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
