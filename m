Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C55C5DF7E
	for <kexec@archiver.kernel.org>; Tue, 18 Aug 2026 12:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Message-Id:Subject:From:Cc:Content-Type:References:In-Reply-To:Mime-Version:
	To:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=voy1G8RTst2hSKEANM9MbjdPwKrg6PLW9nAM6rBvm4A=; b=teDLFuP/TNcV+tDpwNwQGt79j+
	A0YBJdUu4IrjRSEjkPnjS9lJTJHoclUtRJXaPhqs0yi70cTqYbeW4kiwbIR5YFggUzIVeb62TK+Pe
	2cAxF2qtp2L/1WxpXAK/+ND4w73lmgOFqzRrSR0prgA+xbQ/8BNKU+g6AA/PVu4qddCzOISRNSh2d
	Dfje7VV0V6Hzv4OLj0a1P9MgJb80fVRw43Tt2Uj//NVjzCZOZb7sxMxD/AKuNusOus0uniBQnF/sB
	y9ngzW8JVDyWrc8lJ77rGgv/Mw2OBRpPXKoAsRghLSKOwolQDZMTeZqsaQYI5nxPUIhxcx3oVNr15
	iEHp4qPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwJ2h-00000007wBj-0ObT;
	Tue, 18 Aug 2026 12:35:47 +0000
Received: from va-1-114.ptr.blmpb.com ([209.127.230.114])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwJ2e-00000007w9f-14Gm
	for kexec@lists.infradead.org;
	Tue, 18 Aug 2026 12:35:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1787056539; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=voy1G8RTst2hSKEANM9MbjdPwKrg6PLW9nAM6rBvm4A=;
 b=hrbTIWIXP/ZIrYZrn/e5S8sDQC2G4xo+My/oksf2k9bsdHV5Ak4bVP+Sb5ivL/skNwswPq
 Lm/gIekIGPRGVb0Ju+9B8ociwURSHxHhm77vvo6MdghiVZ1lH3JhirwLDzbXbxpxTVMc9f
 KlRvSyGzL8NR83Y2J+s+F55LfngWVvQVVliBGYz4eTCcmbJ9n4KejETaTrsA5bUnkME0rk
 G7VDpfgHuvxvjiD4NKJamQF0W+4d2IV0M3TbiJSpiokV9lgEkU3U6TRdF98wTivBgr+m2V
 wxBxy6Psxx371TxBxY+mW3KfokrGDta4TJHPDxGo+M2arTfTHfZFbo7o5OKoJQ==
Date: Tue, 18 Aug 2026 20:35:07 +0800
To: <kexec@lists.infradead.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a845199+dcf050+lists.infradead.org+qirui.001@bytedance.com>
In-Reply-To: <20260818123504.12022-4-qirui.001@bytedance.com>
References: <20260818123504.12022-4-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.52.0
Content-Type: text/plain; charset=UTF-8
Cc: <horms@kernel.org>, <linux-riscv@lists.infradead.org>, 
	"Rui Qi" <qirui.001@bytedance.com>
From: "Rui Qi" <qirui.001@bytedance.com>
Subject: [PATCH 2/2] RISC-V: Pass all crash kernel ranges to crash kernel
Message-Id: <20260818123504.12022-6-qirui.001@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Original-From: Rui Qi <qirui.001@bytedance.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260818_053544_375006_6ABD435A 
X-CRM114-Status: GOOD (  20.85  )
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

RISC-V kexec-tools records all Crash kernel ranges from /proc/iomem,
but the kexec_load path still writes only get_crash_kernel_load_range()
to linux,usable-memory-range. On systems with split crash kernel
reservations, this hides the low reservation from the crash kernel
after boot.

Keep the crash image segments in the selected load range, since that
is the range where the panic kernel may be loaded. Build
linux,usable-memory-range from all crash kernel ranges instead, placing
the selected load range first and then appending the remaining ranges.

This follows the model already used by arm64 kexec-tools for split
crash kernel reservations: pass linux,usable-memory-range = <BASE1
SIZE1 BASE2 SIZE2> to the crash dump kernel so the main/high range can
hold the crash image while the low range is still advertised to the
crash kernel for use after boot.

This also matches the split-reservation handoff model used by the
kernel kexec_file_load path: the crash kernel image is loaded into the
main range, while low reserved memory is still made available to the
crash kernel after boot.

Tested on riscv64 with a 128 MiB low reservation and a 1760 MiB high
reservation. After a panic, the crash kernel reported both ranges as
System RAM in /proc/iomem and kdump completed successfully.

Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 kexec/arch/riscv/crashdump-riscv.c | 14 ++++++++
 kexec/arch/riscv/kexec-riscv.c     | 35 +++++++++++++++++--
 kexec/arch/riscv/kexec-riscv.h     |  1 +
 kexec/dt-ops.c                     | 55 ++++++++++++++++++++++++------
 kexec/dt-ops.h                     |  5 ++-
 5 files changed, 96 insertions(+), 14 deletions(-)

diff --git a/kexec/arch/riscv/crashdump-riscv.c b/kexec/arch/riscv/crashdump-riscv.c
index deb9a49cd48d..8a09fbafd63e 100644
--- a/kexec/arch/riscv/crashdump-riscv.c
+++ b/kexec/arch/riscv/crashdump-riscv.c
@@ -210,3 +210,17 @@ int get_crash_kernel_load_range(uint64_t *start, uint64_t *end)
 
 	return 0;
 }
+
+int get_crash_kernel_ranges(struct memory_range **ranges, int *nr_ranges)
+{
+	if (!crash_mem_ranges.size)
+		kexec_iomem_for_each_line(NULL, iomem_range_callback, NULL);
+
+	if (!crash_mem_ranges.size)
+		return -1;
+
+	*ranges = crash_mem_ranges.ranges;
+	*nr_ranges = crash_mem_ranges.size;
+
+	return 0;
+}
diff --git a/kexec/arch/riscv/kexec-riscv.c b/kexec/arch/riscv/kexec-riscv.c
index 3a13f90ea70c..d357f1b779e5 100644
--- a/kexec/arch/riscv/kexec-riscv.c
+++ b/kexec/arch/riscv/kexec-riscv.c
@@ -111,6 +111,8 @@ int load_extra_segments(struct kexec_info *info, uint64_t kernel_base,
 			uint64_t kernel_size, uint64_t max_addr)
 {
 	struct fdt_image *fdt = arch_options.fdt;
+	struct memory_range *crash_ranges = NULL;
+	struct memory_range *usable_ranges = NULL;
 	char *initrd_buf = NULL;
 	off_t initrd_size = 0;
 	uint64_t initrd_base = 0;
@@ -118,7 +120,10 @@ int load_extra_segments(struct kexec_info *info, uint64_t kernel_base,
 	uint64_t end = 0;
 	uint64_t min_usable = kernel_base + kernel_size;
 	uint64_t max_usable = max_addr;
+	int nr_crash_ranges = 0;
+	int nr_usable_ranges = 0;
 	int ret = 0;
+	int i;
 
 	/* Prepare the device tree */
 	if (info->kexec_flags & KEXEC_ON_CRASH) {
@@ -142,8 +147,34 @@ int load_extra_segments(struct kexec_info *info, uint64_t kernel_base,
 			return ret;
 		}
 
-		ret = dtb_add_range_property(&fdt->buf, &fdt->size, start, end,
-					     "chosen", "linux,usable-memory-range");
+		ret = get_crash_kernel_ranges(&crash_ranges,
+					      &nr_crash_ranges);
+		if (ret) {
+			fprintf(stderr, "Couldn't get crashkernel regions\n");
+			return ret;
+		}
+
+		usable_ranges = xmalloc(nr_crash_ranges *
+					sizeof(*usable_ranges));
+		usable_ranges[nr_usable_ranges].start = start;
+		usable_ranges[nr_usable_ranges].end = end;
+		usable_ranges[nr_usable_ranges].type = RANGE_RAM;
+		nr_usable_ranges++;
+
+		for (i = 0; i < nr_crash_ranges; i++) {
+			if (crash_ranges[i].start == start &&
+			    crash_ranges[i].end == end)
+				continue;
+
+			usable_ranges[nr_usable_ranges++] = crash_ranges[i];
+		}
+
+		ret = dtb_add_range_properties(&fdt->buf, &fdt->size,
+					       usable_ranges,
+					       nr_usable_ranges,
+					       "chosen",
+					       "linux,usable-memory-range");
+		free(usable_ranges);
 		if (ret) {
 			fprintf(stderr, "Couldn't add usable-memory-range to fdt\n");
 			return ret;
diff --git a/kexec/arch/riscv/kexec-riscv.h b/kexec/arch/riscv/kexec-riscv.h
index f487b27c10bd..43b7ce14c374 100644
--- a/kexec/arch/riscv/kexec-riscv.h
+++ b/kexec/arch/riscv/kexec-riscv.h
@@ -32,6 +32,7 @@ struct riscv_opts {
 /* crashdump-riscv.c */
 extern struct memory_range elfcorehdr_mem;
 int load_elfcorehdr(struct kexec_info *info);
+int get_crash_kernel_ranges(struct memory_range **ranges, int *nr_ranges);
 
 /* kexec-riscv.c */
 int prepare_kexec_file_options(struct kexec_info *info);
diff --git a/kexec/dt-ops.c b/kexec/dt-ops.c
index 3e285ab2043b..6a8e598fed17 100644
--- a/kexec/dt-ops.c
+++ b/kexec/dt-ops.c
@@ -250,14 +250,32 @@ void dtb_fill_int_property(void *buf, uint64_t val, uint32_t cells)
 
 int dtb_add_range_property(char **dtb, off_t *dtb_size, uint64_t start, uint64_t end,
 			   const char *parent, const char *name)
+{
+	struct memory_range range;
+
+	range.start = start;
+	range.end = end;
+	range.type = RANGE_RAM;
+
+	return dtb_add_range_properties(dtb, dtb_size, &range, 1, parent, name);
+}
+
+int dtb_add_range_properties(char **dtb, off_t *dtb_size,
+			     const struct memory_range *ranges, int nr_ranges,
+			     const char *parent, const char *name)
 {
 	uint32_t addr_cells = 0;
 	uint32_t size_cells = 0;
 	char *nodepath = NULL;
 	void *prop = NULL;
+	uint32_t *range_prop = NULL;
 	int nodeoffset = 0;
 	int prop_size = 0;
 	int ret = 0;
+	int i;
+
+	if (nr_ranges <= 0)
+		return -EINVAL;
 
 	nodepath = malloc(strlen("/") + strlen(parent) + 1);
 	if (!nodepath) {
@@ -281,22 +299,37 @@ int dtb_add_range_property(char **dtb, off_t *dtb_size, uint64_t start, uint64_t
 	if (ret < 0)
 		return ret;
 
-	/* Can the range fit with the given address/size cells ? */
-	if ((addr_cells == 1) && (start >= (1ULL << 32)))
-		return -EINVAL;
+	for (i = 0; i < nr_ranges; i++) {
+		uint64_t start = ranges[i].start;
+		uint64_t size = ranges[i].end - ranges[i].start + 1;
 
-	if ((size_cells == 1) && ((end - start + 1) >= (1ULL << 32)))
-		return -EINVAL;
+		/* Can the range fit with the given address/size cells ? */
+		if ((addr_cells == 1) && (start >= (1ULL << 32)))
+			return -EINVAL;
+
+		if ((size_cells == 1) && (size >= (1ULL << 32)))
+			return -EINVAL;
+	}
 
-	prop_size = sizeof(uint32_t) * (addr_cells + size_cells);
-	prop = malloc(prop_size);
+	prop_size = sizeof(uint32_t) * (addr_cells + size_cells) * nr_ranges;
+	prop = xmalloc(prop_size);
+	memset(prop, 0, prop_size);
+	range_prop = prop;
 
-	dtb_fill_int_property(prop, start, addr_cells);
-	dtb_fill_int_property((void *)((uint32_t *)prop + addr_cells),
-			      end - start + 1, size_cells);
+	for (i = 0; i < nr_ranges; i++) {
+		dtb_fill_int_property(range_prop, ranges[i].start, addr_cells);
+		range_prop += addr_cells;
+		dtb_fill_int_property(range_prop,
+				      ranges[i].end - ranges[i].start + 1,
+				      size_cells);
+		range_prop += size_cells;
+	}
 
 	/* Add by node path name */
-	return dtb_set_property(dtb, dtb_size, parent, name, prop, prop_size);
+	ret = dtb_set_property(dtb, dtb_size, parent, name, prop, prop_size);
+	free(prop);
+
+	return ret;
 }
 
 /************************\
diff --git a/kexec/dt-ops.h b/kexec/dt-ops.h
index 3014205d8e98..349be3d09493 100644
--- a/kexec/dt-ops.h
+++ b/kexec/dt-ops.h
@@ -14,7 +14,10 @@ int dtb_delete_property(char *dtb, const char *node, const char *prop);
 void dtb_extract_int_property(uint64_t *val, const void *buf, uint32_t cells);
 void dtb_fill_int_property(void *buf, uint64_t val, uint32_t cells);
 int dtb_add_range_property(char **dtb, off_t *dtb_size, uint64_t start, uint64_t end,
-                           const char *node, const char* parent);
+			   const char *parent, const char *name);
+int dtb_add_range_properties(char **dtb, off_t *dtb_size,
+			     const struct memory_range *ranges, int nr_ranges,
+			     const char *parent, const char *name);
 int dtb_get_memory_ranges(char *dtb, struct memory_ranges *mem_ranges,
 			  struct memory_ranges *extra_ranges);
 
-- 
2.52.0

