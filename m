Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F02CA0EED
	for <kexec@archiver.kernel.org>; Fri, 22 Aug 2025 12:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Twjd5csfJL951dyyqXbpze3S1w/qmqLgIFksdjufPuA=; b=dnUgkSTZuoI65W8AdYqlg3UcII
	YLMVlLKdbQsEJdFhS/OrC06ZsBDIjQxMd9iNP61w8cEEJPCJJ5qUbz8KYcKf+xib277mDgHkVttBd
	THLTGMQUqmSYwu4GQOqztYROBzSw1KB3j2Na86gfTgJzN+eTxo481DjwHZEjMz6h/6YH8yeVOjOYA
	fdC1vRqfcZW8NoD5Br55a5Tb/aR88ulMdrzj5ycyCQ/x6qzDV84LWEKdZj6PvF4LZq+ym4hdP1Wxi
	9LnuDb6Yg9nVQdPs0MoBgF8atO0Wt1lwG5PmMzAxicmIeLJ1VLf13FuQ78ufnNq943DR1O9fCvY+x
	tngU3jkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upRCm-00000002XNB-3kYY;
	Fri, 22 Aug 2025 12:49:16 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upJKP-00000001V5V-1kdn
	for kexec@lists.infradead.org;
	Fri, 22 Aug 2025 04:24:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B36255C5868
	for <kexec@lists.infradead.org>; Fri, 22 Aug 2025 04:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61377C113CF
	for <kexec@lists.infradead.org>; Fri, 22 Aug 2025 04:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755836676;
	bh=hdLoUiaBln2CymuyFiOoxDrvSdJ66u+W+Zz2ftDs/sw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HViUmzux+L3CSQ5OI5x5mjezVk8X6RXATvD4SScmPhIxMtkiNnPzOSTiCAZQnGc6w
	 12yO6RO6lg83om+Ol7U20Hg19fVN+7bQvA7bW5jNA/qyrad8MmLE7QgbFc64lGLqeJ
	 A8YjAFPBysqMiWCZjUL/mcZwslpyUizXcn3nh45ZxsuFs9vox4m6ulJQfdZQlw7RAk
	 V+Se4folcGspnc40Lw415v2wZWTDS6XVN9lKAecx0l7twkI/zIPidyEUrq1Ync3spf
	 WZo8vDjBB71txDVEY2+s1j/3l0nb/fRI5uBHnWiE4OeAh1J7c806ji4xp4oN0rKvvW
	 +68FJUPGkdBTw==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61c13619cacso1340043a12.3
        for <kexec@lists.infradead.org>; Thu, 21 Aug 2025 21:24:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWwGao8Ma1bvmwGZtMR6ltrj61kvSAbXxsi/0HtFH0YUaiVUP2btSFzLZJWNdUyer9VF8+kfQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyIg34LJ9r3a3CNgQf01wZQQv8fH0CFKnNNCyrPN1C5uAhHe0xo
	YBR4B04YSmnFZrTpU0NQmiiFQeuO5Ao5ymbibxcZeZ9WzyiM3b8DQSOGQ+hIRIkBYdVPqa1gvqP
	46szfKpC95zKTlzW6GamCpEpuMrJfBG8=
X-Google-Smtp-Source: AGHT+IHqs2pTkwgnH9/nSe+JpzBsNJVcaFHlAqfyAEAHmVa871mLL0ucnP3YWPNa5R1jHM7EdP/XNH3A/HhSkS/3jGg=
X-Received: by 2002:a05:6402:270c:b0:61b:fabb:6d0e with SMTP id
 4fb4d7f45d1cf-61c1b705498mr1253509a12.19.1755836674942; Thu, 21 Aug 2025
 21:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250820055700.24344-1-youling.tang@linux.dev>
 <20250820055700.24344-3-youling.tang@linux.dev> <aKVwHOM9KNEpUZF4@pie>
 <5f6eeefb-681a-424e-9a6b-2e91eaf87571@linux.dev> <aKWt63S_wD3zeMYU@pie> <00a013bd-f30f-4b13-8019-f97a4d2eabb2@linux.dev>
In-Reply-To: <00a013bd-f30f-4b13-8019-f97a4d2eabb2@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 22 Aug 2025 12:24:21 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7jr4HuizZvNSAnmoo9z8D1Txe1_jnEgWDwWMmu0q8fLg@mail.gmail.com>
X-Gm-Features: Ac12FXz8S1QEwTy9vLsdEgi58FBIWe3h9tyYMzLwsskThXpPLmQNF7Rc6jf_69I
Message-ID: <CAAhV-H7jr4HuizZvNSAnmoo9z8D1Txe1_jnEgWDwWMmu0q8fLg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] LoongArch: Add kexec_file support
To: Youling Tang <youling.tang@linux.dev>
Cc: Yao Zi <ziyao@disroot.org>, WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_212437_540685_C8E6D0A3 
X-CRM114-Status: GOOD (  50.32  )
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

On Thu, Aug 21, 2025 at 9:20=E2=80=AFAM Youling Tang <youling.tang@linux.de=
v> wrote:
>
> On 2025/8/20 19:13, Yao Zi wrote:
>
> > On Wed, Aug 20, 2025 at 05:13:27PM +0800, Youling Tang wrote:
> >> Hi, Yao
> >>
> >> On 2025/8/20 14:50, Yao Zi wrote:
> >>
> >>> On Wed, Aug 20, 2025 at 01:56:57PM +0800, Youling Tang wrote:
> >>>> From: Youling Tang <tangyouling@kylinos.cn>
> >>>>
> >>>> This patch adds support for kexec_file on LoongArch.
> >>>>
> >>>> The efi_kexec_load() as two parts:
> >>>> - the first part loads the kernel image (vmlinuz.efi or vmlinux.efi)
> >>>> - the second part loads other segments (eg: initrd, cmdline)
> >>>>
> >>>> This initrd will be passed to the second kernel via the command line
> >>>> 'initrd=3Dstart,size'.
> >>>>
> >>>> Currently, pez(vmlinuz.efi) and pei(vmlinux.efi) format images are s=
upported,
> >>>> but ELF format is not supported.
> >>>>
> >>>> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> >>>> ---
> >>>>    arch/loongarch/Kconfig                     |   9 ++
> >>>>    arch/loongarch/include/asm/image.h         |  17 +++
> >>>>    arch/loongarch/include/asm/kexec.h         |  12 +++
> >>>>    arch/loongarch/kernel/Makefile             |   1 +
> >>>>    arch/loongarch/kernel/kexec_efi.c          | 111 ++++++++++++++++=
+++
> >>>>    arch/loongarch/kernel/machine_kexec.c      |  33 ++++--
> >>>>    arch/loongarch/kernel/machine_kexec_file.c | 117 ++++++++++++++++=
+++++
> >>>>    7 files changed, 289 insertions(+), 11 deletions(-)
> >>>>    create mode 100644 arch/loongarch/kernel/kexec_efi.c
> >>>>    create mode 100644 arch/loongarch/kernel/machine_kexec_file.c
> >>> ...
> >>>
> >>>> diff --git a/arch/loongarch/include/asm/image.h b/arch/loongarch/inc=
lude/asm/image.h
> >>>> index 1f090736e71d..655d5836c4e8 100644
> >>>> --- a/arch/loongarch/include/asm/image.h
> >>>> +++ b/arch/loongarch/include/asm/image.h
> >>>> @@ -36,5 +36,22 @@ struct loongarch_image_header {
> >>>>            uint32_t pe_header;
> >>>>    };
> >>>> +static const uint8_t loongarch_image_pe_sig[2] =3D {'M', 'Z'};
> >>>> +
> >>>> +/**
> >>>> + * loongarch_header_check_pe_sig - Helper to check the loongarch im=
age header.
> >>>> + *
> >>>> + * Returns non-zero if 'MZ' signature is found.
> >>>> + */
> >>>> +
> >>>> +static inline int loongarch_header_check_pe_sig(const struct loonga=
rch_image_header *h)
> >>>> +{
> >>>> +  if (!h)
> >>>> +          return 0;
> >>>> +
> >>>> +  return (h->pe_sig[0] =3D=3D loongarch_image_pe_sig[0]
> >>>> +          && h->pe_sig[1] =3D=3D loongarch_image_pe_sig[1]);
> >>>> +}
> >>> This check is still too weak and doesn't improve comparing to v1.
> >>>
> >>>> This could be simplified with a memcmp(). Also, this check isn't
> >>>> strict enough: PE files for any architectures, and even legacy MS-DO=
S
> >>>> COM executables all start with "MZ".
> >>> I've pointed this out in my previous reply[1].
> >> Previously, I had considered adding a specific LoongArch magic
> >> number (such as "Loongson") in the loongarch_image_header, but
> >> this is incompatible with older versions of the kernel, so it
> >> remains the same without further checks.
> > All PE images ship a PE signature with offset 0x3c[1] and you could
> > locate the PE header[2] by the offset provided by
> > loongarch_image_header.pe_header and check its machine field[3], which
> > should be 0x6264 for 64-bit LoongArch executables and 0x6232 for 32-bit
> > ones. At least this ensures it's a LoongArch kernel image.
> I mentioned this judgment to Huacai before. Huacai, what do you think?
> If necessary, I will add this judgment.
I think we can assume that users know what they are doing, so we can
just distinguish an EFI kernel and ELF kernel, no more checking is
necessary.

Huacai

>
> Thanks,
> Youling.
> >
> >>>>    #endif /* __ASSEMBLY__ */
> >>>>    #endif /* __ASM_IMAGE_H */
> >>> ...
> >>>
> >>>> diff --git a/arch/loongarch/kernel/kexec_efi.c b/arch/loongarch/kern=
el/kexec_efi.c
> >>>> new file mode 100644
> >>>> index 000000000000..7741f1139a12
> >>>> --- /dev/null
> >>>> +++ b/arch/loongarch/kernel/kexec_efi.c
> >>> ...
> >>>
> >>>> +static void *efi_kexec_load(struct kimage *image,
> >>>> +                          char *kernel, unsigned long kernel_len,
> >>>> +                          char *initrd, unsigned long initrd_len,
> >>>> +                          char *cmdline, unsigned long cmdline_len)
> >>>> +{
> >>>> +  struct loongarch_image_header *h;
> >>>> +  struct kexec_buf kbuf;
> >>>> +  unsigned long text_offset, kernel_segment_number;
> >>>> +  struct kexec_segment *kernel_segment;
> >>>> +  int ret;
> >>>> +
> >>>> +  h =3D (struct loongarch_image_header *)kernel;
> >>>> +  if (!h->image_size)
> >>>> +          return ERR_PTR(-EINVAL);
> >>>> +
> >>>> +  /* Load the kernel */
> >>>> +  kbuf.image =3D image;
> >>>> +  kbuf.buf_max =3D ULONG_MAX;
> >>>> +  kbuf.top_down =3D false;
> >>>> +
> >>>> +  kbuf.buffer =3D kernel;
> >>>> +  kbuf.bufsz =3D kernel_len;
> >>>> +  kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> >>>> +  kbuf.memsz =3D le64_to_cpu(h->image_size);
> >>>> +  text_offset =3D le64_to_cpu(h->text_offset);
> >>>> +  kbuf.buf_min =3D text_offset;
> >>>> +  kbuf.buf_align =3D SZ_2M;
> >>>> +
> >>>> +  kernel_segment_number =3D image->nr_segments;
> >>>> +
> >>>> +  /*
> >>>> +   * The location of the kernel segment may make it impossible to s=
atisfy
> >>>> +   * the other segment requirements, so we try repeatedly to find a
> >>>> +   * location that will work.
> >>>> +   */
> >>>> +  while ((ret =3D kexec_add_buffer(&kbuf)) =3D=3D 0) {
> >>>> +          /* Try to load additional data */
> >>>> +          kernel_segment =3D &image->segment[kernel_segment_number]=
;
> >>>> +          ret =3D load_other_segments(image, kernel_segment->mem,
> >>>> +                                    kernel_segment->memsz, initrd,
> >>>> +                                    initrd_len, cmdline, cmdline_le=
n);
> >>>> +          if (!ret)
> >>>> +                  break;
> >>>> +
> >>>> +          /*
> >>>> +           * We couldn't find space for the other segments; erase t=
he
> >>>> +           * kernel segment and try the next available hole.
> >>>> +           */
> >>>> +          image->nr_segments -=3D 1;
> >>>> +          kbuf.buf_min =3D kernel_segment->mem + kernel_segment->me=
msz;
> >>>> +          kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> >>>> +  }
> >>>> +
> >>>> +  if (ret) {
> >>>> +          pr_err("Could not find any suitable kernel location!");
> >>>> +          return ERR_PTR(ret);
> >>>> +  }
> >>>> +
> >>>> +  kernel_segment =3D &image->segment[kernel_segment_number];
> >>>> +
> >>>> +  /* Make sure the second kernel jumps to the correct "kernel_entry=
". */
> >>>> +  image->start =3D kernel_segment->mem + h->kernel_entry - text_off=
set;
> >>> And this still assumes the loaded, secondary kernel is relocatable,
> >>> with neither extra check nor comment explaining its limitation.
> >>>
> >>> Please see my previous reply[2] that explains why loading a
> >>> non-relocatble kernel with kexec_file API is reasonable.
> >> LoongArch is a non-position independent (non-PIE) kernel when
> >> the RELOCATABLE option is not enabled, the kernel contains certain
> >> instructions such as la.abs, which prevent it from being relocated to
> >> arbitrary memory addresses for execution. As a result, limitations
> >> exist that make features like kdump or kexec_file dependent on
> >> the RELOCATABLE option.
> >>
> >> Strictly speaking, we need to add additional checks: if the kernel is
> >> non-relocatable, the loading operation should fail directly.
> > Agree.
> >
> >> For a
> >> running kernel, we can easily determine this by calling
> >> kallsyms_lookup_name("relocate_kernel"). However, for a kernel
> >> that is being loaded but has not yet started execution, it is difficul=
t
> >> to easily determine whether the currently loaded kernel has the
> >> RELOCATABLE configuration option enabled.
> > I understand the difficulty, thus IMHO a comment is helpful here to
> > remind the reader of lack of relocatability checks.
> >
> > Best regards,
> > Yao Zi
> >
> >> For ELF format images, we can determine whether the loaded image
> >> contains the ".la_abs" section in the following way:
> >> static struct mem_shdr *laabs_section(const struct mem_ehdr *ehdr)
> >> {
> >>          struct mem_shdr *shdr, *shdr_end;
> >>          unsigned char *strtab;
> >>
> >>          strtab =3D (unsigned char *)ehdr->e_shdr[ehdr->e_shstrndx].sh=
_data;
> >>          shdr_end =3D &ehdr->e_shdr[ehdr->e_shnum];
> >>          for (shdr =3D ehdr->e_shdr; shdr !=3D shdr_end; shdr++) {
> >>                  if (shdr->sh_size &&
> >>                          strcmp((char *)&strtab[shdr->sh_name], ".la_a=
bs") =3D=3D
> >> 0) {
> >>                          return shdr;
> >>                  }
> >>          }
> >>
> >>          return NULL;
> >> }
> >>
> >> Thanks,
> >> Youling.
> >>>> +  kexec_dprintk("Loaded kernel at 0x%lx bufsz=3D0x%lx memsz=3D0x%lx=
\n",
> >>>> +                kernel_segment->mem, kbuf.bufsz,
> >>>> +                kernel_segment->memsz);
> >>>> +
> >>>> +  return NULL;
> >>>> +}
> >>>> +
> >>>> +const struct kexec_file_ops kexec_efi_ops =3D {
> >>>> +  .probe =3D efi_kexec_probe,
> >>>> +  .load =3D efi_kexec_load,
> >>>> +};
> >>> Thanks,
> >>> Yao Zi
> >>>
> >>> [1]: https://lore.kernel.org/all/aJojDiHWi8cgvA2W@pie/
> >>> [2]: https://lore.kernel.org/all/aJwFa8x5BQMouB1y@pie/
> > [1]: https://learn.microsoft.com/en-us/windows/win32/debug/pe-format#si=
gnature-image-only
> > [2]: https://learn.microsoft.com/en-us/windows/win32/debug/pe-format#co=
ff-file-header-object-and-image
> > [3]: https://learn.microsoft.com/en-us/windows/win32/debug/pe-format#ma=
chine-types

