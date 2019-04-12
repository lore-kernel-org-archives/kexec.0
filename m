Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hErt0-0006hp-58
 for kexec@lists.infradead.org; Fri, 12 Apr 2019 08:50:15 +0000
Date: Fri, 12 Apr 2019 10:49:56 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190412084956.GC19808@zn.tnic>
References: <7cbc096d-0548-18b1-a335-8ba114f234a7@ce.jp.nec.com>
 <20190411080927.GA30080@zn.tnic>
 <e4de0520-ade8-2834-dadf-7af68701356b@ce.jp.nec.com>
 <20190411083738.GC30080@zn.tnic>
 <2946b5e3-90bf-d617-16a4-d2225b490b5d@ce.jp.nec.com>
 <DFC5B552-9B44-422B-8EAE-A32C24BB7A88@alien8.de>
 <e88fda9c-bd5a-d263-cd8a-380828dd6a93@ce.jp.nec.com>
 <C54C5A30-62D9-45C4-8036-88D255FD92A1@alien8.de>
 <20190411125822.GE30080@zn.tnic>
 <20190412025416.GA11070@jeru.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190412025416.GA11070@jeru.linux.bs1.fc.nec.co.jp>
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

On Fri, Apr 12, 2019 at 02:54:17AM +0000, Junichi Nomura wrote:
> Without #ifdef CONFIG_X86_64, I got compiler warnings on 32bit build
> about casting u64 to pointer.

Yah, stupid ifdeffery.

> We need #ifdef CONFIG_EFI to avoid build failure about undefined
> __efi_get_rsdp_addr().

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index c3020e2d8f67..4b1d4a0a4269 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -46,7 +46,6 @@ static acpi_physical_address get_acpi_rsdp(void)
 	return addr;
 }
 
-#ifdef CONFIG_EFI
 /*
  * Search EFI system tables for RSDP.  If both ACPI_20_TABLE_GUID and
  * ACPI_TABLE_GUID are found, take the former, which has more features.
@@ -56,6 +55,8 @@ __efi_get_rsdp_addr(unsigned long config_tables, unsigned int nr_tables,
 		    bool efi_64)
 {
 	acpi_physical_address rsdp_addr = 0;
+
+#ifdef CONFIG_EFI
 	int i;
 
 	/* Get EFI tables from systab. */
@@ -85,10 +86,9 @@ __efi_get_rsdp_addr(unsigned long config_tables, unsigned int nr_tables,
 		else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
 			return table;
 	}
-
+#endif
 	return rsdp_addr;
 }
-#endif
 
 /* EFI/kexec support is 64-bit only. */
 #ifdef CONFIG_X86_64
---

> I think that should be the other way around:

No, it shouldn't.

kexec_get_rsdp_addr() must do:

	if (!kexec_kernel)
		return 0:

        esd = (struct efi_setup_data *)get_kexec_setup_data_addr();
        if (!esd)
                return EFI_SETUP_DATA_INVALID;

	...

Now I need to go figure out whether there's a reliable way to know in
the kexec kernel that it *is* a kexec kernel.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
