Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hEZHo-0008Fa-1T
 for kexec@lists.infradead.org; Thu, 11 Apr 2019 12:58:37 +0000
Date: Thu, 11 Apr 2019 14:58:22 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190411125822.GE30080@zn.tnic>
References: <20190408231011.GA5402@jeru.linux.bs1.fc.nec.co.jp>
 <20190410171431.GE26580@zn.tnic>
 <7cbc096d-0548-18b1-a335-8ba114f234a7@ce.jp.nec.com>
 <20190411080927.GA30080@zn.tnic>
 <e4de0520-ade8-2834-dadf-7af68701356b@ce.jp.nec.com>
 <20190411083738.GC30080@zn.tnic>
 <2946b5e3-90bf-d617-16a4-d2225b490b5d@ce.jp.nec.com>
 <DFC5B552-9B44-422B-8EAE-A32C24BB7A88@alien8.de>
 <e88fda9c-bd5a-d263-cd8a-380828dd6a93@ce.jp.nec.com>
 <C54C5A30-62D9-45C4-8036-88D255FD92A1@alien8.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <C54C5A30-62D9-45C4-8036-88D255FD92A1@alien8.de>
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
To: Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>, Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>

Something like this based on your v3. I still need to figure out a
reliable way to check in kexec_get_rsdp_addr() whether we're a kexec-ed
kernel but other than that, it should look something like this:

---
diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 0ef4ad55b29b..039d91258171 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -8,6 +8,8 @@
 #include <linux/efi.h>
 #include <asm/efi.h>
 
+#define EFI_SETUP_DATA_INVALID -1ULL
+
 /*
  * Longest parameter of 'acpi=' is 'copy_dsdt', plus an extra '\0'
  * for termination.
@@ -44,17 +46,108 @@ static acpi_physical_address get_acpi_rsdp(void)
 	return addr;
 }
 
-/* Search EFI system tables for RSDP. */
-static acpi_physical_address efi_get_rsdp_addr(void)
+static struct efi_setup_data *get_kexec_setup_data_addr(void)
+{
+	struct setup_data *data;
+	u64 pa_data;
+
+	pa_data = boot_params->hdr.setup_data;
+	while (pa_data) {
+		data = (struct setup_data *) pa_data;
+		if (data->type == SETUP_EFI)
+			return (struct efi_setup_data *)(pa_data + sizeof(struct setup_data));
+
+		pa_data = data->next;
+	}
+	return NULL;
+}
+
+#ifdef CONFIG_EFI
+/*
+ * Search EFI system tables for RSDP.  If both ACPI_20_TABLE_GUID and
+ * ACPI_TABLE_GUID are found, take the former, which has more features.
+ */
+static acpi_physical_address
+__efi_get_rsdp_addr(unsigned long config_tables, unsigned int nr_tables,
+		    bool efi_64)
 {
 	acpi_physical_address rsdp_addr = 0;
+	int i;
+
+	/* Get EFI tables from systab. */
+	for (i = 0; i < nr_tables; i++) {
+		acpi_physical_address table;
+		efi_guid_t guid;
+
+		if (efi_64) {
+			efi_config_table_64_t *tbl = (efi_config_table_64_t *) config_tables + i;
+
+			guid  = tbl->guid;
+			table = tbl->table;
+
+			if (!IS_ENABLED(CONFIG_X86_64) && table >> 32) {
+				debug_putstr("Error getting RSDP address: EFI config table located above 4GB.\n");
+				return 0;
+			}
+		} else {
+			efi_config_table_32_t *tbl = (efi_config_table_32_t *) config_tables + i;
+
+			guid  = tbl->guid;
+			table = tbl->table;
+		}
+
+		if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
+			rsdp_addr = table;
+		else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
+			return table;
+	}
+
+	return rsdp_addr;
+}
+#endif
+
+/* EFI/kexec support is 64-bit only. */
+static acpi_physical_address kexec_get_rsdp_addr(void)
+{
+	efi_system_table_64_t *systab;
+	struct efi_setup_data *esd;
+	struct efi_info *ei;
+	char *sig;
+
+	if (!IS_ENABLED(CONFIG_X86_64))
+		return 0;
+
+	esd = get_kexec_setup_data_addr();
+	if (!esd)
+		return EFI_SETUP_DATA_INVALID;
 
+	if (!esd->tables) {
+		debug_putstr("Wrong kexec SETUP_EFI data.\n");
+		return 0;
+	}
+
+	ei = &boot_params->efi_info;
+	sig = (char *)&ei->efi_loader_signature;
+	if (strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
+		debug_putstr("Wrong kexec EFI loader signature.\n");
+		return 0;
+	}
+
+	/* Get systab from boot params. */
+	systab = (efi_system_table_64_t *) (ei->efi_systab | ((__u64)ei->efi_systab_hi << 32));
+	if (!systab)
+		error("EFI system table not found in kexec boot_params.");
+
+	return __efi_get_rsdp_addr((unsigned long)esd->tables, systab->nr_tables, true);
+}
+
+static acpi_physical_address efi_get_rsdp_addr(void)
+{
 #ifdef CONFIG_EFI
-	unsigned long systab, systab_tables, config_tables;
+	unsigned long systab, config_tables;
 	unsigned int nr_tables;
 	struct efi_info *ei;
 	bool efi_64;
-	int size, i;
 	char *sig;
 
 	ei = &boot_params->efi_info;
@@ -88,49 +181,20 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 
 		config_tables	= stbl->tables;
 		nr_tables	= stbl->nr_tables;
-		size		= sizeof(efi_config_table_64_t);
 	} else {
 		efi_system_table_32_t *stbl = (efi_system_table_32_t *)systab;
 
 		config_tables	= stbl->tables;
 		nr_tables	= stbl->nr_tables;
-		size		= sizeof(efi_config_table_32_t);
 	}
 
 	if (!config_tables)
 		error("EFI config tables not found.");
 
-	/* Get EFI tables from systab. */
-	for (i = 0; i < nr_tables; i++) {
-		acpi_physical_address table;
-		efi_guid_t guid;
-
-		config_tables += size;
-
-		if (efi_64) {
-			efi_config_table_64_t *tbl = (efi_config_table_64_t *)config_tables;
-
-			guid  = tbl->guid;
-			table = tbl->table;
-
-			if (!IS_ENABLED(CONFIG_X86_64) && table >> 32) {
-				debug_putstr("Error getting RSDP address: EFI config table located above 4GB.\n");
-				return 0;
-			}
-		} else {
-			efi_config_table_32_t *tbl = (efi_config_table_32_t *)config_tables;
-
-			guid  = tbl->guid;
-			table = tbl->table;
-		}
-
-		if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
-			rsdp_addr = table;
-		else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
-			return table;
-	}
+	return __efi_get_rsdp_addr(config_tables, nr_tables, efi_64);
+#else
+	return 0;
 #endif
-	return rsdp_addr;
 }
 
 static u8 compute_checksum(u8 *buffer, u32 length)
@@ -220,6 +284,12 @@ acpi_physical_address get_rsdp_addr(void)
 	if (!pa)
 		pa = boot_params->acpi_rsdp_addr;
 
+	if (!pa)
+		pa = kexec_get_rsdp_addr();
+
+	if (pa == EFI_SETUP_DATA_INVALID)
+		return 0;
+
 	if (!pa)
 		pa = efi_get_rsdp_addr();
 


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
