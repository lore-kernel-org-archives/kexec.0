Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBBACA0FE7
	for <kexec@archiver.kernel.org>; Tue, 26 Aug 2025 01:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=icSZngVaYlgp/7EJ4VaqjMZtnrg108Igob7ePxAT3/k=; b=RxY1NxX1piw4kZZZuv5P92Dhta
	Q90u8yBThow7eY0JIcYJ0ex0wH46TTsUHH67rSBXI9B0v7EW/qqSxKj72cB/MNLqvDkgZ0pSuoLSx
	8Wjf9oaIxJUInSwVuDVoc1gL3/cc5teRn5s6vyruX2RwYaMLOootMiqnMOL5Ek4arszLPxhRoAMiZ
	rf1pYZZvJUFyhOWLjP7wiTlRCwrK+ud8xGP5NBRzSfFJm4KKO5gPUkdwsoWeXlzR4nRnsW/4RHY5G
	QT2LLSlD9kuADswP8e+zFZMDGYNi9Co5NOWnZDzJZugkpS8CilKCFASDqLgMGp7CFx6cEaHeg3tdP
	dSrY509A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqiMH-0000000AHMX-1MRN;
	Tue, 26 Aug 2025 01:20:21 +0000
Received: from out-183.mta0.migadu.com ([91.218.175.183])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqiME-0000000AGuz-05Ye
	for kexec@lists.infradead.org;
	Tue, 26 Aug 2025 01:20:20 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756171092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=icSZngVaYlgp/7EJ4VaqjMZtnrg108Igob7ePxAT3/k=;
	b=WzxTJYS3m7yQhP551w9/Kg/ePr9rPszSJrbq63hWnz8jSZTHYCTw4ATmLzfqCyBpyRHZ1o
	n9Hv9lC0YbiKeUsUN9ie+RSsp8zDTeJloTZc1wGbs9tCeSZHCmLHlgLbPjoXaDY21K/SCs
	LlW+CDAM18EYD5nHCCrJLx7QgM7wHjc=
From: Youling Tang <youling.tang@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Baoquan He <bhe@redhat.com>,
	Yao Zi <ziyao@disroot.org>,
	kexec@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH v3 0/6] Add kexec_file support for LoongArch
Date: Tue, 26 Aug 2025 09:17:16 +0800
Message-Id: <20250826011722.82391-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250825_182018_200703_93CC7429 
X-CRM114-Status: GOOD (  10.47  )
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

From: Youling Tang <tangyouling@kylinos.cn>

This patchset implement kexec_file_load() support on LoongArch.

This patch series enables us to load the LoongArch vmlinuz.efi(pez) or
vmlinux.efi(pei) or vmlinux(elf) by specifying its file decriptor,
instead of user-filled buffer via kexec_load() syscall.

To use kexec_file_load() system call, instead of kexec_load(), at kexec
command, '-s' options must be specified. kexec-tools needs to apply the
corresponding patches. These patches can be found in repository [1] and
will be submitted to the kexec-tools community later.

The basic usage of kexec_file is:
1) Load second kernel image:
 # kexec -s -l vmlinuz.efi --initrd=initrd.img --reuse-cmdline

2) Startup second kernel:
 # kexec -e

For kdump:
1) Load capture kernel image:
 # kexec -s -p vmlinuz.efi --initrd=initrd.img --reuse-cmdline

2) Do something to crash, like:
 # echo c > /proc/sysrq-trigger

Link:
[1] https://github.com/tangyouling/kexec-tools/commits/main/

Changelog:
 v3:
 * The ELF format kernel loading should not use loongarch_image_header. 
 * Separate patch2 into an infrastructure patch and an EFI support
   patch.
 * Adding that kexec_file cannot load non-relocation kernel comments.
 * Some minor modifications.

 v2:
 * Merge some patches.
 * Add support for ELF format images.
 * Rename kexec_image.c to kexec_efi.c .
 * When KEXEC_FILE is enabled, RELOCATABLE is selected by default.
 * Some minor modifications.

Youling Tang (6):
  LoongArch: Add struct loongarch_image_header for kernel image
  LoongArch: Add preparatory infrastructure for kexec_file
  LoongArch/kexec_file: Support loading EFI binary file
  LoongArch/kexec_file: Support loading ELF binary file
  LoongArch/kexec_file: Add crash dump support
  LoongArch: Enable CONFIG_KEXEC_FILE

 arch/loongarch/Kconfig                     |  10 +
 arch/loongarch/configs/loongson3_defconfig |   1 +
 arch/loongarch/include/asm/image.h         |  57 +++++
 arch/loongarch/include/asm/kexec.h         |  13 ++
 arch/loongarch/kernel/Makefile             |   1 +
 arch/loongarch/kernel/kexec_efi.c          | 114 ++++++++++
 arch/loongarch/kernel/kexec_elf.c          | 105 +++++++++
 arch/loongarch/kernel/machine_kexec.c      |  37 ++--
 arch/loongarch/kernel/machine_kexec_file.c | 235 +++++++++++++++++++++
 9 files changed, 560 insertions(+), 13 deletions(-)
 create mode 100644 arch/loongarch/include/asm/image.h
 create mode 100644 arch/loongarch/kernel/kexec_efi.c
 create mode 100644 arch/loongarch/kernel/kexec_elf.c
 create mode 100644 arch/loongarch/kernel/machine_kexec_file.c

-- 
2.43.0


