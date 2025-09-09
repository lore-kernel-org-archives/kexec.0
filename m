Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA32CAC582
	for <kexec@archiver.kernel.org>; Tue,  9 Sep 2025 20:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m8A5M9SWZ4FduOae9/W265UdgKKBYKII8mDM46+RgEM=; b=4JzpqfHdUDZ4YgQhiT3WPZKS0h
	lT0V4A68uRTPl9lxXU9vS0cX9AsJgo5pf2b91gtAxZYKuk2tz15XuNqzU9FF4GvCKVGLMkwHhsPBO
	6N3kVqita7bd/QsGb1mEYxJpot2k5DrBrWtFisnuhNZdpK1fEJhVLs1sCSGSN7nOxlNSCjPd/KjY2
	6HPrHlkGLJIETj8hn5XzIaw1SQNOLWkJ7hoOThE+GnTWnXruJgRvhtcrNALVpEkwK/xTpgoLslcU2
	Sh/Xun4+tVDYpwxH5+cT+1XfM4xAv8yRf7tKRWjemNFMakvPbBDpMfED2+3SuV7EPqCkvpFhegBFh
	3e+Ih6Qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw4kr-00000009wFT-2zXi;
	Tue, 09 Sep 2025 20:15:53 +0000
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw4ko-00000009wBT-36Li
	for kexec@lists.infradead.org;
	Tue, 09 Sep 2025 20:15:52 +0000
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id EE366C01AB;
	Tue, 09 Sep 2025 23:15:48 +0300 (MSK)
Received: from localhost.localdomain (172.31.115.73-vpn.dhcp.yndx.net [172.31.115.73])
	by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id IFQqlX5GteA0-QszPafCr;
	Tue, 09 Sep 2025 23:15:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
	s=default; t=1757448948;
	bh=m8A5M9SWZ4FduOae9/W265UdgKKBYKII8mDM46+RgEM=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=ypBkuNKW+ERXO+vB9wi+MesqhXDJci+Z58snBgpV01YxOdZZSgyD0EiGOS1d6ChRM
	 hs4mlstpXx3wA2LGBMtVkU4uQU0M8JpfQTx3pK+DQa36tE3REBAz6GdNN58l44rh9q
	 GyjRrorPLSUoRNijR571xdfTd90C7ZpqX08mC7Vk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.com
From: Andrey Ryabinin <arbn@yandex-team.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	James Gowans <jgowans@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	Pratyush Yadav <ptyadav@amazon.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Rientjes <rientjes@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Chris Li <chrisl@kernel.org>,
	Ashish.Kalra@amd.com,
	William Tu <witu@nvidia.com>,
	David Matlack <dmatlack@google.com>,
	Andrey Ryabinin <arbn@yandex-team.com>
Subject: [PATCH v3 6/7] mm/memblock: Use KSTATE instead of kho to preserve preserved_mem_table
Date: Tue,  9 Sep 2025 22:14:41 +0200
Message-ID: <20250909201446.13138-7-arbn@yandex-team.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250909201446.13138-1-arbn@yandex-team.com>
References: <20250909201446.13138-1-arbn@yandex-team.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250909_131550_963272_7A04E37D 
X-CRM114-Status: GOOD (  19.57  )
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

Currently preserved_mem_table serialized/deserialized using fdt. Use KSTATE
instead as it makes code simpler and more compact.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
---
 include/linux/kstate.h |   1 +
 mm/memblock.c          | 158 +++++++++++++----------------------------
 2 files changed, 49 insertions(+), 110 deletions(-)

diff --git a/include/linux/kstate.h b/include/linux/kstate.h
index 0ced0da37c8f..db8ba07e2319 100644
--- a/include/linux/kstate.h
+++ b/include/linux/kstate.h
@@ -97,6 +97,7 @@ enum kstate_ids {
 	KSTATE_KHO_FDT_ID,
 	KSTATE_TEST_ID,
 	KSTATE_TEST_ID_V2,
+	KSTATE_RESERVED_MEM_ID,
 	KSTATE_LAST_ID = -1,
 };
 
diff --git a/mm/memblock.c b/mm/memblock.c
index 6af0b51b1bb7..b9d84d1ffd83 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -14,11 +14,13 @@
 #include <linux/pfn.h>
 #include <linux/debugfs.h>
 #include <linux/kmemleak.h>
+#include <linux/kstate.h>
 #include <linux/seq_file.h>
 #include <linux/memblock.h>
 #include <linux/mutex.h>
 
 #ifdef CONFIG_KEXEC_HANDOVER
+#include <linux/crc32.h>
 #include <linux/libfdt.h>
 #include <linux/kexec_handover.h>
 #endif /* CONFIG_KEXEC_HANDOVER */
@@ -2498,140 +2500,76 @@ int reserve_mem_release_by_name(const char *name)
 }
 
 #ifdef CONFIG_KEXEC_HANDOVER
-#define MEMBLOCK_KHO_FDT "memblock"
-#define MEMBLOCK_KHO_NODE_COMPATIBLE "memblock-v1"
-#define RESERVE_MEM_KHO_NODE_COMPATIBLE "reserve-mem-v1"
-
-static int __init prepare_kho_fdt(void)
-{
-	int err = 0, i;
-	struct page *fdt_page;
-	void *fdt;
-
-	fdt_page = alloc_page(GFP_KERNEL);
-	if (!fdt_page)
-		return -ENOMEM;
-
-	fdt = page_to_virt(fdt_page);
-
-	err |= fdt_create(fdt, PAGE_SIZE);
-	err |= fdt_finish_reservemap(fdt);
-
-	err |= fdt_begin_node(fdt, "");
-	err |= fdt_property_string(fdt, "compatible", MEMBLOCK_KHO_NODE_COMPATIBLE);
-	for (i = 0; i < reserved_mem_count; i++) {
-		struct reserve_mem_table *map = &reserved_mem_table[i];
-
-		err |= kho_preserve_phys(map->start, map->size);
-		err |= fdt_begin_node(fdt, map->name);
-		err |= fdt_property_string(fdt, "compatible", RESERVE_MEM_KHO_NODE_COMPATIBLE);
-		err |= fdt_property(fdt, "start", &map->start, sizeof(map->start));
-		err |= fdt_property(fdt, "size", &map->size, sizeof(map->size));
-		err |= fdt_end_node(fdt);
-	}
-	err |= fdt_end_node(fdt);
-	err |= fdt_finish(fdt);
-
-	err |= kho_preserve_folio(page_folio(fdt_page));
-	err |= kho_add_subtree(MEMBLOCK_KHO_FDT, fdt);
-
-	if (err) {
-		pr_err("failed to prepare memblock FDT for KHO: %d\n", err);
-		put_page(fdt_page);
-	}
-
-	return err;
-}
+static int kstate_preserve_phys(struct kstate_stream *stream, void *obj,
+				const struct kstate_field *field)
+{
+	struct reserve_mem_table *map = obj;
+
+	return kho_preserve_phys(map->start, map->size);
+}
+
+struct kstate_description kstate_reserve_mem = {
+	.name = "reserved_mem",
+	.id = KSTATE_RESERVED_MEM_ID,
+	.fields = (const struct kstate_field[]) {
+		KSTATE_BASE_TYPE(name, struct reserve_mem_table,
+				char[RESERVE_MEM_NAME_SIZE]),
+		KSTATE_BASE_TYPE(start, struct reserve_mem_table, phys_addr_t),
+		KSTATE_BASE_TYPE(size, struct reserve_mem_table, phys_addr_t),
+		{
+			.name = "phys_range",
+			.flags = KS_CUSTOM,
+			.save = kstate_preserve_phys,
+		},
+		KSTATE_END_OF_LIST(),
+	},
+};
 
 static int __init reserve_mem_init(void)
 {
 	int err;
+	int i;
 
 	if (!kho_is_enabled() || !reserved_mem_count)
 		return 0;
 
-	err = prepare_kho_fdt();
-	if (err)
-		return err;
-	return err;
-}
-late_initcall(reserve_mem_init);
-
-static void *__init reserve_mem_kho_retrieve_fdt(void)
-{
-	phys_addr_t fdt_phys;
-	static void *fdt;
-	int err;
-
-	if (fdt)
-		return fdt;
-
-	err = kho_retrieve_subtree(MEMBLOCK_KHO_FDT, &fdt_phys);
-	if (err) {
-		if (err != -ENOENT)
-			pr_warn("failed to retrieve FDT '%s' from KHO: %d\n",
-				MEMBLOCK_KHO_FDT, err);
-		return NULL;
-	}
-
-	fdt = phys_to_virt(fdt_phys);
+	for (i = 0; i < reserved_mem_count; i++) {
+		struct reserve_mem_table *map = &reserved_mem_table[i];
 
-	err = fdt_node_check_compatible(fdt, 0, MEMBLOCK_KHO_NODE_COMPATIBLE);
-	if (err) {
-		pr_warn("FDT '%s' is incompatible with '%s': %d\n",
-			MEMBLOCK_KHO_FDT, MEMBLOCK_KHO_NODE_COMPATIBLE, err);
-		fdt = NULL;
+		err = kstate_register(&kstate_reserve_mem,
+				map, crc32(~0, map->name, RESERVE_MEM_NAME_SIZE));
+		if (err)
+			goto out;
 	}
-
-	return fdt;
+out:
+	return err;
 }
+late_initcall(reserve_mem_init);
 
 static bool __init reserve_mem_kho_revive(const char *name, phys_addr_t size,
 					  phys_addr_t align)
 {
-	int err, len_start, len_size, offset;
-	const phys_addr_t *p_start, *p_size;
-	const void *fdt;
+	struct reserve_mem_table *map = &reserved_mem_table[reserved_mem_count];
 
-	fdt = reserve_mem_kho_retrieve_fdt();
-	if (!fdt)
+	if (kstate_restore(&kstate_reserve_mem, map,
+				crc32(~0, name, RESERVE_MEM_NAME_SIZE)))
 		return false;
 
-	offset = fdt_subnode_offset(fdt, 0, name);
-	if (offset < 0) {
-		pr_warn("FDT '%s' has no child '%s': %d\n",
-			MEMBLOCK_KHO_FDT, name, offset);
-		return false;
-	}
-	err = fdt_node_check_compatible(fdt, offset, RESERVE_MEM_KHO_NODE_COMPATIBLE);
-	if (err) {
-		pr_warn("Node '%s' is incompatible with '%s': %d\n",
-			name, RESERVE_MEM_KHO_NODE_COMPATIBLE, err);
+	if (map->start & (align - 1)) {
+		pr_warn("KHO reserve-mem '%s' has wrong alignment (0x%pa, 0x%pa)\n",
+			name, &align, &map->start);
 		return false;
 	}
 
-	p_start = fdt_getprop(fdt, offset, "start", &len_start);
-	p_size = fdt_getprop(fdt, offset, "size", &len_size);
-	if (!p_start || len_start != sizeof(*p_start) || !p_size ||
-	    len_size != sizeof(*p_size)) {
+	if (map->size != size) {
+		pr_warn("KHO reserve-mem '%s' has wrong size (0x%pa != 0x%pa)\n",
+			name, &map->size, &size);
 		return false;
 	}
 
-	if (*p_start & (align - 1)) {
-		pr_warn("KHO reserve-mem '%s' has wrong alignment (0x%lx, 0x%lx)\n",
-			name, (long)align, (long)*p_start);
-		return false;
-	}
-
-	if (*p_size != size) {
-		pr_warn("KHO reserve-mem '%s' has wrong size (0x%lx != 0x%lx)\n",
-			name, (long)*p_size, (long)size);
-		return false;
-	}
-
-	reserved_mem_add(*p_start, size, name);
-	pr_info("Revived memory reservation '%s' from KHO\n", name);
-
+	pr_info("Revived memory reservation '%s' %pa %pa from KHO\n",
+		name, &map->start, &map->size);
+	reserved_mem_count++;
 	return true;
 }
 #else
-- 
2.49.1


