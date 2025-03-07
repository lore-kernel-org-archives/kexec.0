Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC18C19F32
	for <kexec@archiver.kernel.org>; Fri,  7 Mar 2025 05:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+bCM3MWiZdx6cHnsogvssBP80SSWNFeytJyWSnAirXo=; b=qmDF+FI4dY66H4blfG6vvOkZVW
	qlqkzYKanpbKYunwTUINZ3zltp+eldgB9nb+cZkhqxvTpCkPDLY4eDi/50ZHR981W8xfCuCt6RgmC
	vpqQwqyQ2EyNu7fEVfbfXIvGQMoI82lCkCoLihP5fZD+Hm6pGLqHCJFZsgvQYekwo+AJ+qPuFPKMN
	4WYHjVm5+c5JAvNweF7XAzEQEHf3lWW1Y9giiHNjbP3PbodlY4kslONmcRLLz+ldYt8vEdOenzxNU
	Gbb5/VCWgAOYnb9dJsZANAaOE1vvwtMEwvXhYYaEQwXvjlb8KLnaS92VGpQN9AtiCsmV4MvMoS/ly
	SR4JyYMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqQJv-0000000DDW1-2otd;
	Fri, 07 Mar 2025 05:32:27 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqQJe-0000000DDQa-3cAk
	for kexec@lists.infradead.org;
	Fri, 07 Mar 2025 05:32:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 26A5BA454B2;
	Fri,  7 Mar 2025 05:26:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B960C4CED1;
	Fri,  7 Mar 2025 05:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741325529;
	bh=q/OGGBTCPmP4Udx/qeygD3cIJ2xnQNHrGdENR6SWJ/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IZ+lljTCxsj2RC3AiJcM+1C44pzG6kj6sIL8M9ApT74IXt2o7Zxf6rR8DOqeeltXH
	 sZvhmRU0yh0V+hw7mz1Cd4Oj423VvbMaDJ8xIN7qDfwr4kl9odHtvitat9IB6qy+pI
	 0p0R5gBoV9ROnGenLnQiNCUmBbzFT6vKV5OnBykkh5MGAgpjCp3KMy7hJ4nSuj22up
	 FFjYjmj68oyKK15hW23r5cqin3nB+oSTdy/or9sP6YQVz1eV5IxG4VOc50W+3MyVRK
	 v3mC7tkrrcaRogF8gftQqlNOSAwSsvFE0BXP/000lzqWOVYJpemUBnvie48nRAhNaT
	 9Y8OzTYP3Q4qw==
Date: Fri, 7 Mar 2025 07:32:04 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	ebiederm@xmission.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v12 03/19] x86: Secure Launch Resource Table header file
Message-ID: <Z8qE1B47InxE7n-v@kernel.org>
References: <20241219194216.152839-1-ross.philipson@oracle.com>
 <20241219194216.152839-4-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219194216.152839-4-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_213211_073954_BF1A6C09 
X-CRM114-Status: GOOD (  23.45  )
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

On Thu, Dec 19, 2024 at 11:42:00AM -0800, Ross Philipson wrote:
> Introduce the Secure Launch Resource Table which forms the formal
> interface between the pre and post launch code.
> 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

Is this interface kernel specific or uarch specific? I'd just
explicitly state the context of the formal interface, that's
all.

> ---
>  include/linux/slr_table.h | 277 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 277 insertions(+)
>  create mode 100644 include/linux/slr_table.h
> 
> diff --git a/include/linux/slr_table.h b/include/linux/slr_table.h
> new file mode 100644
> index 000000000000..48d85d505a50
> --- /dev/null
> +++ b/include/linux/slr_table.h
> @@ -0,0 +1,277 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * TrenchBoot Secure Launch Resource Table
> + *
> + * The Secure Launch Resource Table is TrenchBoot project defined
> + * specfication to provide cross-architecture compatibility. See
> + * TrenchBoot Secure Launch kernel documentation for details.
> + *
> + * Copyright (c) 2024 Apertus Solutions, LLC
> + * Copyright (c) 2024, Oracle and/or its affiliates.
> + */
> +
> +#ifndef _LINUX_SLR_TABLE_H
> +#define _LINUX_SLR_TABLE_H
> +
> +/* Put this in efi.h if it becomes a standard */
> +#define SLR_TABLE_GUID				EFI_GUID(0x877a9b2a, 0x0385, 0x45d1, 0xa0, 0x34, 0x9d, 0xac, 0x9c, 0x9e, 0x56, 0x5f)
> +
> +/* SLR table header values */
> +#define SLR_TABLE_MAGIC		0x4452544d
> +#define SLR_TABLE_REVISION	1
> +
> +/* Current revisions for the policy and UEFI config */
> +#define SLR_POLICY_REVISION		1
> +#define SLR_UEFI_CONFIG_REVISION	1
> +
> +/* SLR defined architectures */
> +#define SLR_INTEL_TXT		1
> +#define SLR_AMD_SKINIT		2
> +
> +/* SLR defined bootloaders */
> +#define SLR_BOOTLOADER_INVALID	0
> +#define SLR_BOOTLOADER_GRUB	1
> +
> +/* Log formats */
> +#define SLR_DRTM_TPM12_LOG	1
> +#define SLR_DRTM_TPM20_LOG	2
> +
> +/* DRTM Policy Entry Flags */
> +#define SLR_POLICY_FLAG_MEASURED	0x1
> +#define SLR_POLICY_IMPLICIT_SIZE	0x2
> +
> +/* Array Lengths */
> +#define TPM_EVENT_INFO_LENGTH		32
> +#define TXT_VARIABLE_MTRRS_LENGTH	32
> +
> +/* Tags */
> +#define SLR_ENTRY_INVALID	0x0000
> +#define SLR_ENTRY_DL_INFO	0x0001
> +#define SLR_ENTRY_LOG_INFO	0x0002
> +#define SLR_ENTRY_ENTRY_POLICY	0x0003
> +#define SLR_ENTRY_INTEL_INFO	0x0004
> +#define SLR_ENTRY_AMD_INFO	0x0005
> +#define SLR_ENTRY_ARM_INFO	0x0006
> +#define SLR_ENTRY_UEFI_INFO	0x0007
> +#define SLR_ENTRY_UEFI_CONFIG	0x0008
> +#define SLR_ENTRY_END		0xffff
> +
> +/* Entity Types */
> +#define SLR_ET_UNSPECIFIED	0x0000
> +#define SLR_ET_SLRT		0x0001
> +#define SLR_ET_BOOT_PARAMS	0x0002
> +#define SLR_ET_SETUP_DATA	0x0003
> +#define SLR_ET_CMDLINE		0x0004
> +#define SLR_ET_UEFI_MEMMAP	0x0005
> +#define SLR_ET_RAMDISK		0x0006
> +#define SLR_ET_TXT_OS2MLE	0x0010
> +#define SLR_ET_UNUSED		0xffff
> +
> +#ifndef __ASSEMBLY__
> +
> +/*
> + * Primary Secure Launch Resource Table Header
> + */
> +struct slr_table {
> +	u32 magic;
> +	u16 revision;
> +	u16 architecture;
> +	u32 size;
> +	u32 max_size;
> +	/* table entries */
> +} __packed;
> +
> +/*
> + * Common SLRT Table Header
> + */
> +struct slr_entry_hdr {
> +	u32 tag;
> +	u32 size;
> +} __packed;
> +
> +/*
> + * Boot loader context
> + */
> +struct slr_bl_context {
> +	u16 bootloader;
> +	u16 reserved[3];
> +	u64 context;
> +} __packed;
> +
> +/*
> + * Dynamic Launch Callback Function type
> + */
> +typedef void (*dl_handler_func)(struct slr_bl_context *bl_context);
> +
> +/*
> + * DRTM Dynamic Launch Configuration
> + */
> +struct slr_entry_dl_info {
> +	struct slr_entry_hdr hdr;
> +	u64 dce_size;
> +	u64 dce_base;
> +	u64 dlme_size;
> +	u64 dlme_base;
> +	u64 dlme_entry;
> +	struct slr_bl_context bl_context;
> +	u64 dl_handler;
> +} __packed;
> +
> +/*
> + * TPM Log Information
> + */
> +struct slr_entry_log_info {
> +	struct slr_entry_hdr hdr;
> +	u16 format;
> +	u16 reserved;
> +	u32 size;
> +	u64 addr;
> +} __packed;
> +
> +/*
> + * DRTM Measurement Entry
> + */
> +struct slr_policy_entry {
> +	u16 pcr;
> +	u16 entity_type;
> +	u16 flags;
> +	u16 reserved;
> +	u64 size;
> +	u64 entity;
> +	char evt_info[TPM_EVENT_INFO_LENGTH];
> +} __packed;
> +
> +/*
> + * DRTM Measurement Policy
> + */
> +struct slr_entry_policy {
> +	struct slr_entry_hdr hdr;
> +	u16 reserved[2];
> +	u16 revision;
> +	u16 nr_entries;
> +	struct slr_policy_entry policy_entries[];
> +} __packed;
> +
> +/*
> + * Secure Launch defined MTRR saving structures
> + */
> +struct slr_txt_mtrr_pair {
> +	u64 mtrr_physbase;
> +	u64 mtrr_physmask;
> +} __packed;
> +
> +struct slr_txt_mtrr_state {
> +	u64 default_mem_type;
> +	u64 mtrr_vcnt;
> +	struct slr_txt_mtrr_pair mtrr_pair[TXT_VARIABLE_MTRRS_LENGTH];
> +} __packed;
> +
> +/*
> + * Intel TXT Info table
> + */
> +struct slr_entry_intel_info {
> +	struct slr_entry_hdr hdr;
> +	u64 boot_params_addr;
> +	u64 txt_heap;
> +	u64 saved_misc_enable_msr;
> +	struct slr_txt_mtrr_state saved_bsp_mtrrs;
> +} __packed;
> +
> +/*
> + * UEFI config measurement entry
> + */
> +struct slr_uefi_cfg_entry {
> +	u16 pcr;
> +	u16 reserved;
> +	u32 size;
> +	u64 cfg; /* address or value */
> +	char evt_info[TPM_EVENT_INFO_LENGTH];
> +} __packed;
> +
> +/*
> + * UEFI config measurements
> + */
> +struct slr_entry_uefi_config {
> +	struct slr_entry_hdr hdr;
> +	u16 reserved[2];
> +	u16 revision;
> +	u16 nr_entries;
> +	struct slr_uefi_cfg_entry uefi_cfg_entries[];
> +} __packed;
> +
> +static inline void *slr_end_of_entries(struct slr_table *table)

I'd document these functions. No need to go over the top here i.e.,
no need to have full parameter descriptions but more like

/*
 * Tell a short description.
 */

> +{
> +	return (void *)table + table->size;
> +}
> +
> +static inline void *
> +slr_next_entry(struct slr_table *table,
> +	       struct slr_entry_hdr *curr)
> +{
> +	struct slr_entry_hdr *next = (struct slr_entry_hdr *)((u8 *)curr + curr->size);
> +
> +	if ((void *)next >= slr_end_of_entries(table))
> +		return NULL;
> +	if (next->tag == SLR_ENTRY_END)
> +		return NULL;
> +
> +	return next;
> +}
> +
> +static inline void *
> +slr_next_entry_by_tag(struct slr_table *table,
> +		      struct slr_entry_hdr *entry,
> +		      u16 tag)
> +{
> +	if (!entry) /* Start from the beginning */
> +		entry = (struct slr_entry_hdr *)(((u8 *)table) + sizeof(*table));
> +
> +	for ( ; ; ) {
> +		if (entry->tag == tag)
> +			return entry;
> +
> +		entry = slr_next_entry(table, entry);
> +		if (!entry)
> +			return NULL;
> +	}
> +
> +	return NULL;
> +}
> +
> +static inline int
> +slr_add_entry(struct slr_table *table,
> +	      struct slr_entry_hdr *entry)
> +{
> +	struct slr_entry_hdr *end;
> +
> +	if ((table->size + entry->size) > table->max_size)
> +		return -1;
> +
> +	memcpy((u8 *)table + table->size - sizeof(*end), entry, entry->size);
> +	table->size += entry->size;
> +
> +	end  = (struct slr_entry_hdr *)((u8 *)table + table->size - sizeof(*end));
> +	end->tag = SLR_ENTRY_END;
> +	end->size = sizeof(*end);
> +
> +	return 0;
> +}
> +
> +static inline void
> +slr_init_table(struct slr_table *slrt, u16 architecture, u32 max_size)

E.g., what does slr_init_table() do and why and when it is called. Basic
shit.

> +{
> +	struct slr_entry_hdr *end;
> +
> +	slrt->magic = SLR_TABLE_MAGIC;
> +	slrt->revision = SLR_TABLE_REVISION;
> +	slrt->architecture = architecture;
> +	slrt->size = sizeof(*slrt) + sizeof(*end);
> +	slrt->max_size = max_size;
> +	end = (struct slr_entry_hdr *)((u8 *)slrt + sizeof(*slrt));
> +	end->tag = SLR_ENTRY_END;
> +	end->size = sizeof(*end);
> +}
> +
> +#endif /* !__ASSEMBLY */
> +
> +#endif /* _LINUX_SLR_TABLE_H */
> -- 
> 2.39.3
> 

BR, Jarkko

