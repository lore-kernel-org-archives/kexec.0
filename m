Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2E7CD4851
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 21:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f4K56Y7dB3RpP0PwvxsPRXyN2MFU4pj7XmWxeU528To=; b=AzFR/75IdZCrK62RlEKoUGGY3M
	h2i4Jp6GGFKT5CQM1Z9JHmzNvCwP8sIuGiAELyBrqG03MkLtXWvdXU+IZSVCyceQQFEIa0bnLLpZB
	+dXj0Es2geDJDAHvZekB9P/GPGoFO2yHzoFoMD0UrlNXzPzEe4rCT7KpufmZrJudjVckIkxT/5IS4
	CWlz2FYdzR5fNEp6QQINzYwqocVdMWJYtkTD0h8fDzdtXjamR4Wp/PwPPv0syZZTiB1SWl8JhvPjT
	u0LMkJNKgXv8SAsGEzOp0E1RIpvVL7EnmSq96AOJI2lBEMCMSgX4aWzmhpF+IOxvN2TpfV+CFnPbB
	DPHhMaHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzsI-00000009TgN-0cVl;
	Fri, 15 May 2026 21:15:14 +0000
Received: from mail-dy1-x132e.google.com ([2607:f8b0:4864:20::132e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzsE-00000009TdM-2dTt
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 21:15:12 +0000
Received: by mail-dy1-x132e.google.com with SMTP id 5a478bee46e88-2f30a4601bbso285051eec.1
        for <kexec@lists.infradead.org>; Fri, 15 May 2026 14:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879710; x=1779484510; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4K56Y7dB3RpP0PwvxsPRXyN2MFU4pj7XmWxeU528To=;
        b=kTklYeW0X/SS8/9U3l7Hp72hQ11faCAAwokOuhhxGK2R8ZDJo4Lkx7k8E+Sa1CB3U5
         SlaiAYfgPAitrUWrWQwB4sbKYdILJDgUhX6rNmAGyaOapOMSJnTqZ8FDshBuSSwobrx7
         DBSNG3I4DnVPqCaHrIwNbx+EeCR3vPUn8wscjwqKI1JC8rYP/l9PhBp6eidW7jezN8Ol
         ZI49soxbZvWoIgLOrUp083oS/Bace0iNJ08LPly3Z5Z+1xkOFrIaed9ROMJ8fuULI4Ei
         JXobmLIoZ98w3P3eQyhXZkaLVemCgg0mjFClTRkkGZs9K8LwKFbRSu/7D4WrcsR7bnK5
         heeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879710; x=1779484510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f4K56Y7dB3RpP0PwvxsPRXyN2MFU4pj7XmWxeU528To=;
        b=AXhzzlNpKsFquD81FqhOlLPD6xRtC0ydHUkc5mSjyFD87Rg6yTNyIJBNosvzO/6x3W
         WxHyfMWTRbap43IIlIMrcU8QZVDLTW/yBXessC6HnArpCH3pvJD5RdlUyBXvYj+HHlEa
         tcX7DtKEhtPm8nRf8p54sh8yklAuuoIN48RXlQBp1H+tW5fy4C3i8s3ovrUxD0S0V0HB
         qEzmyiHCfNp9FtBLeyOsexhHZHLjhNfBeQ1mhYxfIVwqWq8519k1s8XFIcnl5qJKDc1e
         WoYdpR1hjxwxQQEBrAD38yZVd0qDh026x7dquyq7vR9ny8T9F3U5+X4WiQDPLfRlYnKp
         hDig==
X-Forwarded-Encrypted: i=1; AFNElJ+DmIZh/rpbdDRNugJI8gRo4mzO5ZIj5NlOv2sE8p2K+WYwSfZmhRdVYLPGJZKZabc0BfC3IA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxHEnx3fzvalxVXMcbcMWS7mMr+XT2sjPQO4w/ejpG1+M+q91e/
	Fxz0BiYiAd/DOHcok7e9ybdI+ab712McaQOgipfIhsuEzw8Z+e0vOedH
X-Gm-Gg: Acq92OF0ZEHgi5ug/YyBXqO8qhW+Aij9TH3OI/AzF3bv8oafV9wMsIqtQDVsyw6/hja
	v2k6t7V99LSeljoeMuoauxU81Iu6c8sLGZOw0mf0LZc+qiVDmZk3CGwXPXwsxK+PHMVnGWsFaz9
	BvDMLvj4u+kBi1/dgWD2JZNzKQsQPaJH9/j/As30+FkuUxIvKvRZYcu2909UdW3qpKSunL67k89
	xayzy9YYnxPxrZzE7co4peC0ULBQUu5j9Hb80SLQbHBwuV5qgCzjWkgNVW/AOZ3gynb3uogTnWM
	rgFyg6p7iI8vmzNfittW1dWnWX6Q0L9N9u6bO0lYTJJhJpMxa6GANxJS/bQoirJZLp6fPfRz2GU
	4mkf6jahBGKK9a/HAJiIiz7GpcHo4BvoMaogyOyeXF7qkXg1ZFq5Ceb55a/2BqphCMfdc4hzQym
	t6H1kMoNe4HoNcghnzcDbmhHIjPq4iEFw=
X-Received: by 2002:a05:7301:688:b0:2e2:5bc5:f8eb with SMTP id 5a478bee46e88-303982c04demr2937773eec.9.1778879709562;
        Fri, 15 May 2026 14:15:09 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bbd50sm7962080eec.20.2026.05.15.14.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:09 -0700 (PDT)
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
Subject: [PATCH v16 20/38] x86/txt: Intel Trusted eXecution Technology (TXT) definitions
Date: Fri, 15 May 2026 14:13:52 -0700
Message-ID: <20260515211410.31440-21-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_141510_680395_D0C12696 
X-CRM114-Status: GOOD (  19.09  )
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

Intel TXT architectural specific definitions. See the specification
for detailed information:

https://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-txt-software-development-guide.pdf

Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/include/asm/txt.h | 281 +++++++++++++++++++++++++++++++++++++
 1 file changed, 281 insertions(+)
 create mode 100644 arch/x86/include/asm/txt.h

diff --git a/arch/x86/include/asm/txt.h b/arch/x86/include/asm/txt.h
new file mode 100644
index 000000000000..eaec915d4878
--- /dev/null
+++ b/arch/x86/include/asm/txt.h
@@ -0,0 +1,281 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Intel Trusted eXecution Technology (TXT) Definitions
+ *
+ * Copyright (c) 2026 Apertus Solutions, LLC
+ * Copyright (c) 2026, Oracle and/or its affiliates.
+ */
+
+#ifndef _ASM_X86_TXT_H
+#define _ASM_X86_TXT_H
+
+/*
+ * Intel Safer Mode Extensions (SMX)
+ *
+ * Intel SMX provides a programming interface to establish a Measured Launched
+ * Environment (MLE). The measurement and protection mechanisms are supported by the
+ * capabilities of an Intel Trusted Execution Technology (TXT) platform. SMX is
+ * the processor's programming interface in an Intel TXT platform.
+ *
+ * See:
+ *   Intel SDM Volume 2 - 6.1 "Safer Mode Extensions Reference"
+ *   Intel Trusted Execution Technology - Measured Launch Environment Developer's Guide
+ */
+
+/*
+ * SMX GETSEC Leaf Functions
+ */
+#define SMX_X86_GETSEC_SEXIT	5
+#define SMX_X86_GETSEC_SMCTRL	7
+#define SMX_X86_GETSEC_WAKEUP	8
+
+/*
+ * Intel Trusted Execution Technology MMIO Registers Banks
+ */
+#define TXT_PUB_CONFIG_REGS_BASE	0xfed30000
+#define TXT_PRIV_CONFIG_REGS_BASE	0xfed20000
+#define TXT_NR_CONFIG_PAGES     ((TXT_PUB_CONFIG_REGS_BASE - \
+				  TXT_PRIV_CONFIG_REGS_BASE) >> PAGE_SHIFT)
+
+/*
+ * Intel Trusted Execution Technology (TXT) Registers
+ */
+#define TXT_CR_STS			0x0000
+#define TXT_CR_ESTS			0x0008
+#define TXT_CR_ERRORCODE		0x0030
+#define TXT_CR_CMD_RESET		0x0038
+#define TXT_CR_CMD_CLOSE_PRIVATE	0x0048
+#define TXT_CR_DIDVID			0x0110
+#define TXT_CR_VER_EMIF			0x0200
+#define TXT_CR_CMD_UNLOCK_MEM_CONFIG	0x0218
+#define TXT_CR_SINIT_BASE		0x0270
+#define TXT_CR_SINIT_SIZE		0x0278
+#define TXT_CR_MLE_JOIN			0x0290
+#define TXT_CR_HEAP_BASE		0x0300
+#define TXT_CR_HEAP_SIZE		0x0308
+#define TXT_CR_SCRATCHPAD		0x0378
+#define TXT_CR_CMD_OPEN_LOCALITY1	0x0380
+#define TXT_CR_CMD_CLOSE_LOCALITY1	0x0388
+#define TXT_CR_CMD_OPEN_LOCALITY2	0x0390
+#define TXT_CR_CMD_CLOSE_LOCALITY2	0x0398
+#define TXT_CR_CMD_SECRETS		0x08e0
+#define TXT_CR_CMD_NO_SECRETS		0x08e8
+#define TXT_CR_E2STS			0x08f0
+
+/* TXT default register value */
+#define TXT_REGVALUE_ONE		0x1ULL
+
+/* TXTCR_STS status bits */
+#define TXT_SENTER_DONE_STS		BIT(0)
+#define TXT_SEXIT_DONE_STS		BIT(1)
+
+/*
+ * SINIT/MLE Capabilities Field Bit Definitions
+ */
+#define TXT_SINIT_MLE_CAP_RLP_WAKE_GETSEC	0
+#define TXT_SINIT_MLE_CAP_RLP_WAKE_MONITOR	1
+
+/*
+ * OS/MLE Secure Launch Specific Definitions
+ */
+#define TXT_OS_MLE_STRUCT_VERSION	1
+#define TXT_OS_MLE_MAX_VARIABLE_MTRRS	32
+
+#ifndef __ASSEMBLER__
+
+/*
+ * TXT Heap extended data elements.
+ */
+struct txt_heap_ext_data_element {
+	u32 type;
+	u32 size;
+	/* Data */
+} __packed;
+
+#define TXT_HEAP_EXTDATA_TYPE_END			0
+
+struct txt_heap_end_element {
+	u32 type;
+	u32 size;
+} __packed;
+
+#define TXT_HEAP_EXTDATA_TYPE_TPM_EVENT_LOG_PTR		5
+
+struct txt_heap_event_log_element {
+	u64 event_log_phys_addr;
+} __packed;
+
+#define TXT_HEAP_EXTDATA_TYPE_EVENT_LOG_POINTER2_1	8
+
+struct txt_heap_event_log_pointer2_1_element {
+	u64 phys_addr;
+	u32 allocated_event_container_size;
+	u32 first_record_offset;
+	u32 next_record_offset;
+} __packed;
+
+/*
+ * TXT specification defined BIOS data TXT Heap table
+ */
+struct txt_bios_data {
+	u32 version; /* Currently 5 for TPM 1.2 and 6 for TPM 2.0 */
+	u32 bios_sinit_size;
+	u64 reserved1;
+	u64 reserved2;
+	u32 num_logical_procs;
+	u32 sinit_flags;
+	u32 mle_flags;
+	/* Versions >= 5 with updates in version 6 */
+	/* Ext Data Elements */
+} __packed;
+
+/*
+ * TXT specification defined OS/SINIT TXT Heap table
+ */
+struct txt_os_sinit_data {
+	u32 version; /* Currently 6 for TPM 1.2 and 7 for TPM 2.0 */
+	u32 flags;
+	u64 mle_ptab;
+	u64 mle_size;
+	u64 mle_hdr_base;
+	u64 vtd_pmr_lo_base;
+	u64 vtd_pmr_lo_size;
+	u64 vtd_pmr_hi_base;
+	u64 vtd_pmr_hi_size;
+	u64 lcp_po_base;
+	u64 lcp_po_size;
+	u32 capabilities;
+	/* Version = 5 */
+	u64 efi_rsdt_ptr;
+	/* Versions >= 6 */
+	/* Ext Data Elements */
+} __packed;
+
+/*
+ * TXT specification defined SINIT/MLE TXT Heap table
+ */
+struct txt_sinit_mle_data {
+	u32 version;             /* Current values are 6 through 9 */
+	/* Versions <= 8 */
+	u8 bios_acm_id[20];
+	u32 edx_senter_flags;
+	u64 mseg_valid;
+	u8 sinit_hash[20];
+	u8 mle_hash[20];
+	u8 stm_hash[20];
+	u8 lcp_policy_hash[20];
+	u32 lcp_policy_control;
+	/* Versions >= 7 */
+	u32 rlp_wakeup_addr;
+	u32 reserved;
+	u32 num_of_sinit_mdrs;
+	u32 sinit_mdrs_table_offset;
+	u32 sinit_vtd_dmar_table_size;
+	u32 sinit_vtd_dmar_table_offset;
+	/* Versions >= 8 */
+	u32 processor_scrtm_status;
+	/* Versions >= 9 */
+	/* Ext Data Elements */
+} __packed;
+
+/*
+ * TXT data reporting structure for memory types
+ */
+struct txt_sinit_memory_descriptor_record {
+	u64 address;
+	u64 length;
+	u8 type;
+	u8 reserved[7];
+} __packed;
+
+/*
+ * TXT data structure used by a responsive local processor (RLP) to start
+ * execution in response to a GETSEC[WAKEUP].
+ */
+struct smx_rlp_mle_join {
+	u32 rlp_gdt_limit;
+	u32 rlp_gdt_base;
+	u32 rlp_seg_sel;     /* cs (ds, es, ss are seg_sel+8) */
+	u32 rlp_entry_point; /* phys addr */
+} __packed;
+
+/*
+ * TPM event log structures defined in both the TXT specification and
+ * the TCG documentation.
+ */
+#define TPM_EVTLOG_SIGNATURE "TXT Event Container"
+
+struct tpm_event_log_header {
+	char signature[20];
+	char reserved[12];
+	u8 container_ver_major;
+	u8 container_ver_minor;
+	u8 pcr_event_ver_major;
+	u8 pcr_event_ver_minor;
+	u32 container_size;
+	u32 pcr_events_offset;
+	u32 next_event_offset;
+	/* PCREvents[] */
+} __packed;
+
+/*
+ * Functions to extract data from the Intel TXT Heap Memory. The layout
+ * of the heap is as follows:
+ *  +----------------------------+
+ *  | Size Bios Data table (u64) |
+ *  +----------------------------+
+ *  | Bios Data table            |
+ *  +----------------------------+
+ *  | Size OS MLE table (u64)    |
+ *  +----------------------------+
+ *  | OS MLE table               |
+ *  +--------------------------- +
+ *  | Size OS SINIT table (u64)  |
+ *  +----------------------------+
+ *  | OS SINIT table             |
+ *  +----------------------------+
+ *  | Size SINIT MLE table (u64) |
+ *  +----------------------------+
+ *  | SINIT MLE table            |
+ *  +----------------------------+
+ *
+ *  NOTE: the table size fields include the 8 byte size field itself.
+ */
+enum {
+	TXT_BIOS_DATA_TABLE,
+	TXT_OS_MLE_DATA_TABLE,
+	TXT_OS_SINIT_DATA_TABLE,
+	TXT_SINIT_MLE_DATA_TABLE,
+	TXT_SINIT_TABLE_MAX,
+};
+
+/*
+ * Find the TPM v2 event log element in the TXT heap. This element contains
+ * the information about the size and location of the DRTM event log. Note
+ * this is a TXT specific structure.
+ *
+ * See:
+ *   Intel Trusted Execution Technology -
+ *     Measured Launch Environment Developer's Guide - Appendix C.
+ */
+static inline struct txt_heap_event_log_pointer2_1_element*
+txt_find_log2_1_element(struct txt_os_sinit_data *os_sinit_data)
+{
+#define ptr_after(p)     ((void *)p + sizeof(*p))
+#define next_ext_elem(e) ((void *)e + e->size)
+	/* The extended element array is at the end of this table */
+	struct txt_heap_ext_data_element *ext_elem = ptr_after(os_sinit_data);
+
+	while (ext_elem->type != TXT_HEAP_EXTDATA_TYPE_END) {
+		if (ext_elem->type == TXT_HEAP_EXTDATA_TYPE_EVENT_LOG_POINTER2_1)
+			return ptr_after(ext_elem);
+
+		ext_elem = next_ext_elem(ext_elem);
+	}
+
+	return NULL;
+}
+
+#endif /* !__ASSEMBLER__ */
+
+#endif /* _ASM_X86_TXT_H */
-- 
2.47.3


