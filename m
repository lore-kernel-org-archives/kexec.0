Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B87CA0FED
	for <kexec@archiver.kernel.org>; Wed,  3 Sep 2025 03:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=isX+w1aFzVbrn4Ce/5g4IRvZrErGccZqzEtiZvEOUeY=; b=IoSKHCW+k71ypFF8VzAoVG7eU1
	TJeUI6Y738LqO5oBQpAXZubOdrlQPBfDt64DOXwxeKhWO88ngKRKLPKA9VDAYcVAMc1B00t2piwTM
	SA0Fo8N23Nz8U7B83WEEzkJJUhrueLf/3QyPxbOTg/PT4LwqpCujhtkp4EWRmFhRuz5Q2azzJE44Q
	JJmWLIYcbkxS45BA0/FV/VUiRIG8HDEOjcdaUyrz6G5vhpAXxi0dM/eTOw44irrv4eXNf7RhOASsr
	UsHG/hL5wmjd+9l1hHCG9U8kUsaNIR7lyNNmZP0ZRtf8Z6UezQSHvBPCTz1BJgvxKfEjf1R6N37yY
	OqH/DqJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utdlP-00000003Qxk-0UEF;
	Wed, 03 Sep 2025 03:02:23 +0000
Received: from out-171.mta0.migadu.com ([2001:41d0:1004:224b::ab])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utdlJ-00000003Qv1-2T3g
	for kexec@lists.infradead.org;
	Wed, 03 Sep 2025 03:02:19 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756868532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=isX+w1aFzVbrn4Ce/5g4IRvZrErGccZqzEtiZvEOUeY=;
	b=KoprB8mxeXimFmXxZztGdBzZMgr3tlMB2BKekvN9qZ+dnvZKlU26qQSsOGfJWdq7Uw5ut9
	Cf1JLuLQ2BfZ9ZrfB9D7gigjHSXQDOaWS0QXlJQHsxG1F1oCZpMsqGVR/+R7kU+LhGMxjf
	mbBuMsHH85j9krbvOhWwgtnlx4ir3Ao=
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
Subject: [PATCH v4 0/7] Add kexec_file support for LoongArch
Date: Wed,  3 Sep 2025 11:00:53 +0800
Message-Id: <20250903030100.196744-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250902_200217_837794_319E59BF 
X-CRM114-Status: GOOD (  12.50  )
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
 v4:
 * Add the character "kexec_file" to the command-line parameter.
 * Fixed the issue where kexec_file failed to load the KASLR kernel
   startup.
 * Modify the member name of the loongarch_image_header structure.
 * Modify the patch commit message.

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

Youling Tang (7):
  LoongArch: Add struct loongarch_image_header for kernel image
  LoongArch: Add preparatory infrastructure for kexec_file
  LoongArch/kexec_file: Support loading EFI binary file
  LoongArch/kexec_file: Support loading ELF binary file
  LoongArch/kexec_file: Add crash dump support
  LoongArch: Automatically disable kaslr when the kernel loads from
    kexec_file
  LoongArch: Enable CONFIG_KEXEC_FILE

 arch/loongarch/Kconfig                     |  10 +
 arch/loongarch/configs/loongson3_defconfig |   1 +
 arch/loongarch/include/asm/image.h         |  53 +++++
 arch/loongarch/include/asm/kexec.h         |  13 ++
 arch/loongarch/kernel/Makefile             |   1 +
 arch/loongarch/kernel/kexec_efi.c          | 114 ++++++++++
 arch/loongarch/kernel/kexec_elf.c          | 105 +++++++++
 arch/loongarch/kernel/machine_kexec.c      |  37 ++--
 arch/loongarch/kernel/machine_kexec_file.c | 244 +++++++++++++++++++++
 arch/loongarch/kernel/relocate.c           |   4 +
 10 files changed, 569 insertions(+), 13 deletions(-)
 create mode 100644 arch/loongarch/include/asm/image.h
 create mode 100644 arch/loongarch/kernel/kexec_efi.c
 create mode 100644 arch/loongarch/kernel/kexec_elf.c
 create mode 100644 arch/loongarch/kernel/machine_kexec_file.c

-- 
2.43.0


