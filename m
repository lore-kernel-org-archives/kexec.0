Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639B6CCA464
	for <kexec@archiver.kernel.org>; Fri, 16 Oct 2026 12:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uv2fkg6W4JOnKV+pKEj31JYcVvr5f+LNYb10Ih+u5Fs=; b=WEK6TWx3nziEbGrVdXsrLp1/Zk
	hikmCeAXoiyVqPxvChgxZsXQR31dneynq7x7r7ybvd3cMHlYaJWUTP+JNfsW9BtCcUIMyi/k0ClnU
	aM43m3HchpCiU7ASpIhLZhi32Go1uo/o0MUQ5Up0ScsRLVwy0jdFRyH1QptuN7835E3Q87QudZZAU
	WM9IWj5g69k4JhgWPwxNFR5aqP6imM7faI7+SidrOwJ8tWPlfQX3hDdFmlTQgRH/KbuvdHg9WyA5A
	X3r0H6Vip3wIWqWfSfoMytR1sgx2D79soGRIrrg83HkzOH3+JVkTHzDXbimoswLbXasNVJfnt8EnB
	/ogeJ1Dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHgrK-00000002prd-1MI2;
	Fri, 16 Oct 2026 12:16:26 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHgrD-00000002pnb-3ka5;
	Fri, 16 Oct 2026 12:16:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=Uv2fkg6W4JOnKV+pKEj31JYcVvr5f+LNYb10Ih+u5Fs=; b=ZTo5mWEvIkHofgKGsuQIBpmIyS
	RoONLcl9qrEhZabuu1MUvkzUaVcEnZInDBq7bNHJQ0w0dcRidnHwdYMpVMyVgiEmmxFqXEwJUjxHK
	4/SWA7d6v/1qOM6S+dS0JyOA/JwjfjyCO0LGrSslgAmnXxcGCBCAOY++gHhxhAr3jBIXfw38FOmZI
	wijMa8R4UzsVdUAfrIBnH6lxFKF8rKdQZfIKngH9qL93yTlr6She1otcRIOdkdxDAjVDzWWq/oMD6
	62N5ByAQLtL2LP16zO9Dy8GhNmUzhNn8Wt7Y/KrPpnV0tpc3MuVNbc33tKwi16eFMljAwjW7204WN
	8cathcpg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xHgr6-005xSl-26;
	Fri, 16 Oct 2026 12:16:13 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 16 Oct 2026 05:15:42 -0700
Subject: [PATCH v6 2/7] mm/memory-failure: libstub: install the
 poisoned-memory EFI table
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-hwpoison-kho-v6-2-f304255147da@debian.org>
References: <20261016-hwpoison-kho-v6-0-f304255147da@debian.org>
In-Reply-To: <20261016-hwpoison-kho-v6-0-f304255147da@debian.org>
To: Ard Biesheuvel <ardb@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Oscar Salvador <osalvador@suse.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, kas@kernel.org, 
 kexec@lists.infradead.org, Brendan Jackman <brendan.jackman@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 shakeel.butt@linux.dev
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-cxl@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, rmikey@meta.com, riel@surriel.com, 
 Breno Leitao <leitao@debian.org>, harry@kernel.org, kernel-team@meta.com
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=6920; i=leitao@debian.org;
 h=from:subject:message-id; bh=44uh6luSjYURm81ATMeQ8CuGW+KPhB42p/Yp34Nf+y0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq0hV0H/OJ5LwSLvug8tVPpUaxdCGvg9G3lhtcN
 q7pJUx7ecOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCatIVdAAKCRA1o5Of/Hh3
 bWbVD/9hzDYAjz4Dg5YFIjIa4vqZInz1Tm+DJIuD8JXzez95iNgGz53KW0Fx4Lnf8U456YuxW+z
 GpIAxfOa4FdfkG9UDsxylAfpDJVhAMtml2LxA+yr0oSUo7jkb1VHRuTbGmzTvJQaoBeLdIZq8c+
 pxLl2u4ziH6Oof2lHwBiQa/QEGIsdHkoRV7VZklAALlxkCAPLCVr2SjnBf0T9qO8M1Zz0PzXLSv
 lPNO+OR1U5fZerYVR4FLQg8rgS67vSr7f7+Gfdl79DLYz8XTIbWxd7LqSf+i6UpVC5xWbgicDZv
 NuEdxlO4k+ewHkp2HbM/vdBIxManJQWqx6tYC3wsyOlBX6CvdBmqrcADAUOmVVGQfs7xqUze0b1
 r43ymQ/5ZQ35vPrYgL2HF7Yr5BqTStQK06tBHb6Vg39Le0klVPKMmUplpfe+JAWbDGLO+jfIInr
 fzdqaXaVOBIrjw+/14YPwyuYKCv3E/E8JQq01MugSu8lbZYdIFubPWpVrawgLcPjFsJQYt5wLxJ
 d7vXoKc+VdO/OrycjYULiH+C2LGXrGhTOceDVs32nQGiNysJhrqzLUzvy95TJupkPEQkwECgzv4
 hvXWw1KjE75sBIQHZRlPQHddPRxqDICh3qFMvj14suYNj4eyieCzda6Lx2iWTMhuwB4gCzp/3rp
 UxSAKBfzT9UTukw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_051620_105018_8CF08EEB 
X-CRM114-Status: GOOD (  24.21  )
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

A EFI config table can only be installed while boot services are still
up, so the stub has to create it; the running kernel can only flip bits
in a table that already exists.

Size the bitmap from the span the UEFI memory map describes, which
efi_get_ram_range() walks since the stub has no max_pfn. Bit 0 covers
the bottom of that span, recorded in phys_base, so a machine whose RAM
starts high does not pay for the hole below it. Memory the firmware
hot-adds later sits outside the span and is not carried across a kexec.

One table has to serve every architecture, so the bitmap spans from the
lowest to the highest descriptor that is write-back cacheable or
unaccepted memory, as discussed with Kiryl. That leaves out the MMIO
apertures, which sit high enough to stretch it far past the RAM it needs
to describe. arm64 makes the same cut in is_usable_memory(); x86 sorts
descriptors by type instead, so a RAM descriptor without the attribute
would sit outside the span and not be carried across a kexec.

At one bit per 2M that is 64K per TiB, and 256M at the 4PB x86
architectural maximum. The 2M granule is called "unit" here, and the
table carries it so the granule can change later without breaking the
kernels already reading it.

Allocate it as EFI_ACPI_RECLAIM_MEMORY so the next kernel does not take
it for free RAM, and install it empty.

Reuse a table that an earlier stub run in the same firmware session already
installed.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 103 +++++++++++++++++++++++++
 drivers/firmware/efi/libstub/efi-stub.c        |   1 +
 drivers/firmware/efi/libstub/efistub.h         |   6 ++
 drivers/firmware/efi/libstub/x86-stub.c        |   2 +
 4 files changed, 112 insertions(+)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 48f93f7758e9e9..21569fe82cb514 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -774,3 +774,106 @@ void efi_remap_image(unsigned long image_base, unsigned alloc_size,
 			efi_warn("Failed to remap data region non-executable\n");
 	}
 }
+
+#ifdef CONFIG_EFI_POISONED_MEMORY
+/*
+ * Find the base and top of the memory, so, we can create the bitmap for
+ * the full range.
+ */
+static efi_status_t efi_get_ram_range(u64 *base, u64 *top)
+{
+	struct efi_boot_memmap *map __free(efi_pool) = NULL;
+	u64 ram_base = ULLONG_MAX, ram_top = 0;
+	efi_status_t status;
+	int i, nr_desc;
+
+	status = efi_get_memory_map(&map, false);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	nr_desc = map->map_size / map->desc_size;
+	for (i = 0; i < nr_desc; i++) {
+		efi_memory_desc_t *d;
+
+		d = efi_memdesc_ptr((unsigned long)map->map, map->desc_size, i);
+		if (!(d->attribute & EFI_MEMORY_WB) &&
+		    d->type != EFI_UNACCEPTED_MEMORY)
+			continue;
+		ram_base = min(ram_base, d->phys_addr);
+		ram_top = max(ram_top,
+			      d->phys_addr + d->num_pages * EFI_PAGE_SIZE);
+	}
+	if (!ram_top || ram_base == ULLONG_MAX)
+		return EFI_NOT_FOUND;
+
+	*base = round_down(ram_base, EFI_POISON_UNIT_SIZE);
+	*top = round_up(ram_top, EFI_POISON_UNIT_SIZE);
+
+	return EFI_SUCCESS;
+}
+
+/* The size of the bitmap */
+static u64 efi_poison_bitmap_size(u64 span)
+{
+	u64 bytes = DIV_ROUND_UP(DIV_ROUND_UP(span, EFI_POISON_UNIT_SIZE),
+				 BITS_PER_BYTE);
+
+	return round_up(bytes, sizeof(unsigned long));
+}
+
+static struct linux_efi_poisoned_memory *efi_poison_alloc(u64 phys_base,
+							  u64 bitmap_size)
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
+	pm->unit_size = EFI_POISON_UNIT_SIZE;
+	pm->phys_base = phys_base;
+	pm->size = bitmap_size;
+	memset(pm->bitmap, 0, bitmap_size);
+
+	return pm;
+}
+
+/* This needs to be done while boot service is still active */
+void install_poisoned_memory_table(void)
+{
+	efi_guid_t poisoned_memory_table_guid = LINUX_EFI_POISONED_MEMORY_TABLE_GUID;
+	struct linux_efi_poisoned_memory *pm;
+	u64 ram_base, ram_top, bitmap_size;
+	efi_status_t status;
+
+	/* An earlier stub run in this firmware session may have installed it. */
+	pm = get_efi_config_table(poisoned_memory_table_guid);
+	if (pm) {
+		if (pm->version != 1)
+			efi_err("Unknown version of poisoned-memory table\n");
+		return;
+	}
+
+	if (efi_get_ram_range(&ram_base, &ram_top) != EFI_SUCCESS) {
+		efi_err("Failed to size the poisoned-memory table!\n");
+		return;
+	}
+
+	bitmap_size = efi_poison_bitmap_size(ram_top - ram_base);
+	pm = efi_poison_alloc(ram_base, bitmap_size);
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
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 235c9738da2d63..22a315e2814a1a 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -179,6 +179,7 @@ efi_status_t efi_stub_common(efi_handle_t handle,
 			 EFI_RT_SUPPORTED_SET_VIRTUAL_ADDRESS_MAP);
 
 	install_memreserve_table();
+	install_poisoned_memory_table();
 
 	status = efi_boot_kernel(handle, image, image_addr, cmdline_ptr);
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index fd91fc15ec810b..44436869c4efe1 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1169,6 +1169,12 @@ efi_enable_reset_attack_mitigation(void) { }
 
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
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 0bae0f06b6763a..3136132b9628ab 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -1024,6 +1024,8 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 
 	setup_unaccepted_memory();
 
+	install_poisoned_memory_table();
+
 	status = exit_boot(boot_params, handle);
 	if (status != EFI_SUCCESS) {
 		efi_err("exit_boot() failed!\n");

-- 
2.53.0-Meta


