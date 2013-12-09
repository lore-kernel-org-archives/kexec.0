Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VpxP7-0000XM-L6
 for kexec@lists.infradead.org; Mon, 09 Dec 2013 09:45:31 +0000
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH v5 10/14] efi: only print saved efi runtime maps instead of
 all memmap ranges for kexec
Date: Mon,  9 Dec 2013 17:42:23 +0800
Message-Id: <1386582147-9802-11-git-send-email-dyoung@redhat.com>
In-Reply-To: <1386582147-9802-1-git-send-email-dyoung@redhat.com>
References: <1386582147-9802-1-git-send-email-dyoung@redhat.com>
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

changelog:
Matt: use efi_setup instead of esdata
      share function print_efi_memmap for both normal and kexec boot.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 arch/x86/platform/efi/efi.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 69a6ec2..94a1cbc 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -423,19 +423,16 @@ int __init efi_memblock_x86_reserve_range(void)
 	return 0;
 }
 
-static void __init print_efi_memmap(void)
+static void __init print_efi_memmap(void *map, int nr_map, int md_size)
 {
 #ifdef EFI_DEBUG
 	efi_memory_desc_t *md;
 	void *p;
 	int i;
 
-	for (p = memmap.map, i = 0;
-	     p < memmap.map_end;
-	     p += memmap.desc_size, i++) {
+	for (p = map, i = 0; i < nr_map; p += md_size, i++) {
 		md = p;
-		pr_info("mem%02u: type=%u, attr=0x%llx, "
-			"range=[0x%016llx-0x%016llx) (%lluMB)\n",
+		pr_info("mem%02u: type=%u, attr=0x%llx, range=[0x%016llx-0x%016llx) (%lluMB)\n",
 			i, md->type, md->attribute, md->phys_addr,
 			md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT),
 			(md->num_pages >> (20 - EFI_PAGE_SHIFT)));
@@ -797,7 +794,20 @@ void __init efi_init(void)
 		x86_platform.set_wallclock = efi_set_rtc_mmss;
 	}
 #endif
-	print_efi_memmap();
+	if (efi_setup) {
+		int s;
+		struct efi_setup_data *data;
+
+		s = sizeof(*data) + nr_efi_runtime_map * sizeof(data->map[0]);
+		data = early_memremap(efi_setup, s);
+		if (!data)
+			return;
+		print_efi_memmap(data->map, nr_efi_runtime_map,
+				 sizeof(data->map[0]));
+		early_memunmap(data, s);
+	} else {
+		print_efi_memmap(memmap.map, memmap.nr_map, memmap.desc_size);
+	}
 }
 
 void __init efi_late_init(void)
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
