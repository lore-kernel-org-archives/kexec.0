Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364F1C5DF92
	for <kexec@archiver.kernel.org>; Fri, 21 Aug 2026 10:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J9aqNAg5ul6RSq/FAIbOKx+XdwPAzQxJAO/zzCdAwHg=; b=fi2GUPCbs18uk4s9xxdoLGEDem
	gh5dFBv3jTy+d3s57CkL3rbjtqoyiy2l3pafDTTQCtutqcJAD12eI0qfbXbV7UPoBj1xS8O6WyxxO
	jwvSCzalafvNII+qQs63Ukk/5pkWr3i/LVxLCetf7uSkOQXcnxahmqSlFS/sWxqj2U7qJa9qeZL2n
	6llMc5a4U/b8SKjQYsvmaoiO8L5zfyQB5y5pDbX+5+7KY6eKH5YHEBJoaV30MNndVg/hec+zXJvfI
	sVTH/h0d/sU00Sge5Avm2U9SjReJW6eNx0dmYJUeq1Rb0s9r0QkZ2U4jpvM/oUs/Ifk53q99UgAuk
	UuYiQo7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxM95-0000000D1PO-1740;
	Fri, 21 Aug 2026 10:06:43 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxM90-0000000D1MT-3G49
	for kexec@lists.infradead.org;
	Fri, 21 Aug 2026 10:06:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=J9aqNAg5ul6RSq/FAIbOKx+XdwPAzQxJAO/zzCdAwHg=; b=d3fGZ/2JK5ycFLowGuvx2sagko
	DBQC52aw4xCgc1cWiJbV9UIZom2VHDYnjCdzz4+Zs7vfUzWC9oWMy2wvhCXLPtTXVohubf+jl/8WL
	GHZg1C1sKs1U3I72psWlyb1VIr8I8nGdzyhcCjny5UKMt5NbHxQE3xz5N88QiCGoDXM/tpGnyK+cc
	xLaGOF2RhrWVCKNwptPd7+DLoWzAZBVXhrkHmY+v97JsTUtYNJZvlWZpRj/iRqnGYH1PQppHiKjGg
	o6/LHvG9QSGIWKWMiwCM4iOQAgFT7FiefMM38b7sNMdTIS/LfBwbyRB5XgvU8YpvTZEJNzdU9wrJa
	aFMZU6UQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wxM8z-00BGBQ-0B;
	Fri, 21 Aug 2026 10:06:37 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 21 Aug 2026 03:06:03 -0700
Subject: [PATCH v2 3/6] efi/libstub: add the poisoned-memory EFI table
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-hwpoison-kho-v2-3-5743791e48e6@debian.org>
References: <20260821-hwpoison-kho-v2-0-5743791e48e6@debian.org>
In-Reply-To: <20260821-hwpoison-kho-v2-0-5743791e48e6@debian.org>
To: Ard Biesheuvel <ardb@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, rmikey@meta.com, kas@kernel.org, riel@surriel.com, 
 kexec@lists.infradead.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=4996; i=leitao@debian.org;
 h=from:subject:message-id; bh=PTHqnbiTjtXvlEVFVF9aFX37DcM4Tdef+z9pkL5DEHI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqiCMaNchcVhpLMCWBvw7ck5ypAhOqMQ6wjKKz4
 yvqQ/qq1eiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaogjGgAKCRA1o5Of/Hh3
 bVD/D/0cN7PIq53NaWJ3IfCKiuNgIT98qPysaWAKjlETFbTUAQ1ql+39PrqBCdKE+THtkfP67Er
 DvsnOCjOXbWvAmFm9gqHdKX1dA4ugJHZRNFITE4uN2q7cDGFOeFVyzojQIuflFeCoRc9GovH8KH
 6BGU1quCuQWBocXDYLzILv//F3gXL47DO4IdI211yz+4jsOO0xPFEslQNQGXL7Q7UbRs46a3RzO
 P2jNzMggLWP9v8QbyM10ERON/iKEdxowGYdsQThd1STszA4xWHwQ+nZ30INvFCdxL4v2+SvsT8e
 JHxJbFjLeLDGkHMaK0+YmWF9JvjU7iInpO2zDVfNr2DE9u0wWALpZXDq/gYWDwh2rNozVXcfx7q
 1bWpej1lcTO/Z/lTjdbOay1iEv+xkyM+R3FaFB0K4EjzTfn2BqQItmwe1kLKKLSYNOCKO42PyrZ
 Snor5pRDsihsAxDXXhf+KQTdfCDwdvsqZfSiQA9ubP4qadteH22Uw7pQ7HaZXDqnZtvR4W34Bnh
 EoRFa3fF8JMIPuPsw47d1tVtXUOjXmfIV3dVQ43KGcc6UpwvPNNY0aDTOOksGdZynw8s0PxstCt
 tD3psHOQMQDZTO0vlqHTfhW4guGQZFmQJzyHzjyaaY7cExTdWGYEMeiXarWgg0IYHN0Apn3YomL
 uzN/V/b6T+Gbreg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_030638_826726_F4CA8B47 
X-CRM114-Status: GOOD (  15.62  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

A EFI config table can only be installed while boot services are
still up, so the stub has to create it; the running kernel can only
flip bits in a table that already exists.

Size the bitmap from efi_get_ram_top(): bit N covers unit N counting
from address 0, up to the top of usable RAM, so the table tracks
max_pfn. Memory the firmware hot-adds later sits above it and is not
carried across a kexec.

At one bit per 2M that is 64K per TiB. The 2M granule is called "unit"
here.

Cap the bitmap at 1M to make sure this doesn't get too big.

The next kernel reads unit_size back out of the table, so a wider unit
only costs precision: more memory withheld per poisoned frame, nothing
lost.

Allocate it as EFI_ACPI_RECLAIM_MEMORY so the next kernel does not take
it for free RAM, and install it empty.

A table installed by an earlier boot rides the system table across kexec
and is reused as-is.

Nothing calls it yet; the stub entry paths pick it up next.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 89 ++++++++++++++++++++++++++
 drivers/firmware/efi/libstub/efistub.h         |  6 ++
 2 files changed, 95 insertions(+)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index f27f2e1f00199..7258ecdf1f7c2 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -774,3 +774,92 @@ void efi_remap_image(unsigned long image_base, unsigned alloc_size,
 			efi_warn("Failed to remap data region non-executable\n");
 	}
 }
+
+#ifdef CONFIG_EFI_POISONED_MEMORY
+/* Cap on the bitmap; a span too wide to fit gets a coarser unit instead. */
+#define EFI_POISON_MAX_TABLE_SIZE	SZ_1M
+#define EFI_POISON_MAX_UNIT_SIZE	SZ_1G
+
+/*
+ * Bitmap geometry for a given top of RAM. The bitmap starts at address 0, so
+ * bit N covers unit N.
+ * In the following code, a "unit" is granule of physical address space that one
+ * bitmap bit covers.
+ */
+static u32 efi_poison_geometry(u64 ram_top, u64 *bitmap_size)
+{
+	u64 nr_units = DIV_ROUND_UP(ram_top, EFI_POISON_UNIT_SIZE);
+	u32 unit_size = EFI_POISON_UNIT_SIZE;
+
+	while (DIV_ROUND_UP(nr_units, BITS_PER_BYTE) > EFI_POISON_MAX_TABLE_SIZE &&
+	       unit_size < EFI_POISON_MAX_UNIT_SIZE) {
+		nr_units = DIV_ROUND_UP(nr_units, 2);
+		unit_size *= 2;
+	}
+
+	*bitmap_size = DIV_ROUND_UP(nr_units, BITS_PER_BYTE);
+	return unit_size;
+}
+
+/* ACPI reclaim memory, so the next kernel does not treat it as free RAM. */
+static struct linux_efi_poisoned_memory *efi_poison_alloc(u64 bitmap_size,
+							  u32 unit_size)
+{
+	struct linux_efi_poisoned_memory *pm;
+	efi_status_t status;
+
+	status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
+			     sizeof(*pm) + bitmap_size, (void **)&pm);
+	if (status != EFI_SUCCESS)
+		return NULL;
+
+	pm->version = 1;
+	pm->unit_size = unit_size;
+	pm->phys_base = 0;
+	pm->size = bitmap_size;
+	memset(pm->bitmap, 0, bitmap_size);
+
+	return pm;
+}
+
+/*
+ * Allocate and install the poisoned-memory bitmap while boot services are
+ * available
+ */
+void install_poisoned_memory_table(void)
+{
+	efi_guid_t poisoned_memory_table_guid = LINUX_EFI_POISONED_MEMORY_TABLE_GUID;
+	struct linux_efi_poisoned_memory *pm;
+	u64 ram_top, bitmap_size;
+	efi_status_t status;
+	u32 unit_size;
+
+	/* A table installed by an earlier boot rides the system table across kexec. */
+	pm = get_efi_config_table(poisoned_memory_table_guid);
+	if (pm) {
+		if (pm->version != 1)
+			efi_err("Unknown version of poisoned-memory table\n");
+		return;
+	}
+
+	if (efi_get_ram_top(&ram_top) != EFI_SUCCESS) {
+		efi_err("Failed to size the poisoned-memory table!\n");
+		return;
+	}
+
+	unit_size = efi_poison_geometry(ram_top, &bitmap_size);
+
+	pm = efi_poison_alloc(bitmap_size, unit_size);
+	if (!pm) {
+		efi_err("Failed to allocate poisoned-memory table!\n");
+		return;
+	}
+
+	status = efi_bs_call(install_configuration_table,
+			     &poisoned_memory_table_guid, pm);
+	if (status != EFI_SUCCESS) {
+		efi_bs_call(free_pool, pm);
+		efi_err("Failed to install poisoned-memory config table!\n");
+	}
+}
+#endif
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 77ba576779aca..b5e19ba50ddae 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1171,6 +1171,12 @@ efi_enable_reset_attack_mitigation(void) { }
 
 void efi_retrieve_eventlog(void);
 
+#ifdef CONFIG_EFI_POISONED_MEMORY
+void install_poisoned_memory_table(void);
+#else
+static inline void install_poisoned_memory_table(void) { }
+#endif
+
 struct sysfb_display_info *alloc_primary_display(void);
 struct sysfb_display_info *__alloc_primary_display(void);
 void free_primary_display(struct sysfb_display_info *dpy);

-- 
2.53.0-Meta


