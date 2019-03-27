Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h9CxV-0006ck-Mx
 for kexec@lists.infradead.org; Wed, 27 Mar 2019 18:07:31 +0000
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 173/262] x86/kexec: Fill in acpi_rsdp_addr from
 the first kernel
Date: Wed, 27 Mar 2019 14:00:28 -0400
Message-Id: <20190327180158.10245-173-sashal@kernel.org>
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
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
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Philipp Rudo <prudo@linux.vnet.ibm.com>, x86-ml <x86@kernel.org>, Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, Chao Fan <fanc.fnst@cn.fujitsu.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Yannik Sembritzki <yannik@sembritzki.me>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@suse.de>, Dave Young <dyoung@redhat.com>, Thomas Gleixner <tglx@linutronix.de>

From: Kairui Song <kasong@redhat.com>

[ Upstream commit ccec81e4251f5a5421e02874e394338a897056ca ]

When efi=noruntime or efi=oldmap is used on the kernel command line, EFI
services won't be available in the second kernel, therefore the second
kernel will not be able to get the ACPI RSDP address from firmware by
calling EFI services and so it won't boot.

Commit

  e6e094e053af ("x86/acpi, x86/boot: Take RSDP address from boot params if available")

added an acpi_rsdp_addr field to boot_params which stores the RSDP
address for other kernel users.

Recently, after

  3a63f70bf4c3 ("x86/boot: Early parse RSDP and save it in boot_params")

the acpi_rsdp_addr will always be filled with a valid RSDP address.

So fill in that value into the second kernel's boot_params thus ensuring
that the second kernel receives the RSDP value from the first kernel.

 [ bp: massage commit message. ]

Signed-off-by: Kairui Song <kasong@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: kexec@lists.infradead.org
Cc: Philipp Rudo <prudo@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Cc: Yannik Sembritzki <yannik@sembritzki.me>
Link: https://lkml.kernel.org/r/20190204173852.4863-1-kasong@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/kexec-bzimage64.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 53917a3ebf94..1f3b77367948 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -218,6 +218,9 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 	params->screen_info.ext_mem_k = 0;
 	params->alt_mem_k = 0;
 
+	/* Always fill in RSDP: it is either 0 or a valid value */
+	params->acpi_rsdp_addr = boot_params.acpi_rsdp_addr;
+
 	/* Default APM info */
 	memset(&params->apm_bios_info, 0, sizeof(params->apm_bios_info));
 
@@ -256,7 +259,6 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 	setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
 			efi_setup_data_offset);
 #endif
-
 	/* Setup EDD info */
 	memcpy(params->eddbuf, boot_params.eddbuf,
 				EDDMAXNR * sizeof(struct edd_info));
-- 
2.19.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
