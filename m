Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fVANP-0004G3-2A
 for kexec@lists.infradead.org; Tue, 19 Jun 2018 06:44:41 +0000
Received: by mail-pf0-x243.google.com with SMTP id w7-v6so9424496pfn.9
 for <kexec@lists.infradead.org>; Mon, 18 Jun 2018 23:44:16 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 3/4] efi/arm: map UEFI memory map earlier on boot
Date: Tue, 19 Jun 2018 15:44:23 +0900
Message-Id: <20180619064424.6642-4-takahiro.akashi@linaro.org>
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

Since arm_enter_runtime_services() was modified to always create a virtual
mapping of UEFI memory map in the previous patch, it is now renamed to
efi_enter_virtual_mode() and called earlier before acpi_load_tables()
in acpi_early_init().

This will allow us to use UEFI memory map in acpi_os_ioremap() to create
mappings of ACPI tables using memory attributes described in UEFI memory
map.

See a relevant commit:
    arm64: acpi: fix alignment fault in accessing ACPI tables

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/firmware/efi/arm-runtime.c | 15 ++++++---------
 init/main.c                        |  3 +++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 30ac5c82051e..566ef0a9edb5 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -106,46 +106,43 @@ static bool __init efi_virtmap_init(void)
  * non-early mapping of the UEFI system table and virtual mappings for all
  * EFI_MEMORY_RUNTIME regions.
  */
-static int __init arm_enable_runtime_services(void)
+void __init efi_enter_virtual_mode(void)
 {
 	u64 mapsize;
 
 	if (!efi_enabled(EFI_BOOT)) {
 		pr_info("EFI services will not be available.\n");
-		return 0;
+		return;
 	}
 
 	mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
 
 	if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
 		pr_err("Failed to remap EFI memory map\n");
-		return 0;
+		return;
 	}
 
 	if (efi_runtime_disabled()) {
 		pr_info("EFI runtime services will be disabled.\n");
-		return 0;
+		return;
 	}
 
 	if (efi_enabled(EFI_RUNTIME_SERVICES)) {
 		pr_info("EFI runtime services access via paravirt.\n");
-		return 0;
+		return;
 	}
 
 	pr_info("Remapping and enabling EFI services.\n");
 
 	if (!efi_virtmap_init()) {
 		pr_err("UEFI virtual mapping missing or invalid -- runtime services will not be available\n");
-		return -ENOMEM;
+		return;
 	}
 
 	/* Set up runtime services function pointers */
 	efi_native_runtime_setup();
 	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
-
-	return 0;
 }
-early_initcall(arm_enable_runtime_services);
 
 void efi_virtmap_load(void)
 {
diff --git a/init/main.c b/init/main.c
index 3b4ada11ed52..532fc0d02353 100644
--- a/init/main.c
+++ b/init/main.c
@@ -694,6 +694,9 @@ asmlinkage __visible void __init start_kernel(void)
 	debug_objects_mem_init();
 	setup_per_cpu_pageset();
 	numa_policy_init();
+	if (IS_ENABLED(CONFIG_EFI) &&
+	    (IS_ENABLED(CONFIG_ARM64) || IS_ENABLED(CONFIG_ARM)))
+		efi_enter_virtual_mode();
 	acpi_early_init();
 	if (late_time_init)
 		late_time_init();
-- 
2.17.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
