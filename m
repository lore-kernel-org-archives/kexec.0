Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00380CCD183
	for <kexec@archiver.kernel.org>; Thu, 16 Oct 2025 08:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=C1Duh4QCFHeZIPUyGEpMdJwJnINrIQD13crg/F5L+io=; b=eoE2/FHx8Z8FXdDNdy/wgVopTk
	co11u9bWQ88lsrW2dxbAOdnt5KWdfaPj4cOec2qaoJTLre6M/SSqG/N6oFE9ug8+HcSvwHhktRloO
	GfKbLARF1wMCLum8jSxT9v+liFN7hpXdbENnSIfI68eXFSjZQVrhilaTBP8Ku/ysNvp6Nq39oJ5PB
	c3HhGWCXRdXXAnzyx5GTDt1KK/Da84AZorGv7HpL4Fn9oyYWGX/ZHQN7NaUCjeiptGvlbotMotOu9
	uypJInmdbR3GObXGyfMfBaRuF+AN7z0XXntf+qH46rAtTwbLbZXWMEu0HK6pPTSDrDHvsnCNq4JaY
	4qAbpMpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9JKE-00000003vn7-1p59;
	Thu, 16 Oct 2025 08:27:06 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9JK8-00000003vm3-0plA
	for kexec@lists.infradead.org;
	Thu, 16 Oct 2025 08:27:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9A2A442B87
	for <kexec@lists.infradead.org>; Thu, 16 Oct 2025 08:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A606C4CEF1
	for <kexec@lists.infradead.org>; Thu, 16 Oct 2025 08:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760603219;
	bh=eBl64WLERobdXDyDS0UJb0KWsbN36B8vu7EM33AcIeM=;
	h=Date:From:To:Subject:From;
	b=UxIw2A9bSIXYO3oiUF0hMyn4rDRJN1T7K2D0Bzq318VmhKWbouhqhYhCaRBAv6635
	 NnEyBHcoWkxO80r+jMaby07ZzigYmjV6Tk5zZ3KHYCwzT450gs5Ws7JsurzVAI2Otp
	 IFmGQjlxqVmddp/ueUIHyacvzkrN9JNIU5p6+vy8hyTUW3cwsfG57tt//VzxzqOHIs
	 MG/9Y/iuUNlpPZmUrG3tqlaumG5G5JUZ643jupIazDT02XrAhZDR4EGdoFiQ14C6gu
	 OZhAxv3rd4/uaNEv98g/M791IkdKPt2XgtMTO6SrLMSdFn74BKTXKjCwWKB1MkWM1o
	 xwogUjrCHlh4g==
Date: Thu, 16 Oct 2025 09:26:57 +0100
From: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
Subject: [ANNOUNCE] kexec-tools 2.0.32
Message-ID: <aPCsUWfUnwjV3vaQ@horms.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251016_012700_258326_51262EAF 
X-CRM114-Status: UNSURE (   7.96  )
X-CRM114-Notice: Please train this message.
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

Hi all,

I am happy to announce the release of kexec-tools 2.0.32.

This release can be downloaded from kernel.org:

	http://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.32.tar.xz
	http://kernel.org/pub/linux/utils/kernel/kexec/

It is also tagged it in git:

	git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Thanks to everyone who has contributed to kexec!

Commits since v2.0.31:

15d78e5799ee kexec-tools 2.0.32
63a6986d7aae kexec-tools 2.0.32-rc1
591ebf60649d COPYING: Update with current text for GPL v2
2842172e1405 kexec/arch/arm64/crashdump-arm64.c: remove extra whitespace
c343815e7e0a kexec/arch/i386/kexec-x86-common.c: remove duplicate <stdio.h>
b7b2a13547a0 util_lib/elf_info.c: fix typo: prink -> printk
9c12e71d712a kexec/arch/i386/x86-linux-setup.c: replace %d with %u
c837f1971fab kexec/kexec-elf-exec.c: Replace %lux with %lx
288e352ed7c8 Fix printf string specifiers, otherwise kexec doesn't work on my laptop
0b5aecb85a21 workflow: Add loongarch64 build
efb97b509b1a Make the segment base match pinned section address
19d1b275c649 LoongArch: Remove 'kexec_file' cmdline parameters when using --reuse-cmdline option
f1d66280a48b LoongArch: Add kexec_file_load syscall
b7c35c42c3db LoongArch/pez: Fix kernel_fd handling when kexec_file is supported
13e701e72ecf LoongArch: Add pe_hdr->machine check for pei format images
919005b26c8f LoongArch: Fix the use of loongarch_image_header in ELF format
2d3f8185f5d7 LoongArch: Change initrd allocation to top-down
024073e74dc7 LoongArch: Enforce relocatable kernel check for crash dump
d9c82c188646 LoongArch: Terminate the cmdline string using '\0'
e2bfd6df147c LoongArch: Fix comments
39ba2bd288af kexec: Handle removal of multiple 'crashkernel' parameters
b8f6c2a98d2c LoongArch: Change COMMAND_LINE_SIZE to 4096
daa29443819d kexec/zstd: fix static zstd build
8322826fa7b0 kexec/zboot: Add boundary check on PE header offset
b257f311f5f0 RISC-V: Support loading Image binary file
363087cd156f RISC-V: Separate elf_riscv_find_pbase out
027e6e237427 RISC-V: Enable kexec_file_load syscall
b3fd54b022fe RISC-V: Add support for riscv kexec/kdump on kexec-tools
1bda78d60504 workflow: update to Ubuntu 24.04
14f48ea80e51 x86_64: Use the x86-64 level for purgatory
3baa1baebf91 kexec-tools 2.0.31.git

