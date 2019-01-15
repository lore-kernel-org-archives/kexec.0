Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjLVq-0000lm-O3
 for kexec@lists.infradead.org; Tue, 15 Jan 2019 10:00:04 +0000
From: Kairui Song <kasong@redhat.com>
Subject: [PATCH v2 2/2] x86,
 kexec_file_load: make it work with efi=noruntime or efi=old_map
Date: Tue, 15 Jan 2019 17:58:34 +0800
Message-Id: <20190115095834.22617-3-kasong@redhat.com>
In-Reply-To: <20190115095834.22617-1-kasong@redhat.com>
References: <20190115095834.22617-1-kasong@redhat.com>
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
Cc: rafael.j.wysocki@intel.com, Kairui Song <kasong@redhat.com>, bhe@redhat.com, erik.schmauss@intel.com, x86@kernel.org, kexec@lists.infradead.org, robert.moore@intel.com, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org, lenb@kernel.org

When efi=noruntime or efi=oldmap is used, EFI services won't be available
in the second kernel, therefore the second kernel will not be able to get
the ACPI RSDP address from firmware by calling EFI services and won't
boot. Previously we are expecting the user to set the acpi_rsdp=<addr>
on kernel command line for second kernel as there was no way to pass RSDP
address to second kernel.

After commit e6e094e053af ('x86/acpi, x86/boot: Take RSDP address from
boot params if available'), now it's possible to set an acpi_rsdp_addr
parameter in the boot_params passed to second kernel, this commit make
use of it, detect and set the RSDP address when it's required for second
kernel to boot.

Tested with an EFI enabled KVM VM with efi=noruntime.

Suggested-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Kairui Song <kasong@redhat.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 21 +++++++++++++++++++++
 drivers/acpi/acpica/tbxfroot.c    |  3 +--
 include/acpi/acpixf.h             |  2 +-
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 53917a3ebf94..0a90dcbd041f 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -20,6 +20,7 @@
 #include <linux/mm.h>
 #include <linux/efi.h>
 #include <linux/verification.h>
+#include <linux/acpi.h>
 
 #include <asm/bootparam.h>
 #include <asm/setup.h>
@@ -255,8 +256,28 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 	/* Setup EFI state */
 	setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
 			efi_setup_data_offset);
+
+#ifdef CONFIG_ACPI
+	/* Setup ACPI RSDP pointer in case EFI is not available in second kernel */
+	if (!acpi_disabled && (!efi_enabled(EFI_RUNTIME_SERVICES) || efi_enabled(EFI_OLD_MEMMAP))) {
+		/* Copied from acpi_os_get_root_pointer accordingly */
+		params->acpi_rsdp_addr = boot_params.acpi_rsdp_addr;
+		if (!params->acpi_rsdp_addr) {
+			if (efi_enabled(EFI_CONFIG_TABLES)) {
+				if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
+					params->acpi_rsdp_addr = efi.acpi20;
+				else if (efi.acpi != EFI_INVALID_TABLE_ADDR)
+					params->acpi_rsdp_addr = efi.acpi;
+			} else if (IS_ENABLED(CONFIG_ACPI_LEGACY_TABLES_LOOKUP)) {
+				acpi_find_root_pointer(&params->acpi_rsdp_addr);
+			}
+		}
+		if (!params->acpi_rsdp_addr)
+			pr_warn("RSDP is not available for second kernel\n");
+	}
 #endif
 
+#endif
 	/* Setup EDD info */
 	memcpy(params->eddbuf, boot_params.eddbuf,
 				EDDMAXNR * sizeof(struct edd_info));
diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
index 483d0ce5180a..dac1e34a931c 100644
--- a/drivers/acpi/acpica/tbxfroot.c
+++ b/drivers/acpi/acpica/tbxfroot.c
@@ -108,8 +108,7 @@ acpi_status acpi_tb_validate_rsdp(struct acpi_table_rsdp *rsdp)
  *
  ******************************************************************************/
 
-acpi_status ACPI_INIT_FUNCTION
-acpi_find_root_pointer(acpi_physical_address *table_address)
+acpi_status acpi_find_root_pointer(acpi_physical_address *table_address)
 {
 	u8 *table_ptr;
 	u8 *mem_rover;
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 7aa38b648564..869d75ecaf7d 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -474,7 +474,7 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FUNCTION
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FUNCTION
 			    acpi_reallocate_root_table(void))
 
-ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FUNCTION
+ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			    acpi_find_root_pointer(acpi_physical_address
 						   *rsdp_address))
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
