Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6440CCFA13
	for <kexec@archiver.kernel.org>; Mon, 10 Nov 2025 09:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+am4pjzzW6xR5ogqMFubRXmmdAyB4wsYUFRJOyh7Xts=; b=Oi7AJ/q8u879UVMS3xfxIaMnvb
	z8T922jFRwipQnlZjzZ1GraUbHo8pMTdKR+mT2IWunO9OXOSnKvv+P3elbNAjErJ6t72gK8CRM96N
	arZsqBQIGSAfsEfagf07rEJFWEgtRMDJGBqa3tN+/ldDWXNrjC9Pv3FVoJmFdpfPYELUmSeuBSvoA
	wBpqDdOp3Twq+RTeXnXelf7q6H7PyNrB7Z4jXjRR2uiMeejz3mmb1HJstxw4u2d4ndFHRe3zHPX58
	zi/8R9k92XCrq4NAlyy8pUd2W5EvEBGyFZ2reLkMyr3M0Vs6WCvycPGgeOOH+zcCf8KZmC5ynwOiZ
	dLXtgHEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIO8D-000000055RO-2W71;
	Mon, 10 Nov 2025 09:24:13 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIO8A-000000055Pn-0dJv
	for kexec@lists.infradead.org;
	Mon, 10 Nov 2025 09:24:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A27C543B0B
	for <kexec@lists.infradead.org>; Mon, 10 Nov 2025 09:24:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E601C4AF0C
	for <kexec@lists.infradead.org>; Mon, 10 Nov 2025 09:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762766647;
	bh=KPLJ0BDFg+H/l04UHzoeAt3yMyHAuNG095TqJJtvvWY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qGLo6+aDkkea2sc1+PLVJH4zVX7+Qt4cWOxCQihj7rgpJ71ydrvxQ66rWl6M+E495
	 IupFlb2waoUzR5cOMF/dt1KfisBkfr5a40rXWVr9i365QKAEbr8M+FN0gTbud3ugrX
	 eU/ye0WmY5ezdNYTcUQrt9aAnVizmV4tHuuT2RTtIxsvLsN3ls9dKmQMHk64oXwjTg
	 FMxtnjCRvY8nyAnfVLT02GrEpYQKnlFm0bR80XgEqaOu/XwJQV84P/da5i2RUZFOa0
	 oSziD8bosDUmBNHgE/Y75BNAnzDQYVZtMgpWpq9kWPDZsirMS2VGdUBAcxU53iDybj
	 92i0/TbG1z/0Q==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b71397df721so310803366b.1
        for <kexec@lists.infradead.org>; Mon, 10 Nov 2025 01:24:07 -0800 (PST)
X-Gm-Message-State: AOJu0YzcdEDm12P+RxP9On2prGlRbU0mhWkuUtc8PgF4HUllx2uMhdX/
	549MR/5NHAVKKwW5hmVqgw/rgEMvrZ2lymtNheHrc37qW8G/SJc0HiMAdcuHs23AGawdWha9eZR
	qB+DThONzaSZ8n6JCKOfCs99KCZoP0Gw=
X-Google-Smtp-Source: AGHT+IECk/4a6nuss3sq4iYLcoOTG4x5u8UvQs/gVeLBKJJK9PsE0m+om6lErffOtsHGdZFaa7nKYC+Lh8LbT9AtDgM=
X-Received: by 2002:a17:907:96a6:b0:b72:6de0:44a1 with SMTP id
 a640c23a62f3a-b72e001a617mr645254166b.0.1762766646091; Mon, 10 Nov 2025
 01:24:06 -0800 (PST)
MIME-Version: 1.0
References: <20251024063653.35492-1-youling.tang@linux.dev>
In-Reply-To: <20251024063653.35492-1-youling.tang@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 10 Nov 2025 17:24:04 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6G0TRkXzg_6DZk3MLRni+w8M5tkm7MonckoQpvAtBzQQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnTXBzaL5_4R0BXD7sOHR-d5DocgfNKWbMfqTGXAOcgExSIa2bJBQuGIGY
Message-ID: <CAAhV-H6G0TRkXzg_6DZk3MLRni+w8M5tkm7MonckoQpvAtBzQQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: kexec: Initialize kexec_buf struct
To: Youling Tang <youling.tang@linux.dev>
Cc: kexec@lists.infradead.org, Breno Leitao <leitao@debian.org>, 
	Youling Tang <tangyouling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251110_012411_299977_61EC5FE5 
X-CRM114-Status: GOOD (  19.11  )
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

Applied, thanks.

Huacai

On Fri, Oct 24, 2025 at 2:38=E2=80=AFPM Youling Tang <youling.tang@linux.de=
v> wrote:
>
> From: Youling Tang <tangyouling@kylinos.cn>
>
> The kexec_buf structure was previously declared without initialization.
> commit bf454ec31add ("kexec_file: allow to place kexec_buf randomly")
> added a field that is always read but not consistently populated by all
> architectures. This un-initialized field will contain garbage.
>
> This is also triggering a UBSAN warning when the uninitialized data was
> accessed:
>
>         ------------[ cut here ]------------
>         UBSAN: invalid-load in ./include/linux/kexec.h:210:10
>         load of value 252 is not a valid value for type '_Bool'
>
> Zero-initializing kexec_buf at declaration ensures all fields are
> cleanly set, preventing future instances of uninitialized memory being
> used.
>
> Fixes: bf454ec31add ("kexec_file: allow to place kexec_buf randomly")
> Link: https://lore.kernel.org/r/20250827-kbuf_all-v1-2-1df9882bb01a@debia=
n.org
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
>  arch/loongarch/kernel/kexec_efi.c          | 2 +-
>  arch/loongarch/kernel/kexec_elf.c          | 2 +-
>  arch/loongarch/kernel/machine_kexec_file.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/loongarch/kernel/kexec_efi.c b/arch/loongarch/kernel/ke=
xec_efi.c
> index 45121b914f8f..5ee78ebb1546 100644
> --- a/arch/loongarch/kernel/kexec_efi.c
> +++ b/arch/loongarch/kernel/kexec_efi.c
> @@ -42,7 +42,7 @@ static void *efi_kexec_load(struct kimage *image,
>  {
>         int ret;
>         unsigned long text_offset, kernel_segment_number;
> -       struct kexec_buf kbuf;
> +       struct kexec_buf kbuf =3D {};
>         struct kexec_segment *kernel_segment;
>         struct loongarch_image_header *h;
>
> diff --git a/arch/loongarch/kernel/kexec_elf.c b/arch/loongarch/kernel/ke=
xec_elf.c
> index 97b2f049801a..1b6b64744c7f 100644
> --- a/arch/loongarch/kernel/kexec_elf.c
> +++ b/arch/loongarch/kernel/kexec_elf.c
> @@ -59,7 +59,7 @@ static void *elf_kexec_load(struct kimage *image,
>         int ret;
>         unsigned long text_offset, kernel_segment_number;
>         struct elfhdr ehdr;
> -       struct kexec_buf kbuf;
> +       struct kexec_buf kbuf =3D {};
>         struct kexec_elf_info elf_info;
>         struct kexec_segment *kernel_segment;
>
> diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/=
kernel/machine_kexec_file.c
> index dda236b51a88..fb57026f5f25 100644
> --- a/arch/loongarch/kernel/machine_kexec_file.c
> +++ b/arch/loongarch/kernel/machine_kexec_file.c
> @@ -143,7 +143,7 @@ int load_other_segments(struct kimage *image,
>         unsigned long initrd_load_addr =3D 0;
>         unsigned long orig_segments =3D image->nr_segments;
>         char *modified_cmdline =3D NULL;
> -       struct kexec_buf kbuf;
> +       struct kexec_buf kbuf =3D {};
>
>         kbuf.image =3D image;
>         /* Don't allocate anything below the kernel */
> --
> 2.43.0
>

