Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJAf8-0006bp-N1
 for kexec@lists.infradead.org; Wed, 24 Apr 2019 05:41:44 +0000
Date: Wed, 24 Apr 2019 13:41:35 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] x86/kexec: always ensure EFI systab region is mapped
Message-ID: <20190424054135.GG3584@localhost.localdomain>
References: <20190422092804.15534-1-kasong@redhat.com>
 <965f770a-b103-72fb-eaef-cb337ebe8290@ce.jp.nec.com>
 <CACPcB9d-oNvp1Kag1J8X+QBdgqfU0ps1OztjOk8n=Pw2G6ONWA@mail.gmail.com>
 <24f1dc7c-1dea-79b0-d364-0dc7d605ce01@ce.jp.nec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <24f1dc7c-1dea-79b0-d364-0dc7d605ce01@ce.jp.nec.com>
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
To: Kairui Song <kasong@redhat.com>, Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc: "x86@kernel.org" <x86@kernel.org>, Chao Fan <fanc.fnst@cn.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>

On 04/24/19 at 02:47am, Junichi Nomura wrote:
> On 4/24/19 2:15 AM, Kairui Song wrote:
> > On Mon, Apr 22, 2019 at 11:21 PM Junichi Nomura <j-nomura@ce.jp.nec.com> wrote:
> >> Is the mapping of ACPI tables just by luck, too?
> > 
> > Good question, they should have same issue with systab, I ignored this one.
> > Then in first kernel when doing kexec it should ensure both ACPI
> > tables and the EFI systab are mapped, that should cover everything and
> > make it work.
> 
> Right.
> 
> > Is there anything else missing?
> No, as far as I looked around get_rsdp_addr().

Have made a draft patch to build ident mapping for ACPI tables too, it's
based on Kairui's patch. Dave has tested on his t400s laptop, and
passed. Please check if this adding is OK.

Kairui, you can add this into your patch to make a new one and resend.
Or I can combine them and send for you today.

From 7f17fcb12a6fddbb0f5e56e5137cc81f25c04af4 Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Wed, 24 Apr 2019 09:57:01 +0800
Subject: [PATCH] x86/kexec: Prepare ACPI table mapping for kexec kernel

If the kernel decompressing code accesses ACPI tabels in kexec-ed kernel,
they also need be 1:1 mapped.

---
 arch/x86/kernel/machine_kexec_64.c | 54 ++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index d5da54893f97..e2948aea27d4 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -30,6 +30,48 @@
 #include <asm/setup.h>
 #include <asm/set_memory.h>
 
+#ifdef CONFIG_ACPI
+/**
+ * Used while adding mapping for ACPI tables.
+ * Can be reused when other iomem regions need be mapped
+ */
+struct init_pgtable_data {
+	struct x86_mapping_info *info;
+	pgd_t *level4p;
+};
+
+static int mem_region_callback(struct resource *res, void *arg)
+{
+	struct init_pgtable_data *data= arg;
+	unsigned long mstart, mend;
+
+	mstart = res->start;
+	mend = mstart + resource_size(res) - 1;
+
+	return kernel_ident_mapping_init(data->info,
+			data->level4p, mstart, mend);
+}
+
+static int init_acpi_pgtable(struct x86_mapping_info *info,
+				   pgd_t *level4p)
+{
+	unsigned long flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+	struct init_pgtable_data data;
+
+	data.info = info;
+	data.level4p = level4p;
+	flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+	return walk_iomem_res_desc(IORES_DESC_ACPI_TABLES, flags, 0, -1,
+				   &data, mem_region_callback);
+}
+#else
+static int init_acpi_pgtable(struct x86_mapping_info *info,
+				   pgd_t *level4p)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_KEXEC_FILE
 const struct kexec_file_ops * const kexec_file_loaders[] = {
 		&kexec_bzImage64_ops,
@@ -114,6 +156,8 @@ static void *alloc_pgt_page(void *data)
 	return p;
 }
 
+
+
 #ifdef CONFIG_EFI
 static int init_efi_systab_pgtable(struct x86_mapping_info *info,
 				   pgd_t *level4p)
@@ -191,14 +235,18 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 			return result;
 	}
 
-	/*
-	 * Prepare EFI systab mapping for kexec kernel, systab is not
-	 * covered by pfn_mapped.
+	/**
+	 * Prepare EFI systab and ACPI table mapping for kexec kernel,
+	 * since they are not covered by pfn_mapped.
 	 */
 	result = init_efi_systab_pgtable(&info, level4p);
 	if (result)
 		return result;
 
+	result = init_acpi_pgtable(&info, level4p);
+	if (result)
+		return result;
+
 	return init_transition_pgtable(image, level4p);
 }
 
-- 
2.17.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
