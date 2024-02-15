Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E54C4829E
	for <kexec@archiver.kernel.org>; Thu, 15 Feb 2024 09:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F7BXjB584das8Gx8Ar4SuFX98rlFnI/Ti4mhOo5WM6U=; b=qUod6EXxim+9qL
	U+JT622HYrOxOgd60f8N+GFOb3VBM28gPhyXXzjOvJ3Oq1N99twWm5ezNNbQbCpYkj5RW7hVsrJbS
	jfgQGUY/2xYimIje7/bk/Lm+CwoMHHjIx169z3reE2Wl5+1kVVsZVZRXgoQc2uCc2VLyaMKW9IYql
	odTZB093qkja1SdQdfsdtdIMJS4+hoWoFzOUswS1RpLqJNfmWjtIB//AFpFr3UiedlEhFeiYwdfT1
	Qbmvg8rdrqkxwPjmOVQGmfhAMmS89inQgckRyJNPJk/qrRKVWd0bCcRZSYCVJFwdOkbJCrJilQfPB
	3FOlNcSy5rH9LKNPnlRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raXcU-0000000FT1Y-18kt;
	Thu, 15 Feb 2024 09:01:26 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raXcQ-0000000FSzd-1b04
	for kexec@lists.infradead.org;
	Thu, 15 Feb 2024 09:01:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id BB595CE2582
	for <kexec@lists.infradead.org>; Thu, 15 Feb 2024 09:01:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35644C43142
	for <kexec@lists.infradead.org>; Thu, 15 Feb 2024 09:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707987677;
	bh=SiUIHayVYcHe9bkFxdrXvjU/ru0D8DtTz59xRaJtJBY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d03AaO80PMznAQ1ygGgl4bP0JD/qWg8lwUAYD+Cd0KOAbgw27sPii/DOLCtE9wDv7
	 kgjhC5bdEAdt+IPU9T9VwDKHOmfzmcl/NVCU5ed4BO78QZjSy9MOH3YX6y49OcHyT0
	 nqkOvzjulchPTBi1+5V9FTsIiarwJANjG+ZTThceD2MUbOALEivnzP6D57dXeKgzLM
	 VWgtPxQ13aFGJmFZYynLjEZ/zZcdFnFTNe+L4X1YXFlHVSm9v/RLHNr5SVYYaUrbAJ
	 3e4+THnFEVAhZ+kaFSSbZETU2qEWz2cPDi0kWcg3Wrqd7ZAOO/3iGWcgUZK+i6bCs8
	 POayKDFk0TKow==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-511a04c837bso711454e87.0
        for <kexec@lists.infradead.org>; Thu, 15 Feb 2024 01:01:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUc/ToGJH0oEUtWDwyX/XcqvjG9eNrdaMS5VwVRpGRZ9kHHobEZZS/zV8eIwoctPNsxG/6hEBGuMKBZt7kJg0r2n7zMuhguLKMi
X-Gm-Message-State: AOJu0Yxv89xr7F3ykksW0ZVsbAh24v0EMzrf2fKOJ2gG/bp8QKsEvnd2
	7M9HXocLCoH1SwutcXjICNldADgyg5pMys6AoBvP8wcSZDhnSwfCL1pAH6/J5foXHAwMH91O/yU
	Qr4OW4EAwcQoYgOiDuHuNrlyTUY8=
X-Google-Smtp-Source: AGHT+IESsSC82ZPO7zHm75aViouaK3gACXPSL8wbxHFLyvmlDJHekLM2uaQ5vnuSYH17EGhdPcRUbgpXLJsKGUFiH2M=
X-Received: by 2002:ac2:4946:0:b0:511:6ec9:d380 with SMTP id
 o6-20020ac24946000000b005116ec9d380mr904187lfi.30.1707987675245; Thu, 15 Feb
 2024 01:01:15 -0800 (PST)
MIME-Version: 1.0
References: <20240214221847.2066632-1-ross.philipson@oracle.com> <20240214221847.2066632-16-ross.philipson@oracle.com>
In-Reply-To: <20240214221847.2066632-16-ross.philipson@oracle.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 15 Feb 2024 10:01:03 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF3k_c4Wn9GU+NC_+_aYfDpAzAUnfR=A4L_T+re1H3G=w@mail.gmail.com>
Message-ID: <CAMj1kXF3k_c4Wn9GU+NC_+_aYfDpAzAUnfR=A4L_T+re1H3G=w@mail.gmail.com>
Subject: Re: [PATCH v8 15/15] x86: EFI stub DRTM launch support for Secure Launch
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
X-CRM114-CacheID: sfid-20240215_010122_802594_7EE7695E 
X-CRM114-Status: GOOD (  25.69  )
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

On Wed, 14 Feb 2024 at 23:32, Ross Philipson <ross.philipson@oracle.com> wrote:
>
> This support allows the DRTM launch to be initiated after an EFI stub
> launch of the Linux kernel is done. This is accomplished by providing
> a handler to jump to when a Secure Launch is in progress. This has to be
> called after the EFI stub does Exit Boot Services.
>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  drivers/firmware/efi/libstub/x86-stub.c | 55 +++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 0d510c9a06a4..4df2cf539194 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -9,6 +9,7 @@
>  #include <linux/efi.h>
>  #include <linux/pci.h>
>  #include <linux/stddef.h>
> +#include <linux/slr_table.h>
>
>  #include <asm/efi.h>
>  #include <asm/e820/types.h>
> @@ -810,6 +811,57 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
>         return EFI_SUCCESS;
>  }
>
> +static void efi_secure_launch(struct boot_params *boot_params)
> +{
> +       struct slr_entry_uefi_config *uefi_config;
> +       struct slr_uefi_cfg_entry *uefi_entry;
> +       struct slr_entry_dl_info *dlinfo;
> +       efi_guid_t guid = SLR_TABLE_GUID;
> +       struct slr_table *slrt;
> +       u64 memmap_hi;
> +       void *table;
> +       u8 buf[64] = {0};
> +

If you add a flex array to slr_entry_uefi_config as I suggested in
response to the other patch, we could simplify this substantially

static struct slr_entry_uefi_config cfg = {
        .hdr.tag        = SLR_ENTRY_UEFI_CONFIG,
        .hdr.size       = sizeof(cfg),
        .revision       = SLR_UEFI_CONFIG_REVISION,
        .nr_entries     = 1,
        .entries[0]     = {
                .pcr    = 18,
                .evt_info = "Measured UEFI memory map",
        },
};

cfg.entries[0].cfg  = boot_params->efi_info.efi_memmap |
                      (u64)boot_params->efi_info.efi_memmap_hi << 32;
cfg.entries[0].size = boot_params->efi_info.efi_memmap_size;



> +       table = get_efi_config_table(guid);
> +
> +       /*
> +        * The presence of this table indicated a Secure Launch
> +        * is being requested.
> +        */
> +       if (!table)
> +               return;
> +
> +       slrt = (struct slr_table *)table;
> +
> +       if (slrt->magic != SLR_TABLE_MAGIC)
> +               return;
> +

slrt = (struct slr_table *)get_efi_config_table(guid);
if (!slrt || slrt->magic != SLR_TABLE_MAGIC)
        return;

> +       /* Add config information to measure the UEFI memory map */
> +       uefi_config = (struct slr_entry_uefi_config *)buf;
> +       uefi_config->hdr.tag = SLR_ENTRY_UEFI_CONFIG;
> +       uefi_config->hdr.size = sizeof(*uefi_config) + sizeof(*uefi_entry);
> +       uefi_config->revision = SLR_UEFI_CONFIG_REVISION;
> +       uefi_config->nr_entries = 1;
> +       uefi_entry = (struct slr_uefi_cfg_entry *)(buf + sizeof(*uefi_config));
> +       uefi_entry->pcr = 18;
> +       uefi_entry->cfg = boot_params->efi_info.efi_memmap;
> +       memmap_hi = boot_params->efi_info.efi_memmap_hi;
> +       uefi_entry->cfg |= memmap_hi << 32;
> +       uefi_entry->size = boot_params->efi_info.efi_memmap_size;
> +       memcpy(&uefi_entry->evt_info[0], "Measured UEFI memory map",
> +               strlen("Measured UEFI memory map"));
> +

Drop all of this

> +       if (slr_add_entry(slrt, (struct slr_entry_hdr *)uefi_config))

if (slr_add_entry(slrt, &uefi_config.hdr))


> +               return;
> +
> +       /* Jump through DL stub to initiate Secure Launch */
> +       dlinfo = (struct slr_entry_dl_info *)
> +               slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_DL_INFO);
> +
> +       asm volatile ("jmp *%%rax"
> +                     : : "a" (dlinfo->dl_handler), "D" (&dlinfo->bl_context));

Fix the prototype and just do

dlinfo->dl_handler(&dlinfo->bl_context);
unreachable();


So in summary, this becomes

static void efi_secure_launch(struct boot_params *boot_params)
{
        static struct slr_entry_uefi_config cfg = {
                .hdr.tag        = SLR_ENTRY_UEFI_CONFIG,
                .hdr.size       = sizeof(cfg),
                .revision       = SLR_UEFI_CONFIG_REVISION,
                .nr_entries     = 1,
                .entries[0]     = {
                        .pcr    = 18,
                        .evt_info = "Measured UEFI memory map",
                },
        };
        struct slr_entry_dl_info *dlinfo;
        efi_guid_t guid = SLR_TABLE_GUID;
        struct slr_table *slrt;

        /*
         * The presence of this table indicated a Secure Launch
         * is being requested.
         */
        slrt = (struct slr_table *)get_efi_config_table(guid);
        if (!slrt || slrt->magic != SLR_TABLE_MAGIC)
                return;

        cfg.entries[0].cfg  = boot_params->efi_info.efi_memmap |
                              (u64)boot_params->efi_info.efi_memmap_hi << 32;
        cfg.entries[0].size = boot_params->efi_info.efi_memmap_size;

        if (slr_add_entry(slrt, &cfg.hdr))
                return;

        /* Jump through DL stub to initiate Secure Launch */
        dlinfo = (struct slr_entry_dl_info *)
                 slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_DL_INFO);

        dlinfo->dl_handler(&dlinfo->bl_context);

        unreachable();
}


> +}
> +
>  static void __noreturn enter_kernel(unsigned long kernel_addr,
>                                     struct boot_params *boot_params)
>  {
> @@ -934,6 +986,9 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
>                 goto fail;
>         }
>
> +       /* If a Secure Launch is in progress, this never returns */

if (IS_ENABLED(CONFIG_SECURE_LAUNCH))

> +       efi_secure_launch(boot_params);
> +
>         /*
>          * Call the SEV init code while still running with the firmware's
>          * GDT/IDT, so #VC exceptions will be handled by EFI.
> --
> 2.39.3
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
