Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h8LtF-0004Uh-D7
 for kexec@lists.infradead.org; Mon, 25 Mar 2019 09:27:35 +0000
From: Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: [PATCH v2] x86/boot: Don't try to search RSDP from EFI when
 kexec-booted
Date: Mon, 25 Mar 2019 09:25:20 +0000
Message-ID: <20190325092519.GA22914@jeru.linux.bs1.fc.nec.co.jp>
References: <20190322110342.GA16202@jeru.linux.bs1.fc.nec.co.jp>
 <20190322152328.GD12472@zn.tnic>
 <20190325002740.GA6637@jeru.linux.bs1.fc.nec.co.jp>
 <20190325060128.GB9385@dhcp-128-65.nay.redhat.com>
 <20190325061929.GC9385@dhcp-128-65.nay.redhat.com>
 <bcb5bd29-a3b8-e42d-8da7-a8501f695c21@ce.jp.nec.com>
 <20190325065921.GA11096@dhcp-128-65.nay.redhat.com>
 <20190325082720.GA20771@jeru.linux.bs1.fc.nec.co.jp>
 <51D9A7D1-49BF-4679-B102-0FC5AC300C9F@alien8.de>
In-Reply-To: <51D9A7D1-49BF-4679-B102-0FC5AC300C9F@alien8.de>
Content-Language: ja-JP
Content-ID: <A6A918F1AEE3B84E958508EAF8C4455F@gisp.nec.co.jp>
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
To: Boris Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>, "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>, "bp@suse.de" <bp@suse.de>, "bhe@redhat.com" <bhe@redhat.com>, "kasong@redhat.com" <kasong@redhat.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 3/25/19 5:54 PM, Boris Petkov wrote:
> I'm going to repeat that again until you get it:
> 
> If the kexec kernel should continue to use efi_systab_init() then you
> should make efi_get_rsdp_addr() exit early in the kexec-ed kernel.

Do you think this one is ok? Either works for me.

[PATCH v2] x86/boot: Don't try to search RSDP from EFI when kexec-booted

Commit 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in
boot_params") broke kexec boot on EFI systems.  efi_get_rsdp_addr()
in the early parsing code tries to search RSDP from EFI table but
whose address is virtual.

Normally kexec(1) provides physical address of config_table via boot_params
and EFI code uses that during initialization.
For the early boot code, we just exit efi_get_rsdp_addr() early if the kernel
is booted by kexec.

Fixes: 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in boot_params")
Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: Borislav Petkov <bp@suse.de>

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -44,6 +44,26 @@ static acpi_physical_address get_acpi_rsdp(void)
 	return addr;
 }
 
+#ifdef CONFIG_EFI
+static bool is_kexec_booted(void)
+{
+	struct setup_data *data;
+
+	/*
+	 * kexec-tools provides EFI setup data so that kexec-ed kernel
+	 * can find proper tables.
+	 */
+	data = (struct setup_data *) boot_params->hdr.setup_data;
+	while (data) {
+		if (data->type == SETUP_EFI)
+			return true;
+		data = (struct setup_data *) data->next;
+	}
+
+	return false;
+}
+#endif
+
 /* Search EFI system tables for RSDP. */
 static acpi_physical_address efi_get_rsdp_addr(void)
 {
@@ -57,6 +77,10 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 	int size, i;
 	char *sig;
 
+	/* If the system is kexec-booted, poking EFI systab may not work. */
+	if (is_kexec_booted())
+		return 0;
+
 	ei = &boot_params->efi_info;
 	sig = (char *)&ei->efi_loader_signature;
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
