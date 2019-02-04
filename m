Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqiDE-0004FK-5o
 for kexec@lists.infradead.org; Mon, 04 Feb 2019 17:39:18 +0000
From: Kairui Song <kasong@redhat.com>
Subject: [PATCH] x86,
 kexec_file_load: fill in acpi_rsdp_addr boot param unconditionally
Date: Tue,  5 Feb 2019 01:38:52 +0800
Message-Id: <20190204173852.4863-1-kasong@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>, Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Andrew Morton <akpm@linux-foundation.org>

When efi=noruntime or efi=oldmap is used, EFI services won't be available
in the second kernel, therefore the second kernel will not be able to get
the ACPI RSDP address from firmware by calling EFI services so it won't
boot. Previously we are expecting the user to set the acpi_rsdp=<addr>
on kernel command line for second kernel as there was no other way to
pass RSDP address to second kernel.

After commit e6e094e053af ("x86/acpi, x86/boot: Take RSDP address from
boot params if available"), now it's possible to set an acpi_rsdp_addr
parameter in the boot_params passed to second kernel, and kernel will
prefer using this value for the RSDP address when it's set.

And with commit 3a63f70bf4c3 ("x86/boot: Early parse RSDP and save it in
boot_params"), now the acpi_rsdp_addr will always be filled with valid
RSDP address. So we just fill in that value for second kernel's
boot_params unconditionally, this ensure second kernel always use the
same RSDP value as the first kernel.

Tested with an EFI enabled KVM VM with efi=noruntime.

Signed-off-by: Kairui Song <kasong@redhat.com>
---

This is update of part of patch series: "[PATCH v3 0/3] make kexec work
with efi=noruntime or efi=old_map."

But "[PATCH v3 1/3] x86, kexec_file_load: Don't setup EFI info if EFI
runtime is not enabled" is already in [tip:x86/urgent], and with Chao's
commit 3a63f70bf4c3 in [tip:x86/boot], we can just fill in acpi_rsdp_addr
boot param unconditionally to fix the problem, so only I update and resend
this patch.

 arch/x86/kernel/kexec-bzimage64.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 53917a3ebf94..3611946dc7ea 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -218,6 +218,9 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 	params->screen_info.ext_mem_k = 0;
 	params->alt_mem_k = 0;
 
+	/* Always fill in RSDP, it's either 0 or a valid value */
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
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
