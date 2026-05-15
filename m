Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BD6CD4851
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 21:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7H5BBOQhcOIL9Ie2ph8fKyZbD41fSwoTWiLEU5gST9s=; b=kyqDBNTnDIiZrA4WDTsQG//pjY
	JNqUDmROI9JXSn5XK0cFyIVECI2Dhz2ib6T759JgxkjGcn8IVQ4UlE1Pa5/D50wdlWnjy328vIOA1
	m7Uq4sW5sf4FO4nIuMtBRKB3MEvpLt6mLRA3LTTaR2kQr/xPZM8WuoskG2AmZ4nCpSi5BfYzrIM6G
	myzFqZhpyMnoawjYfTmn5d3ZE4dCwVo9WCdHNrlcz/ab7D9YOa7qTbR5R82ZtjzCuK/SW1GUgkCj2
	a6vnmapO0IzFBTADW6PDDONQVjC+hMg4Q6iy+rcDSvuIoTCDFyGaDmCQpV9FuSvZwL0/rcrDTPQZk
	r51iqzSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzsA-00000009TaY-1O9u;
	Fri, 15 May 2026 21:15:06 +0000
Received: from mail-dy1-x132b.google.com ([2607:f8b0:4864:20::132b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzs6-00000009TW0-0SBw
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 21:15:04 +0000
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-2ef8d6ba48bso106328eec.1
        for <kexec@lists.infradead.org>; Fri, 15 May 2026 14:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879701; x=1779484501; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7H5BBOQhcOIL9Ie2ph8fKyZbD41fSwoTWiLEU5gST9s=;
        b=npF1abLANnZjIogU6dgMewaVcfId7AF0Tz3wT2SNGPXmhkUZyZBXB/ujoZ1hDmwgCi
         WDrryZ70xpmSFetf1zpG1Tby4Pd13sTi51tQcqPH9pt53mm5Iv9E8y8G0xj+/AWPS/3h
         nddLKMD2o0ngvEItrN2yxkDs+Ww3RIIDAt4na+I3oIOC9oXSEY3vfE5l7E+FXjkF7KuJ
         UpkwLHd2LL2O2Hpe6+Rq8aGbVNaNJhWvbquAuIEqNvN+PBavGk4cd7qg1Zbw6QQnadfo
         94N0Zys5Xs15WyPjXylX3ot4BOOeKPVsrRhNMXv9Pxut0G6OEI6oQbMUs+STmU8H42zl
         StCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879701; x=1779484501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7H5BBOQhcOIL9Ie2ph8fKyZbD41fSwoTWiLEU5gST9s=;
        b=Q9TBQcDFAWwVplyPOrGFs3tS7rXcIbKC5kvtmc7Q6lP7TUUzRO/hRJvuQr/PGbOY98
         tl+28/1bbnHOi/f1M8+eMvKlnusa2Lb5Nl5LHQxKBx4EVVCGVJJwF7qNXH8Wn6TFEHIc
         PuntaeAr9jfxw8e7lV4baL3OxAKs/0uU7DDtm2myVfPNQQ5DdHDY13O77BNTWQ5Bfho4
         7VfOie4dEtjEtr0rXlmbWiTmBCLbZE23eaMlaaaONwIfU/2prNUsUWMouJuX9NPI+XIf
         2m8I7tjmE3IJ1gHK6ksH60Suj0OTZVrcZmsLjoDpUMgHwa4D599BmSvLALlgHuj7ztLI
         jSsw==
X-Forwarded-Encrypted: i=1; AFNElJ8Psz/TgMNmKeWM6WeAfmRrnCXtS725u8SH3snX0ALLG3jcBbvjI9XjGE5X9nKAo6cv2kB1wA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwhNliASAAodng29lqDQjsJP/Hgy2MPK9TQpyOHQq//VCBnFZnG
	m27jU78mk6IrZdxo+TjZFhUo66YApbxWv27RWVsPYs2yLve2md80Ag67
X-Gm-Gg: Acq92OHbz2gny1JvOCXkDFDxmqKHwll73JT7GCrl7SZ0J1sZMXQTxktApHM8EMNKttA
	AeVFIChsT8Tpjl4kB+SZpeL62360vHBH7d/ivDdbxURhu2g60n7qdlY77bO2b/SKX2xYbboPsXs
	cin18t2pios1laYMCOEAn2IZYboEy6Hk6hitZVyMfROFQQj3cqJx8IVVtJp0J5CAGAS5K0+4Bqg
	8C+EDiwjNsQOlQ8N+T9wK76u4AYSJZdV699qXqEoCHw55L16QW0bDKtG20XwSUCf/Lmz89H2orM
	pDEPIW1g8CtOstRB/LofCZAGUTlG6QTXXdeVic/MN0MORG82+CCfJ+d6D4Uc1586OL48/rvc/jH
	VkDWH9hfujs24lhYfC0zmPjiGDRoJAEZjfSzsKJ3gpLRIFv7HqeTzeqFg0iX3O5q0XZKPKUreB6
	U4IPtvwScpdBi/iK4tw75nvSt2+Wx2GCundZepemFPWg==
X-Received: by 2002:a05:7301:644b:b0:2d9:db50:c6ce with SMTP id 5a478bee46e88-3039785c4f8mr2519307eec.3.1778879701272;
        Fri, 15 May 2026 14:15:01 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302978b1a79sm8049096eec.28.2026.05.15.14.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:00 -0700 (PDT)
From: Ross Philipson <ross.philipson@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: ross.philipson@gmail.com,
	dpsmith@apertussolutions.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	luto@amacapital.net,
	nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	corbet@lwn.net,
	ebiederm@xmission.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com,
	andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: [PATCH v16 17/38] x86: Secure Launch Resource Table header file
Date: Fri, 15 May 2026 14:13:49 -0700
Message-ID: <20260515211410.31440-18-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_141502_193355_0ADB9D32 
X-CRM114-Status: GOOD (  23.04  )
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

The Secure Launch Specification is an architecture agnostic,
software neutral API/ABI maintained by the TrenchBoot project.
Its function is to allow any compliant boot loader to communicate
the pre-launch configuration to any compliant post-launch kernel.
The Secure Launch Resource Table, defined in the specification,
presents the programmatic interface for this API/ABI.

The specification can be found here:
https://github.com/TrenchBoot/documentation/blob/master/specifications/secure-launch-specification.rst

Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 include/linux/slr_table.h | 339 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 339 insertions(+)
 create mode 100644 include/linux/slr_table.h

diff --git a/include/linux/slr_table.h b/include/linux/slr_table.h
new file mode 100644
index 000000000000..2cc542121414
--- /dev/null
+++ b/include/linux/slr_table.h
@@ -0,0 +1,339 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * TrenchBoot Secure Launch Resource Table
+ *
+ * The Secure Launch Resource Table (SLRT) is a TrenchBoot project defined
+ * specification to provide a cross-platform interface/ABI between
+ * the Secure Launch components. While most of the table is platform
+ * agnostic, platform or architecture specific entries can be added.
+ *
+ * See TrenchBoot Secure Launch kernel documentation for details.
+ *
+ * Copyright (c) 2026 Apertus Solutions, LLC
+ * Copyright (c) 2026, Oracle and/or its affiliates.
+ */
+
+#ifndef _LINUX_SLR_TABLE_H
+#define _LINUX_SLR_TABLE_H
+
+/* SLR table header values */
+#define SLR_TABLE_MAGIC		0x4452544d
+#define SLR_TABLE_REVISION	1
+
+/* Current revisions for the policy and UEFI config */
+#define SLR_POLICY_REVISION		1
+#define SLR_UEFI_CONFIG_REVISION	1
+
+/* SLR defined architectures */
+#define SLR_INTEL_TXT		1
+#define SLR_AMD_SKINIT		2
+
+/* SLR defined bootloaders */
+#define SLR_BOOTLOADER_INVALID	0
+#define SLR_BOOTLOADER_GRUB	1
+
+/* Log formats */
+#define SLR_DRTM_TPM12_LOG	1
+#define SLR_DRTM_TPM20_LOG	2
+
+/* DRTM Policy Entry Flags */
+#define SLR_POLICY_FLAG_MEASURED	0x1
+#define SLR_POLICY_IMPLICIT_SIZE	0x2
+
+/* Array Lengths */
+#define TPM_EVENT_INFO_LENGTH		32
+#define TXT_VARIABLE_MTRRS_LENGTH	32
+
+/* Tags */
+#define SLR_ENTRY_INVALID	0x0000
+#define SLR_ENTRY_DL_INFO	0x0001
+#define SLR_ENTRY_LOG_INFO	0x0002
+#define SLR_ENTRY_ENTRY_POLICY	0x0003
+#define SLR_ENTRY_INTEL_INFO	0x0004
+#define SLR_ENTRY_AMD_INFO	0x0005
+#define SLR_ENTRY_ARM_INFO	0x0006
+#define SLR_ENTRY_UEFI_INFO	0x0007
+#define SLR_ENTRY_UEFI_CONFIG	0x0008
+#define SLR_ENTRY_END		0xffff
+
+/* Entity Types */
+#define SLR_ET_UNSPECIFIED	0x0000
+#define SLR_ET_SLRT		0x0001
+#define SLR_ET_BOOT_PARAMS	0x0002
+#define SLR_ET_SETUP_DATA	0x0003
+#define SLR_ET_CMDLINE		0x0004
+#define SLR_ET_UEFI_MEMMAP	0x0005
+#define SLR_ET_RAMDISK		0x0006
+#define SLR_ET_TXT_OS2MLE	0x0010
+#define SLR_ET_UNUSED		0xffff
+
+#ifndef __ASSEMBLER__
+
+/*
+ * Standard Secure Launch DLME header.
+ *
+ * All capable DRTM kernels must have an instance of this header.
+ * This header was derived from the Intel TXT Measured Launch
+ * Environment header and uses the predefined UUID:
+ *
+ * {5aac8290-6f47-a774-0f5c-55a2cb51b642}
+ */
+struct slr_dlme_header {
+	u32 uuid0; /* 9082AC5A */
+	u32 uuid1; /* 74A7476F */
+	u32 uuid2; /* A2555C0F */
+	u32 uuid3; /* 42B651CB */
+	u32 header_len;
+	u32 version;
+	u32 entry_point;
+	u32 first_valid_page;
+	u32 start;
+	u32 end;
+	u32 capabilities;
+	u32 cmdline_start;
+	u32 cmdline_end;
+} __packed;
+
+/*
+ * Primary Secure Launch Resource Table header
+ */
+struct slr_table {
+	u32 magic;
+	u16 revision;
+	u16 architecture;
+	u32 size;
+	u32 max_size;
+	/* table entries */
+} __packed;
+
+/*
+ * Common SLRT entry header
+ */
+struct slr_entry_hdr {
+	u32 tag;
+	u32 size;
+} __packed;
+
+/*
+ * Boot loader context and DLME setup
+ */
+struct slr_bl_context {
+	u16 bootloader;
+	u16 reserved[3];
+	u64 context;
+} __packed;
+
+struct slr_setup_dlme {
+	u64 dlme_base;
+	u64 dlme_header_offset;
+	u64 dlme_table;
+} __packed;
+
+/*
+ * Dynamic Launch Callback Function
+ */
+typedef void (*dl_launch_func)(struct slr_bl_context *bl_context,
+			       struct slr_setup_dlme *setup_dlme);
+
+/*
+ * DRTM Dynamic Launch Configuration
+ */
+struct slr_entry_dl_info {
+	struct slr_entry_hdr hdr;
+	u64 dce_size;
+	u64 dce_base;
+	u64 dlme_size;
+	u64 dlme_base;
+	u64 dlme_entry;
+	u64 dlme_header_offset;
+	u64 dlme_config_table;
+	struct slr_bl_context bl_context;
+	u64 dl_launch;
+} __packed;
+
+/*
+ * TPM Log Information
+ */
+struct slr_entry_log_info {
+	struct slr_entry_hdr hdr;
+	u16 format;
+	u16 reserved;
+	u32 size;
+	u64 addr;
+} __packed;
+
+/*
+ * DRTM Measurement Entry
+ */
+struct slr_policy_entry {
+	u16 pcr;
+	u16 entity_type;
+	u16 flags;
+	u16 reserved;
+	u64 size;
+	u64 entity;
+	char evt_info[TPM_EVENT_INFO_LENGTH];
+} __packed;
+
+/*
+ * DRTM Measurement Policy
+ */
+struct slr_entry_policy {
+	struct slr_entry_hdr hdr;
+	u16 reserved[2];
+	u16 revision;
+	u16 nr_entries;
+	struct slr_policy_entry policy_entries[];
+} __packed;
+
+/*
+ * Secure Launch defined MTRR saving structures
+ */
+struct slr_txt_mtrr_pair {
+	u64 mtrr_physbase;
+	u64 mtrr_physmask;
+} __packed;
+
+struct slr_txt_mtrr_state {
+	u64 default_mem_type;
+	u64 mtrr_vcnt;
+	struct slr_txt_mtrr_pair mtrr_pair[TXT_VARIABLE_MTRRS_LENGTH];
+} __packed;
+
+/*
+ * Intel TXT Info table
+ */
+struct slr_entry_intel_info {
+	struct slr_entry_hdr hdr;
+	u64 boot_params_addr;
+	u64 txt_heap;
+	u64 saved_misc_enable_msr;
+	struct slr_txt_mtrr_state saved_bsp_mtrrs;
+} __packed;
+
+/*
+ * UEFI config measurement entry
+ */
+struct slr_uefi_cfg_entry {
+	u16 pcr;
+	u16 reserved;
+	u32 size;
+	u64 cfg; /* address or value */
+	char evt_info[TPM_EVENT_INFO_LENGTH];
+} __packed;
+
+/*
+ * UEFI config measurements
+ */
+struct slr_entry_uefi_config {
+	struct slr_entry_hdr hdr;
+	u16 reserved[2];
+	u16 revision;
+	u16 nr_entries;
+	struct slr_uefi_cfg_entry uefi_cfg_entries[];
+} __packed;
+
+/*
+ * The SLRT is laid out as a Tag-Length-Value (TLV) data structure
+ * allowing a flexible number of entries in the table. An instance
+ * of the slr_table structure is present as a header at the beginning.
+ *
+ * The following functions help to manipulate the SLRT structure
+ * and contents.
+ */
+
+/*
+ * Return the address of the end of the SLRT past the final entry.
+ */
+static inline void *slr_end_of_entries(struct slr_table *table)
+{
+	return (void *)table + table->size;
+}
+
+/*
+ * Return the next entry in the SLRT given the current entry passed
+ * to the function. NULL is returned if there are no entries to return.
+ */
+static inline void *
+slr_next_entry(struct slr_table *table,
+	       struct slr_entry_hdr *curr)
+{
+	struct slr_entry_hdr *next = (struct slr_entry_hdr *)((u8 *)curr + curr->size);
+
+	if ((void *)next >= slr_end_of_entries(table))
+		return NULL;
+	if (next->tag == SLR_ENTRY_END)
+		return NULL;
+
+	return next;
+}
+
+/*
+ * Return the next entry with the given tag in the SLRT starting at the
+ * current entry. If entry is NULL, the search begins at the beginning of
+ * table.
+ */
+static inline void *
+slr_next_entry_by_tag(struct slr_table *table,
+		      struct slr_entry_hdr *entry,
+		      u16 tag)
+{
+	if (!entry) /* Start from the beginning */
+		entry = (struct slr_entry_hdr *)(((u8 *)table) + sizeof(*table));
+
+	for ( ; ; ) {
+		if (entry->tag == tag)
+			return entry;
+
+		entry = slr_next_entry(table, entry);
+		if (!entry)
+			return NULL;
+	}
+
+	return NULL;
+}
+
+/*
+ * Add an entry to the SLRT. Entries are placed at the end.
+ */
+static inline int
+slr_add_entry(struct slr_table *table,
+	      struct slr_entry_hdr *entry)
+{
+	struct slr_entry_hdr *end;
+
+	if ((table->size + entry->size) > table->max_size)
+		return -1;
+
+	memcpy((u8 *)table + table->size - sizeof(*end), entry, entry->size);
+	table->size += entry->size;
+
+	end = (struct slr_entry_hdr *)((u8 *)table + table->size - sizeof(*end));
+	end->tag = SLR_ENTRY_END;
+	end->size = sizeof(*end);
+
+	return 0;
+}
+
+/*
+ * Initialize the SLRT for use. This prepares the meta-data in the SLRT
+ * header section of the table and table end entry.
+ */
+static inline void
+slr_init_table(struct slr_table *slrt, u16 architecture, u32 max_size)
+{
+	struct slr_entry_hdr *end;
+
+	slrt->magic = SLR_TABLE_MAGIC;
+	slrt->revision = SLR_TABLE_REVISION;
+	slrt->architecture = architecture;
+	slrt->size = sizeof(*slrt) + sizeof(*end);
+	slrt->max_size = max_size;
+	end = (struct slr_entry_hdr *)((u8 *)slrt + sizeof(*slrt));
+	end->tag = SLR_ENTRY_END;
+	end->size = sizeof(*end);
+}
+
+#endif /* !__ASSEMBLER__ */
+
+#endif /* _LINUX_SLR_TABLE_H */
-- 
2.47.3


