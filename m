Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29164C5AC80
	for <kexec@archiver.kernel.org>; Sun,  9 Aug 2026 04:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j3nl1oGlrcfuCJuGBdIMdIDErS4NCVUDQGrDn8WbrKY=; b=gfIo6FEQImbiidtPDGy9Ql3KG5
	cTt7d/0h8Oe/GIeT9kpqGbU81g+4JpBOr0L+ceKIbsmdj+Tmc5LCiQRyZ94gBcJFSgyahQLvh+cn3
	5KvixeN0rTO8RflW5/kLfwPV/uDd20h4eCfI4PY36gIJPeMiNgNrrJgXQrMPHs6VD0v7RIGIoOHj7
	uqUyndn/PFFoHZuJjgWw3I6CcIduKA8D0A5+fD4M1/xQDP09JGsabECSL0VaND30CaBOQagnHD6OK
	4IMiVPxhWd7DaFXjjp4w+fX/BohYwk9sfmBcnjZmKaOuKkXoitmvKx65Hla6q1a19P4InfyyfXPa9
	qScEhMzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsuzL-00000009zNQ-1gZk;
	Sun, 09 Aug 2026 04:18:19 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsuzJ-00000009zN0-33r1
	for kexec@lists.infradead.org;
	Sun, 09 Aug 2026 04:18:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 20FB343B3A
	for <kexec@lists.infradead.org>; Sun,  9 Aug 2026 04:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051521F00AC4
	for <kexec@lists.infradead.org>; Sun,  9 Aug 2026 04:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786249096;
	bh=j3nl1oGlrcfuCJuGBdIMdIDErS4NCVUDQGrDn8WbrKY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BWqR2OoKgA28BeVh3Tm2EUcOjEZnC39w2oYDR+RumJ0+Zfy9UrFNzlUMMWe6DTogV
	 Wf+sIzEfuyhbUINfv+0VurPDdJG51M2uZWhkBBvaqJ8kwgtV1U7fjfd5HytQtxk++J
	 gBB0qGmAr3XMfYyfSES3OSr3PgNSmBkhzFArQlrCuaLeKQrjm8/7N6n6/dywaNFU8m
	 OFgCa6oc6mUFIs4oRxh/1pEyFqxwCZk10TWBqIurV8I0ZHQb1XBwxoYXgQ+skJjr+G
	 EVcz/4EdA5ZZ0Qwqiw49wfVW+xBjgZuUyjgTeaIUnvn5XGib+ONyHzpMT7C6m7LY1j
	 cftS7HORAGe4A==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a1b51723a9so1237163a12.1
        for <kexec@lists.infradead.org>; Sat, 08 Aug 2026 21:18:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ron9PGzdA9J6/zQv97p9DZPn/2mzSJi6V0gCF7xkFQQqkgOe1XnLP2fqIBTuqG8DKnRbG+ClA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxZ9hs3xF19g4fSoVrNevdTQeBMaO3McWi/dnxIEGm+ZZecS+f9
	N0kdkMshTcv8gG7PTQ15ADx1VN7xABucrStsiBwkOdgVYWWsW+M92NuxcyJwSc4blNYzKQR/tl7
	30e48AGfNimGRaxjU5OWP5sFbitAMDyM=
X-Received: by 2002:a05:6402:5d0:b0:6a1:245e:525a with SMTP id
 4fb4d7f45d1cf-6a14f26eb8emr17244030a12.19.1786249094682; Sat, 08 Aug 2026
 21:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260807103714.33074-1-dongtai.guo@linux.dev> <20260807103714.33074-2-dongtai.guo@linux.dev>
In-Reply-To: <20260807103714.33074-2-dongtai.guo@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 9 Aug 2026 12:18:04 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4xxPXVRNXP42CBtMdVXbBZ4E6A997jZmw7HpEUSFAj9g@mail.gmail.com>
X-Gm-Features: AUfX_mzdXzAu0LbrcSZLHxk0mDTfusrkGeDoTo4UC_Q7T6b0NAW8AH8IYMcYy6c
Message-ID: <CAAhV-H4xxPXVRNXP42CBtMdVXbBZ4E6A997jZmw7HpEUSFAj9g@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] efi: add a KHO configuration table GUID
To: George Guo <dongtai.guo@linux.dev>
Cc: rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	shuah@kernel.org, ardb@kernel.org, guodongtai@kylinos.cn, kernel@xen0n.name, 
	graf@amazon.com, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-efi@vger.kernel.org
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
> Kexec Handover (KHO) passes the address of its state FDT and of its
> scratch area from the current kernel to the next one.  On architectures
> that boot with a device tree, the current kernel writes the
> linux,kho-fdt and linux,kho-scratch properties into /chosen, and the next
> kernel reads them back in early_init_dt_check_kho().
>
> Architectures that boot through EFI without a device tree have no such
> channel.  LoongArch is one of them: its efistub passes the EFI system
> table and the command line to the core kernel directly and never creates
> an FDT.  x86 has the same problem and carries the state out of band
> instead, in a struct kho_data in the setup_data chain of its boot
> protocol.
>
> Add an out-of-band channel for EFI: a LINUX_EFI_KHO_TABLE_GUID
> configuration table entry, under a randomly generated GUID, pointing at a
> struct linux_efi_kho_data.  The
> current kernel loads the structure and an extended configuration table as
> kexec segments, then switches the EFI system table to the new table
> before jumping.  The next kernel finds the entry by GUID and calls
> kho_populate().
>
> The structure carries no version field.  An incompatible change to the
> layout must use a new GUID, which is the usual rule for EFI configuration
> tables.  The handover payload itself is versioned separately, by the
> compatible string of the KHO state FDT that kho_populate() checks.
>
> This patch adds the definitions only.  LoongArch is the first user; any
> other EFI architecture without a boot FDT can use the same channel.
>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>  include/linux/efi.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index ccbc35479684..789ab9e4312a 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -422,6 +422,7 @@ void efi_native_runtime_setup(void);
>  #define LINUX_EFI_COCO_SECRET_AREA_GUID                EFI_GUID(0xadf956=
ad, 0xe98c, 0x484c,  0xae, 0x11, 0xb5, 0x1c, 0x7d, 0x33, 0x64, 0x47)
>  #define LINUX_EFI_BOOT_MEMMAP_GUID             EFI_GUID(0x800f683f, 0xd0=
8b, 0x423a,  0xa2, 0x93, 0x96, 0x5c, 0x3c, 0x6f, 0xe2, 0xb4)
>  #define LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID    EFI_GUID(0xd5d1de3c, 0x10=
5c, 0x44f9,  0x9e, 0xa9, 0xbc, 0xef, 0x98, 0x12, 0x00, 0x31)
> +#define LINUX_EFI_KHO_TABLE_GUID               EFI_GUID(0xc941b6c7, 0x7b=
3f, 0x4af6,  0x9e, 0x50, 0xfc, 0xb3, 0xa8, 0x86, 0x8a, 0x17)
I don't know whether it is allowed to define a new TABLE ID while
doesn't touch the UEFI SPEC.

Huacai

>
>  #define RISCV_EFI_BOOT_PROTOCOL_GUID           EFI_GUID(0xccd15fec, 0x6f=
73, 0x4eec,  0x83, 0x95, 0x3e, 0x69, 0xe4, 0xb9, 0x40, 0xbf)
>
> @@ -1271,6 +1272,29 @@ struct linux_efi_memreserve {
>
>  void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size);
>
> +/*
> + * The LINUX_EFI_KHO_TABLE_GUID config table points to this structure.  =
It
> + * carries the kexec handover (KHO) state from the current kernel to the=
 next
> + * one: the addresses of the KHO state FDT and of the scratch area.
> + *
> + * This is the handover channel for architectures that boot through EFI =
without
> + * a device tree, where the /chosen linux,kho-fdt and linux,kho-scratch
> + * properties read by early_init_dt_check_kho() are not available.  The =
current
> + * kernel loads the structure and an extended configuration table as kex=
ec
> + * segments; the next kernel finds it by GUID and calls kho_populate().
> + *
> + * The layout is an ABI between the two kernels and is fixed.  It carrie=
s no
> + * version field: an incompatible change must use a new GUID, and the ha=
ndover
> + * payload itself is versioned separately by the compatible string of th=
e KHO
> + * state FDT, which kho_populate() checks.
> + */
> +struct linux_efi_kho_data {
> +       u64 fdt_addr;
> +       u64 fdt_size;
> +       u64 scratch_addr;
> +       u64 scratch_size;
> +} __packed;
> +
>  /*
>   * The LINUX_EFI_MOK_VARIABLE_TABLE_GUID config table can be provided
>   * to the kernel by an EFI boot loader. The table contains a packed
> --
> 2.53.0
>

