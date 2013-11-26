Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VlBhQ-0000pb-Uw
 for kexec@lists.infradead.org; Tue, 26 Nov 2013 06:00:42 +0000
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH v4 08/12] efi: only print saved efi runtime maps instead of
 all memmap ranges for kexec
Date: Tue, 26 Nov 2013 13:57:53 +0800
Message-Id: <1385445477-9665-9-git-send-email-dyoung@redhat.com>
In-Reply-To: <1385445477-9665-1-git-send-email-dyoung@redhat.com>
References: <1385445477-9665-1-git-send-email-dyoung@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

For kexec/kdump kernel efi runtime mappings are saved, printing original whole
memmap ranges does not make sense anymore. So introduce a new function to only
print runtime maps in case kexec/kdump kernel is used.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 arch/x86/platform/efi/efi.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index fafeb40..c65b0b8 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -430,6 +430,24 @@ int __init efi_memblock_x86_reserve_range(void)
 	return 0;
 }
 
+/* for kexec kernel runtime maps are passed in setup_data */
+static void __init print_saved_runtime_map(void)
+{
+#ifdef EFI_DEBUG
+	int i;
+	efi_memory_desc_t *md;
+
+	for (i = 0; i < nr_efi_runtime_map; i++) {
+		md = esdata->map + i;
+		pr_info("mem%02u: type=%u, attr=0x%llx, "
+			"range=[0x%016llx-0x%016llx) (%lluMB)\n",
+			i, md->type, md->attribute, md->phys_addr,
+			md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT),
+			(md->num_pages >> (20 - EFI_PAGE_SHIFT)));
+	}
+#endif  /*  EFI_DEBUG  */
+}
+
 static void __init print_efi_memmap(void)
 {
 #ifdef EFI_DEBUG
@@ -782,7 +800,10 @@ void __init efi_init(void)
 		x86_platform.set_wallclock = efi_set_rtc_mmss;
 	}
 #endif
-	print_efi_memmap();
+	if (esdata)
+		print_saved_runtime_map();
+	else
+		print_efi_memmap();
 }
 
 void __init efi_late_init(void)
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
