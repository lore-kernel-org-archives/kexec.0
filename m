Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3BEC5AE49
	for <kexec@archiver.kernel.org>; Mon, 10 Aug 2026 14:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1NWYE7s2kG2vApGn1CM5LqHxBz/sRWAXVRkICaESsgI=; b=WykRggxfVG4M9tcDnTcXqbeDwE
	hdcHw1W6k0h6EwEuvlQYJCErtmd0fjdpQWRWhkYBZuAA+3q7ptVW0P4QIMuUD27V/D96V/+sJyNfc
	hUKMZtKMmC1Vz5qsm0NrwAwvp49O8y8J42l37Iia1p3xhenlcO6NrEBHtJcHux9Tf9OOB4X1vckyO
	Hexdge3dYb5EtSjl8HgtSlGniu1+nOv+zpPkQJS71rMan5K1QEv0hSTWyymRoTC0NqtgLg1hoYnqX
	FITXtWGjOkKDnqNDX95YOQ2R0hdDghyiRgvwGUgZbxx/fwOz8ZWyx4SFsE0tlJHkhAshzU7C16Gbr
	1TIG6p6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtRCp-0000000C2tz-28q8;
	Mon, 10 Aug 2026 14:42:23 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtRCo-0000000C2tg-0XmO
	for kexec@lists.infradead.org;
	Mon, 10 Aug 2026 14:42:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 853106013A
	for <kexec@lists.infradead.org>; Mon, 10 Aug 2026 14:42:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23541F00AC4
	for <kexec@lists.infradead.org>; Mon, 10 Aug 2026 14:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786372940;
	bh=1NWYE7s2kG2vApGn1CM5LqHxBz/sRWAXVRkICaESsgI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ji0ldL2KLgu1g5KpSvwQCsgVMXf2LTmHWUPtUfHHL734RpPhDwKzMTGbvB8JGN6gw
	 5vqbcocNiZYAS4IBsBgE0vAwASY9lUBdZHBjvPOhCnXo0OWYCySxg50pJOz0cGjkgu
	 6Ladfq4m6Lp9hN6FtHVae2auxn1N1Z04sMfoecX0LCfSos6/sZrFJR6UxqGxHIyteI
	 Q8qI5zZ24VaYUUyPOTHqZVLWGgLa+iBCpq/Do/IOPHD195jvsD3Pi8Lxl4VfzXVnO8
	 QWOq0G/rUf3JQHBJPYdGD/r86YcmVm0mNSizWs0qZi2EO7BAsj3u/TzlnD1BW7FIVJ
	 kulK2w6ezHKow==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a205b0df35so2272154a12.1
        for <kexec@lists.infradead.org>; Mon, 10 Aug 2026 07:42:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpf0YFvD001n5+61T9UlCcReHQmFxz2fShIDCLapq2Mc9u3sqOX9DvV3/abOGi12A6KFVnxUA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx5bFOMvyWxhSLinDXql+MN6k8917cxCFboi5kDDKnFCoGN5HUc
	z4uL4rxiAvLhTGPS3TVc8LzqLXvejnK/YBDFrrg6ZjXkkXP6/oWsQS00qZsy5CBPvbaxDCfF3Ev
	WBLWacDQS7bg0BCoAdX//PdD1whFzFic=
X-Received: by 2002:a05:6402:5515:b0:6a1:f95b:8ced with SMTP id
 4fb4d7f45d1cf-6a1f95b8e6fmr6864130a12.4.1786372939467; Mon, 10 Aug 2026
 07:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260807103714.33074-1-dongtai.guo@linux.dev> <20260807103714.33074-3-dongtai.guo@linux.dev>
In-Reply-To: <20260807103714.33074-3-dongtai.guo@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 10 Aug 2026 22:42:08 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4PKRNCa4g=6TGepP+trtM82JiMoWgVr3O7PqbZYP9uGw@mail.gmail.com>
X-Gm-Features: AUfX_mylGF0TY6FDYfRhuwV2zjLnDdK1yWUYNWpJU2vhIKc7fAtDrVrc6klRqkA
Message-ID: <CAAhV-H4PKRNCa4g=6TGepP+trtM82JiMoWgVr3O7PqbZYP9uGw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] LoongArch: kexec: add KHO support
To: George Guo <dongtai.guo@linux.dev>
Cc: rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	shuah@kernel.org, ardb@kernel.org, guodongtai@kylinos.cn, kernel@xen0n.name, 
	graf@amazon.com, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-efi@vger.kernel.org, 
	Kexin Liu <liukexin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi, George,

On Fri, Aug 7, 2026 at 6:38=E2=80=AFPM George Guo <dongtai.guo@linux.dev> w=
rote:
>
> From: George Guo <guodongtai@kylinos.cn>
>
> Enable Kexec Handover (KHO) on LoongArch64.
>
> LoongArch has no boot FDT: the efistub passes the EFI system table and
> the command line to the core kernel directly, so the arm64 /chosen path
> (append linux,kho-fdt / linux,kho-scratch and let
> early_init_dt_check_kho() read them) does not apply.  Follow the x86
> model instead, which has no boot FDT either: carry the KHO pointer out of
> band and call kho_populate() directly.  The channel is the EFI
> configuration table entry added by the previous patch.
>
> - Kconfig: ARCH_SUPPORTS_KEXEC_HANDOVER is def_bool 64BIT.
> - machine_kexec_file.c: kho_load_data() builds a small handover blob
>   (struct linux_efi_kho_data) holding the KHO state FDT and scratch
>   addresses, and a new EFI configuration table with a
>   LINUX_EFI_KHO_TABLE_GUID entry pointing to it; both are loaded as kexec
>   segments.
> - machine_kexec.c: before jumping to the next kernel, switch the EFI
>   system table to the extended configuration table.
> - setup.c: kho_populate_from_efi() scans the configuration table for
>   LINUX_EFI_KHO_TABLE_GUID and calls kho_populate() from setup_arch(),
>   after efi_init() and before memblock_init().
>
> Handover is set up by the kexec_file_load() syscall only.  kho_load_data(=
)
> runs from load_other_segments(), which the older kexec_load() syscall doe=
s
> not reach.  This matches x86, where KHO lives in the bzImage64 loader.
>
> Tested on a LoongArch machine booting through ACPI/UEFI.  After the kexec=
,
> the second kernel reports
>
>   KHO: found kexec handover data.
>
> and the two-stage test passes: luo_kexec_simple --stage 1, kexec into the
> second kernel, then luo_kexec_simple --stage 2.
>
> Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>  arch/loongarch/Kconfig                     |   3 +
>  arch/loongarch/include/asm/kexec.h         |   7 ++
>  arch/loongarch/kernel/machine_kexec.c      |  16 +++
>  arch/loongarch/kernel/machine_kexec_file.c | 131 +++++++++++++++++++++
>  arch/loongarch/kernel/setup.c              |  41 +++++++
>  5 files changed, 198 insertions(+)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index d8d252325017..698828ef70f0 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -684,6 +684,9 @@ config ARCH_SUPPORTS_KEXEC
>  config ARCH_SUPPORTS_KEXEC_FILE
>         def_bool 64BIT
>
> +config ARCH_SUPPORTS_KEXEC_HANDOVER
> +       def_bool 64BIT
> +
>  config ARCH_SELECTS_KEXEC_FILE
>         def_bool 64BIT
>         depends on KEXEC_FILE
> diff --git a/arch/loongarch/include/asm/kexec.h b/arch/loongarch/include/=
asm/kexec.h
> index 6be136e9f0a0..2bcc8bc0d3cc 100644
> --- a/arch/loongarch/include/asm/kexec.h
> +++ b/arch/loongarch/include/asm/kexec.h
> @@ -39,6 +39,13 @@ struct kimage_arch {
>         unsigned long efi_boot;
>         unsigned long cmdline_ptr;
>         unsigned long systable_ptr;
> +#ifdef CONFIG_KEXEC_HANDOVER
> +       void *kho_data;                 /* KHO handover blob buffer (virt=
ual) */
> +       unsigned long kho_data_mem;     /* physical address of the KHO ha=
ndover blob */
> +       void *efi_tables;               /* new EFI config table buffer (v=
irtual) */
> +       unsigned long efi_tables_mem;   /* physical address of new EFI co=
nfig table */
> +       unsigned long efi_tables_cnt;   /* number of entries in new EFI c=
onfig table */
> +#endif
>  };
>
>  struct kimage;
> diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kerne=
l/machine_kexec.c
> index 1883cae93bc3..c98a5607684d 100644
> --- a/arch/loongarch/kernel/machine_kexec.c
> +++ b/arch/loongarch/kernel/machine_kexec.c
> @@ -6,6 +6,7 @@
>   */
>  #include <linux/compiler.h>
>  #include <linux/cpu.h>
> +#include <linux/efi.h>
>  #include <linux/kexec.h>
>  #include <linux/crash_dump.h>
>  #include <linux/delay.h>
> @@ -287,6 +288,21 @@ void machine_kexec(struct kimage *image)
>         pr_notice("We will call new kernel at 0x%lx\n", start_addr);
>         pr_notice("Bye ...\n");
>
> +#ifdef CONFIG_KEXEC_HANDOVER
> +       /*
> +        * KHO: switch the EFI system table to the extended configuration=
 table
> +        * built in kho_load_data(), which carries the LINUX_EFI_KHO_TABL=
E_GUID
> +        * entry the next kernel reads to find the KHO handover blob.
> +        */
> +       if (internal->efi_tables_mem) {
> +               efi_system_table_t *st =3D
> +                       (efi_system_table_t *)TO_CACHE(systable_ptr);
> +
> +               st->tables    =3D internal->efi_tables_mem;
> +               st->nr_tables =3D internal->efi_tables_cnt;
> +       }
> +#endif
> +
>         /* Make reboot code buffer available to the boot CPU. */
>         flush_cache_all();
>
> diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/=
kernel/machine_kexec_file.c
> index 5584b798ba46..d4c2243b6cb0 100644
> --- a/arch/loongarch/kernel/machine_kexec_file.c
> +++ b/arch/loongarch/kernel/machine_kexec_file.c
> @@ -10,6 +10,7 @@
>
>  #define pr_fmt(fmt) "kexec_file: " fmt
>
> +#include <linux/efi.h>
>  #include <linux/ioport.h>
>  #include <linux/kernel.h>
>  #include <linux/kexec.h>
> @@ -18,6 +19,7 @@
>  #include <linux/string.h>
>  #include <linux/types.h>
>  #include <linux/vmalloc.h>
> +#include <asm/addrspace.h>
>  #include <asm/bootinfo.h>
>
>  const struct kexec_file_ops * const kexec_file_loaders[] =3D {
> @@ -32,6 +34,13 @@ int arch_kimage_file_post_load_cleanup(struct kimage *=
image)
>         image->elf_headers =3D NULL;
>         image->elf_headers_sz =3D 0;
>
> +#ifdef CONFIG_KEXEC_HANDOVER
> +       kfree(image->arch.kho_data);
> +       image->arch.kho_data =3D NULL;
> +       kvfree(image->arch.efi_tables);
> +       image->arch.efi_tables =3D NULL;
> +#endif
> +
>         return kexec_image_post_load_cleanup_default(image);
>  }
>
> @@ -55,6 +64,121 @@ static void cmdline_add_initrd(struct kimage *image, =
unsigned long *cmdline_tmpl
>         *cmdline_tmplen +=3D initrd_strlen;
>  }
>
> +#ifdef CONFIG_KEXEC_HANDOVER
> +/*
> + * Hand the KHO state to the next kernel through a dedicated EFI configu=
ration
> + * table entry.
> + *
> + * LoongArch has no boot FDT: the efistub passes the EFI system table an=
d the
> + * command line to the core kernel directly.  So instead of the arm64 /c=
hosen
> + * FDT path, build a small handover blob (struct linux_efi_kho_data) hol=
ding the
> + * KHO state FDT and scratch addresses, register it in the EFI configura=
tion
> + * table under LINUX_EFI_KHO_TABLE_GUID, and let the next kernel read it=
 and
> + * call kho_populate() directly.
> + *
> + * Both the blob and the extended configuration table are loaded as kexe=
c
> + * segments; machine_kexec() switches st->tables to the new table before=
 jumping.
> + *
> + * image->kho.fdt and image->kho.scratch are filled in by kho_fill_kimag=
e()
> + * before the arch loader runs, so they are valid here.
> + */
> +static int kho_load_data(struct kimage *image)
> +{
> +       struct linux_efi_kho_data *kho;
> +       efi_system_table_t *st;
> +       efi_config_table_t *ct, *new_ct;
> +       size_t old_sz, new_sz;
> +       struct kexec_buf kbuf =3D {
> +               .image          =3D image,
> +               .buf_min        =3D 0,
> +               .buf_max        =3D ULONG_MAX,
> +               .top_down       =3D true,
> +       };
> +       int ret;
> +
> +       if (!image->kho.fdt || !image->kho.scratch)
> +               return 0;
> +
> +       if (!fw_arg2) {
> +               pr_err("KHO requires an EFI boot, no EFI system table fou=
nd\n");
> +               return -EINVAL;
> +       }
This check is unnecessary, if no EFI system table, you cannot boot
your system, and have no chance for kexec.

> +
> +       /* Build the handover blob and load it as a kexec segment. */
> +       kho =3D kzalloc(sizeof(*kho), GFP_KERNEL);
> +       if (!kho)
> +               return -ENOMEM;
> +
> +       kho->fdt_addr     =3D image->kho.fdt;
> +       kho->fdt_size     =3D PAGE_SIZE;
> +       kho->scratch_addr =3D image->kho.scratch->mem;
> +       kho->scratch_size =3D image->kho.scratch->memsz;
> +
> +       kbuf.buffer     =3D kho;
> +       kbuf.bufsz      =3D sizeof(*kho);
> +       kbuf.memsz      =3D sizeof(*kho);
> +       kbuf.buf_align  =3D sizeof(u64);
> +       kbuf.mem        =3D KEXEC_BUF_MEM_UNKNOWN;
> +
> +       ret =3D kexec_add_buffer(&kbuf);
> +       if (ret) {
> +               kfree(kho);
> +               return ret;
> +       }
> +       image->arch.kho_data     =3D kho;
> +       image->arch.kho_data_mem =3D kbuf.mem;
> +
> +       kexec_dprintk("Loaded KHO handover blob at 0x%lx bufsz=3D0x%lx me=
msz=3D0x%lx\n",
> +                     image->arch.kho_data_mem, kbuf.bufsz, kbuf.memsz);
> +       kexec_dprintk("KHO fdt at 0x%llx, scratch at 0x%llx size 0x%llx\n=
",
> +                     kho->fdt_addr, kho->scratch_addr, kho->scratch_size=
);
> +
> +       /*
> +        * Build a new EFI configuration table with a LINUX_EFI_KHO_TABLE=
_GUID
> +        * entry appended, pointing at the handover blob, and load it as =
a kexec
> +        * segment.  machine_kexec() updates st->tables / st->nr_tables t=
o point
> +        * to it before jumping.
> +        *
> +        * fw_arg2 is the EFI system table physical address passed by the
> +        * firmware/bootloader.  Use it directly because image->arch.syst=
able_ptr
> +        * is set later in machine_kexec_prepare(), which runs after this=
.
> +        */
> +       st =3D (efi_system_table_t *)TO_CACHE(fw_arg2);
> +       ct =3D (efi_config_table_t *)TO_CACHE((unsigned long)st->tables);
> +       old_sz =3D st->nr_tables * sizeof(efi_config_table_t);
> +       new_sz =3D old_sz + sizeof(efi_config_table_t);
> +
> +       new_ct =3D kvmalloc(new_sz, GFP_KERNEL);
> +       if (!new_ct)
> +               return -ENOMEM;
> +
> +       memcpy(new_ct, ct, old_sz);
> +       new_ct[st->nr_tables].guid  =3D LINUX_EFI_KHO_TABLE_GUID;
> +       new_ct[st->nr_tables].table =3D (void *)image->arch.kho_data_mem;
> +
> +       kbuf.buffer     =3D new_ct;
> +       kbuf.bufsz      =3D new_sz;
> +       kbuf.memsz      =3D new_sz;
> +       kbuf.buf_align  =3D sizeof(void *);
> +       kbuf.mem        =3D KEXEC_BUF_MEM_UNKNOWN;
> +
> +       ret =3D kexec_add_buffer(&kbuf);
> +       if (ret) {
> +               kvfree(new_ct);
> +               return ret;
> +       }
> +       image->arch.efi_tables     =3D new_ct;
> +       image->arch.efi_tables_mem =3D kbuf.mem;
> +       image->arch.efi_tables_cnt =3D st->nr_tables + 1;
> +
> +       kexec_dprintk("Loaded EFI config table at 0x%lx bufsz=3D0x%lx mem=
sz=3D0x%lx nr_tables=3D%lu\n",
> +                     image->arch.efi_tables_mem, kbuf.bufsz, kbuf.memsz,
> +                     image->arch.efi_tables_cnt);
> +
> +       return 0;
> +}
> +#endif
> +
>  #ifdef CONFIG_CRASH_DUMP
>
>  static int prepare_elf_headers(void **addr, unsigned long *sz)
> @@ -220,6 +344,13 @@ int load_other_segments(struct kimage *image,
>                 cmdline_add_initrd(image, &cmdline_tmplen, modified_cmdli=
ne, initrd_load_addr);
>         }
>
> +#ifdef CONFIG_KEXEC_HANDOVER
> +       /* Load the KHO handover blob and the extended EFI configuration =
table */
> +       ret =3D kho_load_data(image);
> +       if (ret)
> +               goto out_err;
> +#endif
> +
>         if (cmdline_len + cmdline_tmplen > COMMAND_LINE_SIZE) {
>                 pr_err("Appending command line exceeds COMMAND_LINE_SIZE\=
n");
>                 ret =3D -EINVAL;
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.=
c
> index 6fa4a22a58fd..1e2fbf37aecf 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -20,6 +20,7 @@
>  #include <linux/initrd.h>
>  #include <linux/ioport.h>
>  #include <linux/kexec.h>
> +#include <linux/kexec_handover.h>
>  #include <linux/crash_dump.h>
>  #include <linux/root_dev.h>
>  #include <linux/console.h>
> @@ -280,6 +281,45 @@ static void __init arch_reserve_crashkernel(void)
>         reserve_crashkernel_generic(crash_size, crash_base, low_size, hig=
h);
>  }
>
> +#ifdef CONFIG_KEXEC_HANDOVER
> +/*
> + * On a KHO kexec boot the previous kernel registered a handover blob in=
 the EFI
> + * configuration table under LINUX_EFI_KHO_TABLE_GUID (see
> + * arch/loongarch/kernel/machine_kexec_file.c).  Scan the configuration =
table
> + * for it, read the KHO state FDT and scratch addresses, and hand them t=
o the
> + * KHO core.  fw_arg2 is the EFI system table physical address.
> + *
> + * This runs from setup_arch(), after efi_init() and before memblock_ini=
t(),
> + * which is where the generic reader early_init_dt_check_kho() would cal=
l
> + * kho_populate().
> + */
> +static void __init kho_populate_from_efi(void)
> +{
> +       efi_system_table_t *st;
> +       efi_config_table_t *ct;
> +       struct linux_efi_kho_data *kho;
> +       unsigned long i;
> +
> +       if (!fw_arg2)
> +               return;
> +
> +       st =3D (efi_system_table_t *)TO_CACHE(fw_arg2);
> +       ct =3D (efi_config_table_t *)TO_CACHE((unsigned long)st->tables);
> +
> +       for (i =3D 0; i < st->nr_tables; i++) {
> +               if (efi_guidcmp(ct[i].guid, LINUX_EFI_KHO_TABLE_GUID))
> +                       continue;
> +
> +               kho =3D (struct linux_efi_kho_data *)TO_CACHE((unsigned l=
ong)ct[i].table);
> +               kho_populate(kho->fdt_addr, kho->fdt_size,
> +                            kho->scratch_addr, kho->scratch_size);
> +               break;
> +       }
> +}
If you do this in efi.c, you can significantly simplify the code. By
defining the KHO table in arch_tables[], you almost only need to call
kho_populate() at the end of efi_init().

Huacai

> +#else
> +static void __init kho_populate_from_efi(void) { }
> +#endif
> +
>  static void __init fdt_setup(void)
>  {
>  #ifdef CONFIG_OF_EARLY_FLATTREE
> @@ -599,6 +639,7 @@ void __init setup_arch(char **cmdline_p)
>
>         init_environ();
>         efi_init();
> +       kho_populate_from_efi();
>         fdt_setup();
>         memblock_init();
>         pagetable_init();
> --
> 2.53.0
>

