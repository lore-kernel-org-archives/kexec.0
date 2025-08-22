Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8B8CA0EFF
	for <kexec@archiver.kernel.org>; Fri, 22 Aug 2025 12:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2gD+0MmSeodnH0Q/OVqZujjzsh7aHwaOOixfm825iYU=; b=RblqD8CzJfyHMYSLrYGntXT9Br
	XcnjOHXLDXFxHbUqspTIlqbrkQ5/u29rWmIwNUv6dZJc+m8ePq6SU6v9uMAukmRZfIOXKIKEm+yM+
	L4t9MeWreeTb41hlfbNP/rXoMucOLwdc4xW7qo6IPjpYBW89GnrNR67jgOticp7F4EQtgkDKrPY7Z
	8NDdKA8CA4JpNmKYjmcLF7yubPk6jHtrvjNblTE1qd7UIaVH974G7XOYaKZ2E21JrIc1mf5ENlM9E
	3+kPBP5vhmyQGN5//KXUjFZqgBLDlDsRYoaUO2eBT4hAm/LX0dTdgdlUl5Am/XLn/LTJaenR554rP
	oKy+x9Kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upRCl-00000002XML-3fu3;
	Fri, 22 Aug 2025 12:49:15 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upJ9o-00000001Tzt-3YN3
	for kexec@lists.infradead.org;
	Fri, 22 Aug 2025 04:13:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4EEFAA587C9
	for <kexec@lists.infradead.org>; Fri, 22 Aug 2025 04:13:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F09C116B1
	for <kexec@lists.infradead.org>; Fri, 22 Aug 2025 04:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755836019;
	bh=yb76Z7Ykma61gCy+9MNVKgDDs9hMvaduu7vLFLdozcM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WJzzj8k+eyg5znnUWq4fKHUKGoMsHjV3xLGW7k30rL8DTGzo4b9O0S2SL9yEBWtuM
	 sa76DGJTEliGt8Q7mKRW0aGgyRaIkWJ7/Gulb2bgFgzbZw6vU1wglOxcmVNU5KqdSF
	 M9dDiSIYUMXZgU7baK4c8BYQ3mG6sU3kISNznSISYN50ejJSfgj04sPWWz3CD1RFUK
	 wgLWd/wFp4/fc6BWXMAR2esakMFptRpPrDK6B9dp8dK2Gj1R/p5F+FP73LEQXVhymp
	 aX6UMcFbMD9/AdRuMRKBLS6xtHUD2RzOnnkOBD7z8f8l4ulLsDXA3vCBv66TG4GVcm
	 7Km5RRevsidHg==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb7a3b3a9so237129766b.2
        for <kexec@lists.infradead.org>; Thu, 21 Aug 2025 21:13:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWS1pwEWu8fijRdkkz091LV7cu577tiNk4CFAMYgzV1sjb90bav4nB3lUZuvwNNtPST45Bj+Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YxUVNeE7cihtnr8sw8Gisjt1BUDsDNUD4sgT7hs4BdvSb/LdoZu
	SQaFbDleXgjKnMngbqdf91q0nfxEwBPWPTUgtRzrR8UeD5BLnAs5duvwmvdNivu50B8l8xqd0sd
	AOgVa/tcrQwrUn5qkfpPVDTakgqoAJIA=
X-Google-Smtp-Source: AGHT+IEFuMcrqOC0a5CuS2+a1amqyQQ3UsKWwufqZnldyK0rganAdUmsu3sfje9HY72xiVnlqQSe1dyt3NpW1FUyf7c=
X-Received: by 2002:a17:907:7e8d:b0:afd:d994:cb0 with SMTP id
 a640c23a62f3a-afe294ced48mr137970166b.62.1755836017510; Thu, 21 Aug 2025
 21:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250820055700.24344-1-youling.tang@linux.dev>
In-Reply-To: <20250820055700.24344-1-youling.tang@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 22 Aug 2025 12:13:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H75tsJkHC9DgCOOBbFjbK--B_LRRCP5PcZr6nHqwKHL1Q@mail.gmail.com>
X-Gm-Features: Ac12FXxQ-yitmfFcJhpiv0kKjoJLco4W_rhyVcuIHjasvZBYLMaHXTbBasKgxa8
Message-ID: <CAAhV-H75tsJkHC9DgCOOBbFjbK--B_LRRCP5PcZr6nHqwKHL1Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Add kexec_file support for LoongArch
To: Youling Tang <youling.tang@linux.dev>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>, Yao Zi <ziyao@disroot.org>, 
	kexec@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_211341_020607_71F6C7E5 
X-CRM114-Status: GOOD (  18.47  )
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

Hi, Youling,

On Wed, Aug 20, 2025 at 1:57=E2=80=AFPM Youling Tang <youling.tang@linux.de=
v> wrote:
>
> From: Youling Tang <tangyouling@kylinos.cn>
>
> This patchset implement kexec_file_load() support on LoongArch.
>
> This patch series enables us to load the LoongArch vmlinuz.efi(pez) or
> vmlinux.efi(pei) or vmlinux(elf) by specifying its file decriptor,
> instead of user-filled buffer via kexec_load() syscall.
>
> To use kexec_file_load() system call, instead of kexec_load(), at kexec
> command, '-s' options must be specified. kexec-tools needs to apply the
> corresponding patches. These patches can be found in repository [1] and
> will be submitted to the kexec-tools community later.
>
> The basic usage of kexec_file is:
> 1) Load second kernel image:
>  # kexec -s -l vmlinuz.efi --initrd=3Dinitrd.img --reuse-cmdline
>
> 2) Startup second kernel:
>  # kexec -e
>
> For kdump:
> 1) Load capture kernel image:
>  # kexec -s -p vmlinuz.efi --initrd=3Dinitrd.img --reuse-cmdline
>
> 2) Do something to crash, like:
>  # echo c > /proc/sysrq-trigger
>
> Link:
> [1] https://github.com/tangyouling/kexec-tools/commits/main/
>
> Changelog:
>  v2:
>  * Merge some patches.
>  * Add support for ELF format images.
>  * Rename kexec_image.c to kexec_efi.c .
>  * When KEXEC_FILE is enabled, RELOCATABLE is selected by default.
>  * Some minor modifications.
>
> Youling Tang (5):
>   LoongArch: Add struct loongarch_image_header for kernel image
>   LoongArch: Add kexec_file support
>   LoongArch/kexec_file: Support loading ELF binary file
I prefer to combine Patch-2 and Patch-3. :)

Huacai

>   LoongArch/kexec_file: Add crash dump support
>   LoongArch: Enable CONFIG_KEXEC_FILE
>
>  arch/loongarch/Kconfig                     |  10 +
>  arch/loongarch/configs/loongson3_defconfig |   1 +
>  arch/loongarch/include/asm/image.h         |  57 +++++
>  arch/loongarch/include/asm/kexec.h         |  13 ++
>  arch/loongarch/kernel/Makefile             |   1 +
>  arch/loongarch/kernel/kexec_efi.c          | 111 ++++++++++
>  arch/loongarch/kernel/kexec_elf.c          | 105 +++++++++
>  arch/loongarch/kernel/machine_kexec.c      |  33 ++-
>  arch/loongarch/kernel/machine_kexec_file.c | 235 +++++++++++++++++++++
>  9 files changed, 555 insertions(+), 11 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/image.h
>  create mode 100644 arch/loongarch/kernel/kexec_efi.c
>  create mode 100644 arch/loongarch/kernel/kexec_elf.c
>  create mode 100644 arch/loongarch/kernel/machine_kexec_file.c
>
> --
> 2.43.0
>

