Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7F9CCD188
	for <kexec@archiver.kernel.org>; Thu,  9 Oct 2025 10:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hzndvEVzlFjyo2djLG9sc91jwnzdHEiWx1ZdoZZfwzo=; b=JY3fkdMb1XCAlATCkA91vBn+s5
	Yo6mqnydYXWI8+JbOSPJe4n+dcZeAZTlNWBcVbANj9RWgTwbRONBlIQZ9setA+ykXLh3s/GT7J+zf
	m0U4Rx/xMlX7Tbgl4VXjLOUuA5mrDB00W7WyyYO5NEwdMVtY339L74QWZhARsL4OLkdBKcULeBBTO
	gc/UNqisA65Vl5EYt7Fniz/jQkik/bqyKFxBuEt81PYXwOCmmOsOiF5vbBlc1zkXJ1fC+36OFUzuG
	X0MpyOYup74HkwefeSL0SWZJz+PBMcMnijqqeEDVIOLBvd9hsJSC0oLcGIN/FpbY1tEM97rGn0Ycb
	8WQrtpPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6nYQ-00000005k1F-1pt1;
	Thu, 09 Oct 2025 10:07:22 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6nYP-00000005k0n-3nBX
	for kexec@lists.infradead.org;
	Thu, 09 Oct 2025 10:07:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3944F60553
	for <kexec@lists.infradead.org>; Thu,  9 Oct 2025 10:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF7CC4CEF5
	for <kexec@lists.infradead.org>; Thu,  9 Oct 2025 10:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760004440;
	bh=6DuCGf1KNb8PyshSvWP8bfEqbnIRIVPuPXfSkjMOses=;
	h=Date:From:To:Subject:From;
	b=JOHyBXyC+9MwU70NppTLFPcGrvUlNiCNqTwrGPdXMK+/aHvE1kkjE+PZuGQ85dJgm
	 /a5TkVzERS8RxeH3JTLC4kc9HTOOfVtBsywGSNW+CZE+Rr92hkTN4c0457mOGmMCrn
	 PjvqB5KS7Lh9Jm0AUkOXENZxAgmDliWhKtRyC+PMlquXuIqFWdo8/ULeN8bMNPRMbr
	 /H2t7+Wtef+vdY/e9s3CUbXK88zHQR+XC2svmpoxGdtkZF77x2MXNgvnt0UzGouNZo
	 H2G67dOsNQnv2DuYZaX4lX9fatbYs+YywYYQBb9SPigYBocxiy2StiW/9F14wkofQm
	 Qk+emxgbwhRDA==
Date: Thu, 9 Oct 2025 11:07:18 +0100
From: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
Subject: [ANNOUNCE] kexec-tools 2.0.32-rc1
Message-ID: <20251009100718.GW3060232@horms.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

I am happy to announce the release of kexec-tools 2.0.32-rc1.

This is an incremental feature pre-release.

So long as no serious problems arise I intend to release kexec-tools 2.0.32
in a weeks time. Testing of 2.0.32-rc1 would be greatly appreciated.

I do not have any outstanding changes for 2.0.32 at this time.
And I would like to only accept bug fixes at this time and take
features patches once 2.0.32 has been released.

The pre-release can be downloaded from kernel.org:

	https://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.32-rc1.tar.xz
	https://kernel.org/pub/linux/utils/kernel/kexec/

I have also tagged it in git:

	https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Thanks to everyone who has contributed to kexec.


For reference the changes since v2.0.31 are:

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

