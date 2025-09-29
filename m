Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADD1CAC5B0
	for <kexec@archiver.kernel.org>; Mon, 29 Sep 2025 09:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tKS30ulNmYtXnmwJk38VBTUSwHLV8oBqH30F7ZsYbuA=; b=FVDc6k+T6CnFGnzSoWfSTieib0
	k6I6RUTUTlPQJ+ch9iyJaQdBg6zuSsds2F+wQmPbtE+I2chWhqfbUn3y/fE37Am8jlRnuCIscX1fk
	6FD9sCIEP0wteW0T498pEaDaXjMpv+sYyFDsP20rC8M0UrcUmWPZfuxYtFAlugUXyk2trib2TovR7
	iGzL4JFEFllvouatlUEMcK0ePHpIp4g8JpgZ10JGLQ6nnOwS6cSolM/lFrquVK9bvHiQjYNkCZxRl
	tq0DzpfFwaXQL604vrE4d9T55YtzSeyryenaUt/qqD3mnZt5cKfgPA1VRt/lkLxCl3zkqaUFcTulh
	m7BOvQAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3Aac-000000023R0-2fA5;
	Mon, 29 Sep 2025 09:54:38 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3Aa3-000000023Pn-0QCK
	for kexec@lists.infradead.org;
	Mon, 29 Sep 2025 09:54:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C7AD74416E
	for <kexec@lists.infradead.org>; Mon, 29 Sep 2025 09:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFB5C4CEF4
	for <kexec@lists.infradead.org>; Mon, 29 Sep 2025 09:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759139642;
	bh=tKS30ulNmYtXnmwJk38VBTUSwHLV8oBqH30F7ZsYbuA=;
	h=Date:From:To:Subject:From;
	b=awDOmtBf3/SLm8ggdHbRvGrRgCWEhJ2ZtuQMuhy1orQXdpDKml8uDnXKcI1PQAAms
	 rbFHZ2sv3cckjSvSSGh2wB2dWcx0rZPxrzWsTxwvjRNq6cu0FzR+yDHtq35y+E/CvY
	 zZisLoFjo188r+OHRZzBUwyoNtCQvXKUjxTOelBJv0K9krFR3dZJoTiavXmuL7gMzs
	 4NLh4LHs3Wl+RjT50MHzXicS93LvX+0/LoDlqvWqEYqSOjGMrrCnrg3Ts4TIqkA4+R
	 fsNRVjrhobnQDvD7TEIWG2Q7tFfPnWiA6wp5aWEaObmVpK7S4bM9Z2fOmTBk71gY3M
	 qHTokBtOt7+Fw==
Date: Mon, 29 Sep 2025 10:53:59 +0100
From: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
Subject: [ANNOUNCE] kexec-tools v2.0.32 preparation
Message-ID: <aNpXN0ux-p8_qnR3@horms.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250929_025403_155459_8DD4961E 
X-CRM114-Status: UNSURE (   8.90  )
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

I am planning to release kexec-tools v2.0.32 in the next two weeks
to roughly coincide with the release of the v6.17 kernel.

I would like to ask interested parties to send any patches they would like
included in v2.0.32 within one week so they can be considered for inclusion
in an rc release.

For reference the patches queued up since v2.0.31 are as follows.

Thanks to everyone who has contributed to kexec-tools!

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



