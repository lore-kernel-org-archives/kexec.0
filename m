Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fVANK-0004E1-Gk
 for kexec@lists.infradead.org; Tue, 19 Jun 2018 06:44:30 +0000
Received: by mail-pl0-x243.google.com with SMTP id w17-v6so10405760pll.9
 for <kexec@lists.infradead.org>; Mon, 18 Jun 2018 23:44:12 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 2/4] efi/arm: map UEFI memory map even w/o runtime services
 enabled
Date: Tue, 19 Jun 2018 15:44:22 +0900
Message-Id: <20180619064424.6642-3-takahiro.akashi@linaro.org>
In-Reply-To: <20180619064424.6642-1-takahiro.akashi@linaro.org>
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
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
To: catalin.marinas@arm.com, will.deacon@arm.com, akpm@linux-foundation.org, ard.biesheuvel@linaro.org
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, graeme.gregory@linaro.org, al.stone@linaro.org, bhsharma@redhat.com, tbaicar@codeaurora.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

Under the current implementation, UEFI memory map will be mapped and made
available in virtual mappings only if runtime services are enabled.
But in a later patch, we want to use UEFI memory map in acpi_os_ioremap()
to create mappings of ACPI tables using memory attributes described in
UEFI memory map.

So, as a first step, arm_enter_runtime_services() will be modified
so that UEFI memory map will be always accessible.

See a relevant commit:
    arm64: acpi: fix alignment fault in accessing ACPI tables

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/arm-runtime.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 5889cbea60b8..30ac5c82051e 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -115,6 +115,13 @@ static int __init arm_enable_runtime_services(void)
 		return 0;
 	}
 
+	mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
+
+	if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
+		pr_err("Failed to remap EFI memory map\n");
+		return 0;
+	}
+
 	if (efi_runtime_disabled()) {
 		pr_info("EFI runtime services will be disabled.\n");
 		return 0;
@@ -127,13 +134,6 @@ static int __init arm_enable_runtime_services(void)
 
 	pr_info("Remapping and enabling EFI services.\n");
 
-	mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
-
-	if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
-		pr_err("Failed to remap EFI memory map\n");
-		return -ENOMEM;
-	}
-
 	if (!efi_virtmap_init()) {
 		pr_err("UEFI virtual mapping missing or invalid -- runtime services will not be available\n");
 		return -ENOMEM;
-- 
2.17.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
