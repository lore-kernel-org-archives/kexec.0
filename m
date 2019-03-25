Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h8KyH-0007UZ-Dn
 for kexec@lists.infradead.org; Mon, 25 Mar 2019 08:28:44 +0000
From: Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: [PATCH v2] x86/boot: Use EFI setup data if provided
Date: Mon, 25 Mar 2019 08:27:21 +0000
Message-ID: <20190325082720.GA20771@jeru.linux.bs1.fc.nec.co.jp>
References: <20190322110342.GA16202@jeru.linux.bs1.fc.nec.co.jp>
 <20190322152328.GD12472@zn.tnic>
 <20190325002740.GA6637@jeru.linux.bs1.fc.nec.co.jp>
 <20190325060128.GB9385@dhcp-128-65.nay.redhat.com>
 <20190325061929.GC9385@dhcp-128-65.nay.redhat.com>
 <bcb5bd29-a3b8-e42d-8da7-a8501f695c21@ce.jp.nec.com>
 <20190325065921.GA11096@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190325065921.GA11096@dhcp-128-65.nay.redhat.com>
Content-Language: ja-JP
Content-ID: <F02F80C1669F7B48867BB2279D1EBD80@gisp.nec.co.jp>
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
To: Dave Young <dyoung@redhat.com>, "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>, "bp@suse.de" <bp@suse.de>, "bhe@redhat.com" <bhe@redhat.com>, "kasong@redhat.com" <kasong@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 3/25/19 3:59 PM, Dave Young wrote:
> On 03/25/19 at 06:47am, Junichi Nomura wrote:
>> On 3/25/19 3:19 PM, Dave Young wrote:
>>> On 03/25/19 at 02:01pm, Dave Young wrote:
>>> I think normally people do not see this bug, because kernel will set the
>>> rsdp in boot_params->acpi_rsdp_addr.  Maybe you are testing with
>>
>> I think it's only done for file-based kexec interface.
> 
> Saw Kairui's another reply, yes, kexec-tools need a patch to fill the
> value as well then.
> 
> I would vote for a repost of your old patch with some #ifdef

Thanks for comments, Dave, Kairui and Baoquan.

The problem for me is it's a regression in v5.1-rc1, that breaks
existing setup. If early parsing of RSDP is required only for newly
supported configuration, I'm fine such configuration requires
new tools or new options.

This is the 1st version plus #ifdef around the EFI code.
Build tested both with and without CONFIG_EFI to see no warnings.

[PATCH v2] x86/boot: Use EFI setup data if provided

Commit 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in
boot_params") broke kexec boot on EFI systems.  efi_get_rsdp_addr()
in the early parsing code tries to search RSDP from EFI table but
whose address is virtual.

Since kexec(1) provides physical address of config_table via boot_params,
efi_get_rsdp_addr() should look for setup_data in the same way as
efi_systab_init() in arch/x86/platform/efi/efi.c does.

Fixes: 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in boot_params")
Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
Acked-by: Dave Young <dyoung@redhat.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: Borislav Petkov <bp@suse.de>

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -44,6 +44,24 @@ static acpi_physical_address get_acpi_rsdp(void)
 	return addr;
 }
 
+#ifdef CONFIG_EFI
+static unsigned long efi_get_setup_data_addr(void)
+{
+	struct setup_data *data;
+	u64 pa_data;
+
+	pa_data = boot_params->hdr.setup_data;
+	while (pa_data) {
+		data = (struct setup_data *) pa_data;
+		if (data->type == SETUP_EFI)
+			return pa_data + sizeof(struct setup_data);
+		pa_data = data->next;
+	}
+
+	return 0;
+}
+#endif
+
 /* Search EFI system tables for RSDP. */
 static acpi_physical_address efi_get_rsdp_addr(void)
 {
@@ -53,10 +71,12 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 	unsigned long systab, systab_tables, config_tables;
 	unsigned int nr_tables;
 	struct efi_info *ei;
+	struct efi_setup_data *esd;
 	bool efi_64;
 	int size, i;
 	char *sig;
 
+	esd = (struct efi_setup_data *) efi_get_setup_data_addr();
 	ei = &boot_params->efi_info;
 	sig = (char *)&ei->efi_loader_signature;
 
@@ -86,13 +106,13 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 	if (efi_64) {
 		efi_system_table_64_t *stbl = (efi_system_table_64_t *)systab;
 
-		config_tables	= stbl->tables;
+		config_tables	= esd ? esd->tables : stbl->tables;
 		nr_tables	= stbl->nr_tables;
 		size		= sizeof(efi_config_table_64_t);
 	} else {
 		efi_system_table_32_t *stbl = (efi_system_table_32_t *)systab;
 
-		config_tables	= stbl->tables;
+		config_tables	= esd ? esd->tables : stbl->tables;
 		nr_tables	= stbl->nr_tables;
 		size		= sizeof(efi_config_table_32_t);
 	}

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
