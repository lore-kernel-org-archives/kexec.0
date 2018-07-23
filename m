Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fhQ8K-0001Jg-NN
 for kexec@lists.infradead.org; Mon, 23 Jul 2018 01:59:41 +0000
Received: by mail-pg1-x543.google.com with SMTP id r5-v6so11060442pgv.0
 for <kexec@lists.infradead.org>; Sun, 22 Jul 2018 18:59:22 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v4 2/5] drivers: acpi: add dependency of EFI for arm64
Date: Mon, 23 Jul 2018 10:57:29 +0900
Message-Id: <20180723015732.24252-3-takahiro.akashi@linaro.org>
In-Reply-To: <20180723015732.24252-1-takahiro.akashi@linaro.org>
References: <20180723015732.24252-1-takahiro.akashi@linaro.org>
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
To: catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org, ard.biesheuvel@linaro.org
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, graeme.gregory@linaro.org, al.stone@linaro.org, bhsharma@redhat.com, tbaicar@codeaurora.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

As Ard suggested, CONFIG_ACPI && !CONFIG_EFI doesn't make sense on arm64,
while CONFIG_ACPI and CONFIG_CPU_BIG_ENDIAN doesn't make sense either.

As CONFIG_EFI already has a dependency of !CONFIG_CPU_BIG_ENDIAN, it is
good enough to add a dependency of CONFIG_EFI to avoid any useless
combination of configuration.

This bug, reported by Will, will be revealed when my patch series,
"arm64: kexec,kdump: fix boot failures on acpi-only system," is applied
and the kernel is built under allmodconfig.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/acpi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index b533eeb6139d..15ab1daaa808 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -6,7 +6,7 @@
 menuconfig ACPI
 	bool "ACPI (Advanced Configuration and Power Interface) Support"
 	depends on !IA64_HP_SIM
-	depends on IA64 || X86 || ARM64
+	depends on IA64 || X86 || (ARM64 && EFI)
 	depends on PCI
 	select PNP
 	default y if (IA64 || X86)
-- 
2.18.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
