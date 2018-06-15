Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fTjbM-0006zV-8s
 for kexec@lists.infradead.org; Fri, 15 Jun 2018 07:57:41 +0000
Received: by mail-pl0-x243.google.com with SMTP id w17-v6so4955442pll.9
 for <kexec@lists.infradead.org>; Fri, 15 Jun 2018 00:56:45 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 3/3] init: map UEFI memory map early if on arm or arm64
Date: Fri, 15 Jun 2018 16:56:23 +0900
Message-Id: <20180615075623.13454-4-takahiro.akashi@linaro.org>
In-Reply-To: <20180615075623.13454-1-takahiro.akashi@linaro.org>
References: <20180615075623.13454-1-takahiro.akashi@linaro.org>
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

As ACPI tables may not always be properly aligned, those regions should
be mapped cacheable in order to allow the kernel safe access to them.
UEFI memory map contains necessary information for mappings, and we want
to make sure that it should get accessible before any acpi_os_ioremap()'s.

So, in this patch, efi_enter_virtual_mode(), which was previously named
efi_enable_runtime_services() and invoked via early_initcall on arm/arm64,
is now moved early enough as the first access will occur in
acpi_load_tables() of acpi_early_init().

See a relevant commit:
    arm64: acpi,efi: fix alignment fault in accessing ACPI tables at kdump

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 init/main.c | 3 +++
 1 file changed, 3 insertions(+)

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
