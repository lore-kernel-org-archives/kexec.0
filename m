Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A566C4829E
	for <kexec@archiver.kernel.org>; Thu, 15 Feb 2024 08:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=29NCQKn3JRu3pNcR90NxeUPUddpRIxa1vniHhHZf6O4=; b=1BmIZhRbD9g+n1
	OKIZcJp8n3rqy/YKYmhH7wbwM+1SgoSOnjtM0k9JZHCVPJ7cS1wvcZlulSRALxI2x5GN8+fcrdadh
	DfjJK++bSA6AiPr8807pnpzo/rK7OgeimXlxLhW60k4Drlo6VqBTk0rii0BEt2nbwgFMKo5TUr/mT
	zAyHTXJRCVj2gPZob+7UYHBU494LeOKalKfOMw0KlRirZTktvWc7B2KYS+hHpgSz/n0Y8iNgWmn4H
	J4/pQv5AmAs+U+c8GrO/upwtnov7kSupUdMXp6ybrxXS5L5voEt933Ew1p+qMcnWoH8xQrD6M+DT3
	1laTb07O4RpmtXrxk2Lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raWo2-0000000FICm-2yN2;
	Thu, 15 Feb 2024 08:09:18 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raWnz-0000000FIBk-1YiJ
	for kexec@lists.infradead.org;
	Thu, 15 Feb 2024 08:09:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B68CCCE23F5
	for <kexec@lists.infradead.org>; Thu, 15 Feb 2024 08:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02EAC433B2
	for <kexec@lists.infradead.org>; Thu, 15 Feb 2024 08:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707984552;
	bh=iBhxtYQbpLfj3dlhxKI2geTS1BtCu4ErK/UQ/65GC9k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nihSTvYX3PqYfrp/Bdhm3OFoEXqstCjlXeLvJFPhV0bn04Gh5frQzRdTQFYuObeJN
	 FLs0y9nCyK06w+AgV8Mw2r5om9Vq1XLDrQrAdIZIawj2AYmScZD1TFkHrgcBzPQSKi
	 whkNmIjS9L4MswGi/Np4BkbqIUWwGn1gO7AZRj9BScBxPdsKcaSeGzD6cFC+4bfT7I
	 qpcmKEgXeLzPJswzqgZBbsDgqNXtHwfnHgz7xTMJ6X8PHyOx/dOFUwYipqeFuBm3Wf
	 3lA/1QZNJnjx4kcNQfjAv2lOqRDj2+LF6KcFMaQn3/zAeEWdRTMt/YltHpfGmZkRRG
	 scj1PwuNN3d8w==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5118d65cf9cso691668e87.0
        for <kexec@lists.infradead.org>; Thu, 15 Feb 2024 00:09:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVRCgBIw5cW4V8gKhawuXe0YPFOVzNYADBFLAJk0lczpwY0BRBeHuxnCJLrB4Mx7mfz88yQ1cGhOTsTjJGtIDgkv7bXEgKC9Cc1
X-Gm-Message-State: AOJu0Yy/PpiGGIhYBcXvrozyiQNFF8WrAQLKatg2saBEamwZLATMifoL
	Tyt24ypz6iuC370GHaS0J1C9dG//FarwW4D3WRYx8cqG7u7vFdEo8ZV/yEOhlfl3mJHPp+68plI
	x3nO2EBhX0z6MHrtfuUXHJ6c+wRY=
X-Google-Smtp-Source: AGHT+IES5dFR/dEUVlJWfvtf3xciPB+7NHzjXGklMH5tK3nkOBEGAVCil/5i8S6vDeDjj+8Wg38DPkb9JJN4ATkctI0=
X-Received: by 2002:a05:6512:e98:b0:511:ac21:57db with SMTP id
 bi24-20020a0565120e9800b00511ac2157dbmr936557lfb.0.1707984550864; Thu, 15 Feb
 2024 00:09:10 -0800 (PST)
MIME-Version: 1.0
References: <20240214221847.2066632-1-ross.philipson@oracle.com> <20240214221847.2066632-5-ross.philipson@oracle.com>
In-Reply-To: <20240214221847.2066632-5-ross.philipson@oracle.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 15 Feb 2024 09:08:59 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGaMfUAR85jpeS2JxcmWBbpkzroCVZOtwa3WDQwStDjMw@mail.gmail.com>
Message-ID: <CAMj1kXGaMfUAR85jpeS2JxcmWBbpkzroCVZOtwa3WDQwStDjMw@mail.gmail.com>
Subject: Re: [PATCH v8 04/15] x86: Secure Launch Resource Table header file
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, dpsmith@apertussolutions.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, kanth.ghatraju@oracle.com, 
	trenchboot-devel@googlegroups.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240215_000915_791608_F79ACCF4 
X-CRM114-Status: GOOD (  26.08  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, 14 Feb 2024 at 23:31, Ross Philipson <ross.philipson@oracle.com> wrote:
>
> Introduce the Secure Launch Resource Table which forms the formal
> interface between the pre and post launch code.
>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  include/linux/slr_table.h | 270 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 270 insertions(+)
>  create mode 100644 include/linux/slr_table.h
>
> diff --git a/include/linux/slr_table.h b/include/linux/slr_table.h
> new file mode 100644
> index 000000000000..42020988233a
> --- /dev/null
> +++ b/include/linux/slr_table.h
> @@ -0,0 +1,270 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Secure Launch Resource Table
> + *
> + * Copyright (c) 2023, Oracle and/or its affiliates.
> + */
> +
> +#ifndef _LINUX_SLR_TABLE_H
> +#define _LINUX_SLR_TABLE_H
> +
> +/* Put this in efi.h if it becomes a standard */
> +#define SLR_TABLE_GUID                         EFI_GUID(0x877a9b2a, 0x0385, 0x45d1, 0xa0, 0x34, 0x9d, 0xac, 0x9c, 0x9e, 0x56, 0x5f)
> +
> +/* SLR table header values */
> +#define SLR_TABLE_MAGIC                0x4452544d
> +#define SLR_TABLE_REVISION     1
> +
> +/* Current revisions for the policy and UEFI config */
> +#define SLR_POLICY_REVISION            1
> +#define SLR_UEFI_CONFIG_REVISION       1
> +
> +/* SLR defined architectures */
> +#define SLR_INTEL_TXT          1
> +#define SLR_AMD_SKINIT         2
> +
> +/* SLR defined bootloaders */
> +#define SLR_BOOTLOADER_INVALID 0
> +#define SLR_BOOTLOADER_GRUB    1
> +
> +/* Log formats */
> +#define SLR_DRTM_TPM12_LOG     1
> +#define SLR_DRTM_TPM20_LOG     2
> +
> +/* DRTM Policy Entry Flags */
> +#define SLR_POLICY_FLAG_MEASURED       0x1
> +#define SLR_POLICY_IMPLICIT_SIZE       0x2
> +
> +/* Array Lengths */
> +#define TPM_EVENT_INFO_LENGTH          32
> +#define TXT_VARIABLE_MTRRS_LENGTH      32
> +
> +/* Tags */
> +#define SLR_ENTRY_INVALID      0x0000
> +#define SLR_ENTRY_DL_INFO      0x0001
> +#define SLR_ENTRY_LOG_INFO     0x0002
> +#define SLR_ENTRY_ENTRY_POLICY 0x0003
> +#define SLR_ENTRY_INTEL_INFO   0x0004
> +#define SLR_ENTRY_AMD_INFO     0x0005
> +#define SLR_ENTRY_ARM_INFO     0x0006
> +#define SLR_ENTRY_UEFI_INFO    0x0007
> +#define SLR_ENTRY_UEFI_CONFIG  0x0008
> +#define SLR_ENTRY_END          0xffff
> +
> +/* Entity Types */
> +#define SLR_ET_UNSPECIFIED     0x0000
> +#define SLR_ET_SLRT            0x0001
> +#define SLR_ET_BOOT_PARAMS     0x0002
> +#define SLR_ET_SETUP_DATA      0x0003
> +#define SLR_ET_CMDLINE         0x0004
> +#define SLR_ET_UEFI_MEMMAP     0x0005
> +#define SLR_ET_RAMDISK         0x0006
> +#define SLR_ET_TXT_OS2MLE      0x0010
> +#define SLR_ET_UNUSED          0xffff
> +
> +#ifndef __ASSEMBLY__
> +
> +/*
> + * Primary SLR Table Header
> + */
> +struct slr_table {
> +       u32 magic;
> +       u16 revision;
> +       u16 architecture;
> +       u32 size;
> +       u32 max_size;
> +       /* entries[] */
> +} __packed;

Packing this struct has no effect on the layout so better drop the
__packed here. If this table is part of a structure that can appear
misaligned in memory, better to pack the outer struct or deal with it
there in another way.

> +
> +/*
> + * Common SLRT Table Header
> + */
> +struct slr_entry_hdr {
> +       u16 tag;
> +       u16 size;
> +} __packed;

Same here

> +
> +/*
> + * Boot loader context
> + */
> +struct slr_bl_context {
> +       u16 bootloader;
> +       u16 reserved;
> +       u64 context;
> +} __packed;
> +
> +/*
> + * DRTM Dynamic Launch Configuration
> + */
> +struct slr_entry_dl_info {
> +       struct slr_entry_hdr hdr;
> +       struct slr_bl_context bl_context;
> +       u64 dl_handler;

I noticed in the EFI patch that this is actually

void (*dl_handler)(struct slr_bl_context *bl_context);

so better declare it as such.

> +       u64 dce_base;
> +       u32 dce_size;
> +       u64 dlme_entry;
> +} __packed;
> +
> +/*
> + * TPM Log Information
> + */
> +struct slr_entry_log_info {
> +       struct slr_entry_hdr hdr;
> +       u16 format;
> +       u16 reserved;
> +       u64 addr;
> +       u32 size;
> +} __packed;
> +
> +/*
> + * DRTM Measurement Policy
> + */
> +struct slr_entry_policy {
> +       struct slr_entry_hdr hdr;
> +       u16 revision;
> +       u16 nr_entries;
> +       /* policy_entries[] */

Please use a flex array here:

  struct slr_policy_entry policy_entries[];

> +} __packed;
> +
> +/*
> + * DRTM Measurement Entry
> + */
> +struct slr_policy_entry {
> +       u16 pcr;
> +       u16 entity_type;
> +       u16 flags;
> +       u16 reserved;
> +       u64 entity;
> +       u64 size;
> +       char evt_info[TPM_EVENT_INFO_LENGTH];
> +} __packed;
> +
> +/*
> + * Secure Launch defined MTRR saving structures
> + */
> +struct slr_txt_mtrr_pair {
> +       u64 mtrr_physbase;
> +       u64 mtrr_physmask;
> +} __packed;
> +
> +struct slr_txt_mtrr_state {
> +       u64 default_mem_type;
> +       u64 mtrr_vcnt;
> +       struct slr_txt_mtrr_pair mtrr_pair[TXT_VARIABLE_MTRRS_LENGTH];
> +} __packed;
> +
> +/*
> + * Intel TXT Info table
> + */
> +struct slr_entry_intel_info {
> +       struct slr_entry_hdr hdr;
> +       u64 saved_misc_enable_msr;
> +       struct slr_txt_mtrr_state saved_bsp_mtrrs;
> +} __packed;
> +
> +/*
> + * AMD SKINIT Info table
> + */
> +struct slr_entry_amd_info {
> +       struct slr_entry_hdr hdr;
> +} __packed;
> +
> +/*
> + * ARM DRTM Info table
> + */
> +struct slr_entry_arm_info {
> +       struct slr_entry_hdr hdr;
> +} __packed;
> +

These two look preliminary, so better to drop them now and introduce
only once you know what they will look like.

> +struct slr_entry_uefi_config {
> +       struct slr_entry_hdr hdr;
> +       u16 revision;
> +       u16 nr_entries;
> +       /* uefi_cfg_entries[] */

Use a flex array

> +} __packed;
> +
> +struct slr_uefi_cfg_entry {
> +       u16 pcr;
> +       u16 reserved;
> +       u64 cfg; /* address or value */
> +       u32 size;
> +       char evt_info[TPM_EVENT_INFO_LENGTH];
> +} __packed;
> +
> +static inline void *slr_end_of_entrys(struct slr_table *table)

typo 'entrys' ?

> +{
> +       return (((void *)table) + table->size);

You can drop two sets of parens here

> +}
> +
> +static inline struct slr_entry_hdr *
> +slr_next_entry(struct slr_table *table,
> +              struct slr_entry_hdr *curr)
> +{
> +       struct slr_entry_hdr *next = (struct slr_entry_hdr *)
> +                               ((u8 *)curr + curr->size);
> +
> +       if ((void *)next >= slr_end_of_entrys(table))
> +               return NULL;
> +       if (next->tag == SLR_ENTRY_END)
> +               return NULL;
> +
> +       return next;
> +}
> +
> +static inline struct slr_entry_hdr *
> +slr_next_entry_by_tag(struct slr_table *table,
> +                     struct slr_entry_hdr *entry,
> +                     u16 tag)
> +{
> +       if (!entry) /* Start from the beginning */
> +               entry = (struct slr_entry_hdr *)(((u8 *)table) + sizeof(*table));
> +
> +       for ( ; ; ) {
> +               if (entry->tag == tag)
> +                       return entry;
> +
> +               entry = slr_next_entry(table, entry);
> +               if (!entry)
> +                       return NULL;
> +       }
> +
> +       return NULL;
> +}
> +
> +static inline int
> +slr_add_entry(struct slr_table *table,
> +             struct slr_entry_hdr *entry)
> +{
> +       struct slr_entry_hdr *end;
> +
> +       if ((table->size + entry->size) > table->max_size)
> +               return -1;
> +
> +       memcpy((u8 *)table + table->size - sizeof(*end), entry, entry->size);
> +       table->size += entry->size;
> +
> +       end  = (struct slr_entry_hdr *)((u8 *)table + table->size - sizeof(*end));
> +       end->tag = SLR_ENTRY_END;
> +       end->size = sizeof(*end);
> +
> +       return 0;
> +}
> +
> +static inline void
> +slr_init_table(struct slr_table *slrt, u16 architecture, u32 max_size)
> +{
> +       struct slr_entry_hdr *end;
> +
> +       slrt->magic = SLR_TABLE_MAGIC;
> +       slrt->revision = SLR_TABLE_REVISION;
> +       slrt->architecture = architecture;
> +       slrt->size = sizeof(*slrt) + sizeof(*end);
> +       slrt->max_size = max_size;
> +       end = (struct slr_entry_hdr *)((u8 *)slrt + sizeof(*slrt));
> +       end->tag = SLR_ENTRY_END;
> +       end->size = sizeof(*end);
> +}
> +
> +#endif /* !__ASSEMBLY */
> +
> +#endif /* _LINUX_SLR_TABLE_H */
> --
> 2.39.3
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
