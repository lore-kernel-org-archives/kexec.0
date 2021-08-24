Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-dm6nam11on2058.outbound.protection.outlook.com
 ([40.107.223.58] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mIUHq-002htu-U2
 for kexec@lists.infradead.org; Tue, 24 Aug 2021 11:08:15 +0000
From: Ashish Kalra <Ashish.Kalra@amd.com>
Subject: [PATCH v6 5/5] x86/kvm: Add kexec support for SEV Live Migration.
Date: Tue, 24 Aug 2021 11:07:45 +0000
Message-Id: <3e051424ab839ea470f88333273d7a185006754f.1629726117.git.ashish.kalra@amd.com>
In-Reply-To: <cover.1629726117.git.ashish.kalra@amd.com>
References: <cover.1629726117.git.ashish.kalra@amd.com>
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
Cc: seanjc@google.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, joro@8bytes.org, bp@alien8.de, Thomas.Lendacky@amd.com, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, srutherford@google.com, brijesh.singh@amd.com, dovmurik@linux.ibm.com, tobin@linux.ibm.com, jejb@linux.ibm.com, dgilbert@redhat.com, kexec@lists.infradead.org

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
Reviewed-by: Steve Rutherford <srutherford@google.com>
---
 arch/x86/kernel/kvm.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 7d36b98b567d..025d25efd7e6 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -869,10 +869,35 @@ static void __init kvm_init_platform(void)
 	if (sev_active() &&
 	    kvm_para_has_feature(KVM_FEATURE_MIGRATION_CONTROL)) {
 		unsigned long nr_pages;
+		int i;
 
 		pv_ops.mmu.notify_page_enc_status_changed =
 			kvm_sev_hc_page_enc_status;
 
+		/*
+		 * Reset the host's shared pages list related to kernel
+		 * specific page encryption status settings before we load a
+		 * new kernel by kexec. Reset the page encryption status
+		 * during early boot intead of just before kexec to avoid SMP
+		 * races during kvm_pv_guest_cpu_reboot().
+		 * NOTE: We cannot reset the complete shared pages list
+		 * here as we need to retain the UEFI/OVMF firmware
+		 * specific settings.
+		 */
+
+		for (i = 0; i < e820_table->nr_entries; i++) {
+			struct e820_entry *entry = &e820_table->entries[i];
+
+			if (entry->type != E820_TYPE_RAM)
+				continue;
+
+			nr_pages = DIV_ROUND_UP(entry->size, PAGE_SIZE);
+
+			kvm_sev_hypercall3(KVM_HC_MAP_GPA_RANGE, entry->addr,
+				       nr_pages,
+				       KVM_MAP_GPA_RANGE_ENCRYPTED | KVM_MAP_GPA_RANGE_PAGE_SZ_4K);
+		}
+
 		/*
 		 * Ensure that _bss_decrypted section is marked as decrypted in the
 		 * shared pages list.
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
