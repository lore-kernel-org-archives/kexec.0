Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g3FwG-0003LS-9C
 for kexec@lists.infradead.org; Fri, 21 Sep 2018 07:33:21 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 3/3 v3] x86/kexec_file: add reserved e820 ranges to kdump
 kernel e820 table
Date: Fri, 21 Sep 2018 15:32:11 +0800
Message-Id: <20180921073211.20097-4-lijiang@redhat.com>
In-Reply-To: <20180921073211.20097-1-lijiang@redhat.com>
References: <20180921073211.20097-1-lijiang@redhat.com>
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
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, bhe@redhat.com, tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org, mingo@redhat.com, baiyaowei@cmss.chinamobile.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, bp@suse.de, dyoung@redhat.com, akpm@linux-foundation.org, dan.j.williams@intel.com

E820 reserved ranges is useful in kdump kernel, we have added this in
kexec-tools code.

One reason is PCI mmconf (extended mode) requires reserved region
otherwise it falls back to legacy mode.

When AMD SME kdump support, it needs to map dmi table area as unencrypted.
For normal boot, these ranges sit in e820 reserved ranges, thus the early
ioremap code naturally map them as unencrypted. If we also have same e820
reserve setup in kdump kernel then it will just work like normal kernel.

Suggested-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 arch/x86/kernel/crash.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index ae724a6e0a5f..3460be990e0c 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -384,6 +384,11 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 	walk_iomem_res_desc(IORES_DESC_ACPI_NV_STORAGE, flags, 0, -1, &cmd,
 			memmap_entry_callback);
 
+	/* Add all reserved ranges */
+	cmd.type = E820_TYPE_RESERVED;
+	walk_iomem_res_desc(IORES_DESC_NONE, 0, 0, -1, &cmd,
+			memmap_entry_callback);
+
 	/* Add crashk_low_res region */
 	if (crashk_low_res.end) {
 		ei.addr = crashk_low_res.start;
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
