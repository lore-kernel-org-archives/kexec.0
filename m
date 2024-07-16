Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B70C3DA59
	for <kexec@archiver.kernel.org>; Tue, 16 Jul 2024 15:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a6bwYRWzwFRab5eFuMMI5F651xnIUVGxbyrbxzRqxLI=; b=Pb19v1y8En4eFl
	0QkeodW16SkjBJILhuhBIrM+EUyerdIC94bDZrN+Nq9HkONr4QEzv5a8L/iZ5ULwTWFBxl2154fLx
	82/hHCdPKmM8U3m8vbfFfmfeBRReZmHNFRcqo1YF5i01U4D/2p+T1pH4G/ixfsRDexpXo95ixqG37
	3XlGpYiySkJ5OnM2y2lQUlKJ8P1U3uyCIDgpUZ9vmroNntIwsrQJG/a6Pw9PLkNfEeu/yEg0DhpTy
	fXoBTk/MxnsmmLJwjdyTLZ/lkcgczXhh7+cIljFomlw+suUABOFHRNVnVHlOAnzfqweTpoC8lB7Un
	72E32FkqQhrMFRnXIawA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTjvh-0000000Asz2-0x0E;
	Tue, 16 Jul 2024 15:17:25 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTjvc-0000000Asxk-3QYH
	for kexec@lists.infradead.org;
	Tue, 16 Jul 2024 15:17:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5365C61295
	for <kexec@lists.infradead.org>; Tue, 16 Jul 2024 15:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DE9C4AF48
	for <kexec@lists.infradead.org>; Tue, 16 Jul 2024 15:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721143038;
	bh=aPtkDon0fbJqih4uVR9A9V0XEADmRixC6/HZP3ixjcU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OStJuxMGNf9E4N7aPla00MkyLckmcowT/RVS9OvxJzZhsomXeQJQe7YsuInEbNfo/
	 3HkD/P5S8g1ogojfW4mnT7BbdW2jrbKbX24IiWzl4CW9mzxwSlCYO48AI0dkeUNI94
	 Ryfom9DbqAn2TLlSI9aEFtmZV/2pWYiC+B9PW6X80mqwjv7o6XlXB3jhUBHhfcAuvN
	 KcoI+Yh/ano29inhTp+T8STcGM1u6aqKcLFzgN3lRzEHmu34/6D4fAmsSPDpwC8QrE
	 667UJ1UpTX+hBQMUUfznT+4apeKrYmyaCEEhLr+mSAjq1Uqmfku1NKA/IRob9pMyMX
	 WxSjXAQYN+52g==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52ea5765e75so6850445e87.0
        for <kexec@lists.infradead.org>; Tue, 16 Jul 2024 08:17:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwkSSyvnGgx7R/aa0De87D9sykIqh7cW+ySURT+MeLcwLUVn8YWxFSrK+ju3Dv4tInHDo/c9NyZg7Vyjxfh3BFCGmQAtHC/7EZ
X-Gm-Message-State: AOJu0Yw+xspu3GJYr5m5UQNCkr1lOMpVbZQEIZfY7w0iu5LZqxEGjj1r
	dHtrzqt8kXi2gqTKSK7Xn0TR+gxWrSmVBB9gT8P8rEXg/7DIXJVINsRK3lqjKzzFoH8Gy/O/vt2
	W02uo01wHtwInGnrzAqRicKzdV44=
X-Google-Smtp-Source: AGHT+IFXMyRqVEuv0lOnARYZkpoy4q6bG9QB8sGhRLJi8OPsread22Hc+2bdOi+Zy5Y6+YCk5vlxTdBbCgvBP7y/N54=
X-Received: by 2002:a05:6512:b94:b0:52c:c032:538d with SMTP id
 2adb3069b0e04-52edf02300cmr1727066e87.27.1721143036612; Tue, 16 Jul 2024
 08:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240715185309.1637839-1-steve.wahl@hpe.com> <20240715185309.1637839-2-steve.wahl@hpe.com>
In-Reply-To: <20240715185309.1637839-2-steve.wahl@hpe.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 16 Jul 2024 08:17:02 -0700
X-Gmail-Original-Message-ID: <CAMj1kXF7SXvN=szKb=g8MSzLyLWy=Uozr0ps40zRUoajoeG6pQ@mail.gmail.com>
Message-ID: <CAMj1kXF7SXvN=szKb=g8MSzLyLWy=Uozr0ps40zRUoajoeG6pQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] x86/kexec: Add EFI config table identity mapping
 for kexec kernel
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	Pavin Joseph <me@pavinjoseph.com>, Eric Hagberg <ehagberg@gmail.com>, 
	Simon Horman <horms@verge.net.au>, Eric Biederman <ebiederm@xmission.com>, 
	Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>, Russ Anderson <rja@hpe.com>, 
	Dimitri Sivanich <sivanich@hpe.com>, Hou Wenlong <houwenlong.hwl@antgroup.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Yuntao Wang <ytcoode@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <jroedel@suse.de>, 
	Michael Roth <michael.roth@amd.com>, Tao Liu <ltao@redhat.com>, kexec@lists.infradead.org, 
	"Kalra, Ashish" <ashish.kalra@amd.com>, linux-efi@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240716_081721_014525_85C4D78E 
X-CRM114-Status: GOOD (  37.31  )
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

On Mon, 15 Jul 2024 at 11:53, Steve Wahl <steve.wahl@hpe.com> wrote:
>
> From: Tao Liu <ltao@redhat.com>
>
> A kexec kernel boot failure is sometimes observed on AMD CPUs due to
> an unmapped EFI config table array.  This can be seen when "nogbpages"
> is on the kernel command line, and has been observed as a full BIOS
> reboot rather than a successful kexec.
>
> This was also the cause of reported regressions attributed to Commit
> 7143c5f4cf20 ("x86/mm/ident_map: Use gbpages only where full GB page
> should be mapped.") which was subsequently reverted.
>
> To avoid this page fault, explicitly include the EFI config table
> array in the kexec identity map.
>
> Further explanation:
>
> The following 2 commits caused the EFI config table array to be
> accessed when enabling sev at kernel startup.
>
>     commit ec1c66af3a30 ("x86/compressed/64: Detect/setup SEV/SME features
>                           earlier during boot")
>     commit c01fce9cef84 ("x86/compressed: Add SEV-SNP feature
>                           detection/setup")
>
> This is in the code that examines whether SEV should be enabled or
> not, so it can even affect systems that are not SEV capable.
>
> This may result in a page fault if the EFI config table array's
> address is unmapped. Since the page fault occurs before the new kernel
> establishes its own identity map and page fault routines, it is
> unrecoverable and kexec fails.
>
> Most often, this problem is not seen because the EFI config table
> array gets included in the map by the luck of being placed at a memory
> address close enough to other memory areas that *are* included in the
> map created by kexec.
>
> Both the "nogbpages" command line option and the "use gpbages only
> where full GB page should be mapped" patch greatly reduce the chance
> of being included in the map by luck, which is why the problem
> appears.
>
> Signed-off-by: Tao Liu <ltao@redhat.com>
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> Tested-by: Pavin Joseph <me@pavinjoseph.com>
> Tested-by: Sarah Brofeldt <srhb@dbc.dk>
> Tested-by: Eric Hagberg <ehagberg@gmail.com>
> ---
>  arch/x86/kernel/machine_kexec_64.c | 35 ++++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index cc0f7f70b17b..563d119f9f29 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -28,6 +28,7 @@
>  #include <asm/setup.h>
>  #include <asm/set_memory.h>
>  #include <asm/cpu.h>
> +#include <asm/efi.h>
>
>  #ifdef CONFIG_ACPI
>  /*
> @@ -83,10 +84,12 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
>  #endif
>
>  static int
> -map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)

I think we can keep the name - the array of EFI config table
references could be considered part of the system table, even though
it may live in a separate allocation.

> +map_efi_tables(struct x86_mapping_info *info, pgd_t *level4p)
>  {
>  #ifdef CONFIG_EFI
>         unsigned long mstart, mend;
> +       void *kaddr;
> +       int ret;
>
>         if (!efi_enabled(EFI_BOOT))
>                 return 0;
> @@ -102,6 +105,30 @@ map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
>         if (!mstart)
>                 return 0;
>
> +       ret = kernel_ident_mapping_init(info, level4p, mstart, mend);
> +       if (ret)
> +               return ret;
> +
> +       kaddr = memremap(mstart, mend - mstart, MEMREMAP_WB);
> +       if (!kaddr) {
> +               pr_err("Could not map UEFI system table\n");
> +               return -ENOMEM;
> +       }
> +
> +       mstart = efi_config_table;
> +
> +       if (efi_enabled(EFI_64BIT)) {
> +               efi_system_table_64_t *stbl = (efi_system_table_64_t *)kaddr;
> +
> +               mend = mstart + sizeof(efi_config_table_64_t) * stbl->nr_tables;
> +       } else {
> +               efi_system_table_32_t *stbl = (efi_system_table_32_t *)kaddr;
> +
> +               mend = mstart + sizeof(efi_config_table_32_t) * stbl->nr_tables;
> +       }
> +
> +       memunmap(kaddr);
> +
>         return kernel_ident_mapping_init(info, level4p, mstart, mend);
>  #endif
>         return 0;
> @@ -241,10 +268,10 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
>         }
>
>         /*
> -        * Prepare EFI systab and ACPI tables for kexec kernel since they are
> -        * not covered by pfn_mapped.
> +        * Prepare EFI systab, config table and ACPI tables for kexec kernel

Please avoid 'config table' here, as it is ambiguous. IMO you can just
drop this hunk (and the one below)

> +        * since they are not covered by pfn_mapped.
>          */
> -       result = map_efi_systab(&info, level4p);
> +       result = map_efi_tables(&info, level4p);
>         if (result)
>                 return result;
>
> --
> 2.26.2
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
