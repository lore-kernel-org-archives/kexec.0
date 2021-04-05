Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn7nam10on2079.outbound.protection.outlook.com
 ([40.107.92.79] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lTQKh-00HPtH-Bm
 for kexec@lists.infradead.org; Mon, 05 Apr 2021 14:36:05 +0000
From: Ashish Kalra <Ashish.Kalra@amd.com>
Subject: [PATCH v11 13/13] x86/kvm: Add kexec support for SEV Live Migration.
Date: Mon,  5 Apr 2021 14:35:46 +0000
Message-Id: <f37fea4a83aecf03198b0881a17561cdbf4e5a2b.1617302792.git.ashish.kalra@amd.com>
In-Reply-To: <cover.1617302792.git.ashish.kalra@amd.com>
References: <cover.1617302792.git.ashish.kalra@amd.com>
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
To: pbonzini@redhat.com
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, joro@8bytes.org, bp@suse.de, thomas.lendacky@amd.com, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, srutherford@google.com, seanjc@google.com, venu.busireddy@oracle.com, brijesh.singh@amd.com, kexec@lists.infradead.org

From: Ashish Kalra <ashish.kalra@amd.com>

Reset the host's shared pages list related to kernel
specific page encryption status settings before we load a
new kernel by kexec. We cannot reset the complete
shared pages list here as we need to retain the
UEFI/OVMF firmware specific settings.

The host's shared pages list is maintained for the
guest to keep track of all unencrypted guest memory regions,
therefore we need to explicitly mark all shared pages as
encrypted again before rebooting into the new guest kernel.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/kernel/kvm.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index bcc82e0c9779..4ad3ed547ff1 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -39,6 +39,7 @@
 #include <asm/cpuidle_haltpoll.h>
 #include <asm/ptrace.h>
 #include <asm/svm.h>
+#include <asm/e820/api.h>
 
 DEFINE_STATIC_KEY_FALSE(kvm_async_pf_enabled);
 
@@ -384,6 +385,29 @@ static void kvm_pv_guest_cpu_reboot(void *unused)
 	 */
 	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
 		wrmsrl(MSR_KVM_PV_EOI_EN, 0);
+	/*
+	 * Reset the host's shared pages list related to kernel
+	 * specific page encryption status settings before we load a
+	 * new kernel by kexec. NOTE: We cannot reset the complete
+	 * shared pages list here as we need to retain the
+	 * UEFI/OVMF firmware specific settings.
+	 */
+	if (sev_live_migration_enabled & (smp_processor_id() == 0)) {
+		int i;
+		unsigned long nr_pages;
+
+		for (i = 0; i < e820_table->nr_entries; i++) {
+			struct e820_entry *entry = &e820_table->entries[i];
+
+			if (entry->type != E820_TYPE_RAM)
+				continue;
+
+			nr_pages = DIV_ROUND_UP(entry->size, PAGE_SIZE);
+
+			kvm_sev_hypercall3(KVM_HC_PAGE_ENC_STATUS,
+					   entry->addr, nr_pages, 1);
+		}
+	}
 	kvm_pv_disable_apf();
 	kvm_disable_steal_time();
 }
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
