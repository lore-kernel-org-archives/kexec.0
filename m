Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA28CAC59A
	for <kexec@archiver.kernel.org>; Sun, 21 Sep 2025 14:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K57TZx8/W4AbwaGt5vc72kzD3fkMoXR1EdUTb/3bio0=; b=Dbbk6UPUuAFVTD4ZM4Q8/tCKcE
	0PnsB2quEvaL1HIAp8DaLfH2fQuUsWKNeZzUZJMK48R49RAHUBwAaGeRyKjv5AUvU8Ze3E+UrIU24
	3mrzdQZ/yYWJOg7xOi9T76+3lBZnrLxUXd5Fdjt/9zxOW1Y0n5Z5XA9B9T7NybJy2ECQQgUwFU7tB
	kEXj7uDpZxTH387iYfHEPiwIVI6LfaK1mNGCraRqPtA9yaKLObl/itMZCMHQfjVAwEJHIIGHMpk12
	UAis9ZXacta/fwjJdZIaPdB82MBq6Pj7n8BVVjrYw7pw8c4x9c2OWZBtXnKTZRJYn6jakXhTcLdfF
	sG3Iyebg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0KfG-00000007ZcF-1nuG;
	Sun, 21 Sep 2025 14:03:42 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0KfD-00000007Zbq-3Mcv
	for kexec@lists.infradead.org;
	Sun, 21 Sep 2025 14:03:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0D49944D59
	for <kexec@lists.infradead.org>; Sun, 21 Sep 2025 14:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FEEC116C6
	for <kexec@lists.infradead.org>; Sun, 21 Sep 2025 14:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758463416;
	bh=Dii3XVV3GqFGsvIpQHJXuB3JBENZx3cw7QxToan9g2A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GLZ7+1rE9YpZL9dDgv4EWsCmZtrfxY9jZ01tUHgxjrJzPBSEoeHMukNsYJTId3qzo
	 2XSMzvOkX1C36xp8+iXOUYul+NiR/W55AxzHiko6LlnVr6uKQByrwO0hvK7UB86jjE
	 57q2GDg+YZUNmknrJe9o+8IjrJUTRCr8GsiwTb/sCrUbCw42XBGOEuQiAsZPAzqcRR
	 svOXjyWynn+8zl4s1zWql2bCFPTwHLWUFniv2SQ0j0Y7TYaUBNuJkIQUmD6pZCq3W/
	 Gh6XjssCZOS8Qr6zItak+VNVkLJIelavMq/gQSNo11he3Kd4cxRRXozqZUegKf1Mfq
	 /B6b8P0eN++rQ==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b042eb09948so609465566b.3
        for <kexec@lists.infradead.org>; Sun, 21 Sep 2025 07:03:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZcyAN5HAeovZWtp/disqht36IIP48XKSz9um1pNm2v/8lvsEWch4NlQQTyoBFRpljK6mLTQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwUuqNriFulRh5sCJE+seheVQtE+deDUueCXMSusGjHYTfzGrke
	e7ceHuZLLSlXMapd/Oex+cBEcJQyk1+aQaF8orDYb/FbNusxWH5IenMglbdLqZz942/NGpAQdUI
	ZVXWsXCOmNZ55VwMvCW+3yBwMtKP8hM4=
X-Google-Smtp-Source: AGHT+IEJY9pRCOQ9ba+DERLtt5IlKiSfTxj+DOQMubiAwVQ0XJ0uKpMlJPHMt7g8wlCII+jXBu1TfMjByYNPDasXSXs=
X-Received: by 2002:a17:907:9449:b0:b04:806b:c612 with SMTP id
 a640c23a62f3a-b24ee6ef5c6mr1122778866b.10.1758463415400; Sun, 21 Sep 2025
 07:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250903030100.196744-1-youling.tang@linux.dev>
In-Reply-To: <20250903030100.196744-1-youling.tang@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 21 Sep 2025 22:03:19 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5LnRruyzdxR26Sopot4HoAwsGJ=kQKr4D=gRmW4t1R0Q@mail.gmail.com>
X-Gm-Features: AS18NWDUaq5tytPXMFw7v4wdbczyDPhFJ5b_iiVJqz7-XJetSXZrcs_y8_quLOw
Message-ID: <CAAhV-H5LnRruyzdxR26Sopot4HoAwsGJ=kQKr4D=gRmW4t1R0Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Add kexec_file support for LoongArch
To: Youling Tang <youling.tang@linux.dev>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>, Yao Zi <ziyao@disroot.org>, 
	kexec@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250921_070339_882718_DDA7C1F2 
X-CRM114-Status: GOOD (  20.86  )
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

Applied with some modifications. You may need to test whether everything is=
 OK.
https://github.com/chenhuacai/linux/commits/loongarch-next

Huacai

On Wed, Sep 3, 2025 at 11:02=E2=80=AFAM Youling Tang <youling.tang@linux.de=
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
>  v4:
>  * Add the character "kexec_file" to the command-line parameter.
>  * Fixed the issue where kexec_file failed to load the KASLR kernel
>    startup.
>  * Modify the member name of the loongarch_image_header structure.
>  * Modify the patch commit message.
>
>  v3:
>  * The ELF format kernel loading should not use loongarch_image_header.
>  * Separate patch2 into an infrastructure patch and an EFI support
>    patch.
>  * Adding that kexec_file cannot load non-relocation kernel comments.
>  * Some minor modifications.
>
>  v2:
>  * Merge some patches.
>  * Add support for ELF format images.
>  * Rename kexec_image.c to kexec_efi.c .
>  * When KEXEC_FILE is enabled, RELOCATABLE is selected by default.
>  * Some minor modifications.
>
> Youling Tang (7):
>   LoongArch: Add struct loongarch_image_header for kernel image
>   LoongArch: Add preparatory infrastructure for kexec_file
>   LoongArch/kexec_file: Support loading EFI binary file
>   LoongArch/kexec_file: Support loading ELF binary file
>   LoongArch/kexec_file: Add crash dump support
>   LoongArch: Automatically disable kaslr when the kernel loads from
>     kexec_file
>   LoongArch: Enable CONFIG_KEXEC_FILE
>
>  arch/loongarch/Kconfig                     |  10 +
>  arch/loongarch/configs/loongson3_defconfig |   1 +
>  arch/loongarch/include/asm/image.h         |  53 +++++
>  arch/loongarch/include/asm/kexec.h         |  13 ++
>  arch/loongarch/kernel/Makefile             |   1 +
>  arch/loongarch/kernel/kexec_efi.c          | 114 ++++++++++
>  arch/loongarch/kernel/kexec_elf.c          | 105 +++++++++
>  arch/loongarch/kernel/machine_kexec.c      |  37 ++--
>  arch/loongarch/kernel/machine_kexec_file.c | 244 +++++++++++++++++++++
>  arch/loongarch/kernel/relocate.c           |   4 +
>  10 files changed, 569 insertions(+), 13 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/image.h
>  create mode 100644 arch/loongarch/kernel/kexec_efi.c
>  create mode 100644 arch/loongarch/kernel/kexec_elf.c
>  create mode 100644 arch/loongarch/kernel/machine_kexec_file.c
>
> --
> 2.43.0
>

