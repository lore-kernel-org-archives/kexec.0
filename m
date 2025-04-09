Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2E3C36002
	for <kexec@archiver.kernel.org>; Wed,  9 Apr 2025 20:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MRdSYyaS/W3CK6XrhVYPpcVMm4BlyqJNT2wQAamS7Kc=; b=ZI5ELebsIiVtIgnk9eitw7RpbU
	N/xIb18wJG5Y3QS++CTN4WsoxxwQfIfvgp0rFfs8n4ihnKg3w7M2D+GVvddtwmelacdRaw3sA0xTd
	WdsULYzC5nMYPnyIdNXIdXhOEyjgtSUc0rFAJLLWfg6okxlSz4dcY17KB2AiJggNJnhxC5xbtBAo0
	y6fvqrpPqZ96O1hOoWojhswM5k9Uhkpe/Q44uRZJXgfJDciwcXZCgpBywND/S5LCEkEPcZzeb6wEn
	8oi94PPIGO2OJPsBP0J0R4ciOSvfVyQMd1IwVE0PbZ//nOP+bbSUJuF6hnY1TXd7IjuC9DTACYxR2
	yNUXLOuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2bou-00000008PGp-3TBt;
	Wed, 09 Apr 2025 20:14:48 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2bor-00000008PFp-35ns;
	Wed, 09 Apr 2025 20:14:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D1CB35C3F9F;
	Wed,  9 Apr 2025 20:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C72C4CEE2;
	Wed,  9 Apr 2025 20:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744229684;
	bh=LlL7ETnemEHvfYgu3SPg3PzIw528qt5LBfPb8SXM3hs=;
	h=From:To:Cc:Subject:Date:From;
	b=Q8P/3xlQyTULinXeR+OWeryOk+Z1P/7Iclfuv7myAEMgfK4UFmTH4NDny61QRT6H0
	 8moCoxoD8GlwA/cVPluckBFpn5KaviWUL/hb5OoXNC73+fUSERQPH6lUChNlb5unnf
	 2LPZGR5IDB6ZvY/iLBPf0ZzO3lDDF+TCFG7uGKMECjZ73zMP4H+DQFYzoMXn70xYTK
	 5kiuF9G2dRbGE97S17YVb1ikq0HWEr7L7bIoLgrgXDDQle9WrTtmt/CIgfjM/Dxi90
	 CIhE7F+EVV8Kr6fr15o4AizJnDRmboI0dqseypaE4ZjHGJFYbJbK3YEX7W/pVBSu9k
	 xR8ngMKO/mwqw==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Simon Horman <horms@kernel.org>,
	Simon Horman <horms@verge.net.au>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Song Shuai <songshuaishuai@tinylab.org>,
	Li Zhengyu <lizhengyu3@huawei.com>,
	kexec@lists.infradead.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Dave Young <dyoung@redhat.com>,
	Yixun Lan <yixun.lan@gmail.com>,
	Xianting Tian <xianting.tian@linux.alibaba.com>,
	linux-riscv@lists.infradead.org
Subject: [PATCH 0/4] kexec-tools RISC-V port
Date: Wed,  9 Apr 2025 22:14:22 +0200
Message-ID: <20250409201428.648717-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_131445_892027_F88781CA 
X-CRM114-Status: GOOD (  21.71  )
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

From: Björn Töpel <bjorn@rivosinc.com>

Hi!

This is an attempt to finally get the RISC-V patches for kexec-tools
upstream.

Simon suggested in [1] that:

> In my mind the big question is how to move RISC-V support from that
> branch, to being merged into main.
>
> IIRC there were some issues that needed to be addressed. Perhaps they
> are all addressed by this series, and with some appropriate squashing
> we can move forwards with a series based on main?

I talked to Nick last week, and he suggested that we'd work the RISC-V
collab Github [2], but I think it's just easier to do it on the list.

I've been collecting a number of different trees out there, and tried
to group them in a series.

Given that there is not support for RISC-V upstream yet, I didn't see
the need to carry all the fixes/updates ("development history") as
separate commits -- it doesn't help bugtracking/bisectability.

Instead the first commit message is a big one, and tries to give
attribution to all involved parties. Input/thoughts are very much
welcome!

To properly test this on RISC-V, the upstream Linux kernel has most
things in 6.15-rc1, e.g.:
commit 28093cfef5dd ("riscv/kexec_file: Handle R_RISCV_64 in purgatory relocator")
commit 3f7023171df4 ("riscv/purgatory: 4B align purgatory_start")

To cross-build kexec-tools:
  | ./bootstrap 
  | ./configure --host=riscv64-linux-gnu
  | make

For some tests, additional kernel patches are needed, that as of today
is not in 6.15-rc1:
 * To test "kexec -s -l Image", kexec_file_load with Image support is
   needed [3]
 * To test "kexec -c -l vmlinux" with CONFIG_RELOCATABLE, a kbuild fix
   is needed [4]
 * Typically if you load initrd, or a large kernel [5] (since a bunch
   of Reserved regions are not properly exposed).

I've tested combinations with crashkernel (-p), and regular (-c/-s + -e) for:
 * ACPI/UEFI
 * DT/UEFI
 * DT
 * w/ initrd
 * w/o initrd
 * ELF (userland loader + kexec_load, and kexec_file_load)
 * Image (userland loader + kexec_load, and kexec_file_load)

I'm sure there are combinations I've missed, but at least from my POV
we're in a pretty good shape.

All authors: Please let me know if you prefer another split of the
patches. Or something else for that matter! ;-)


Let's get the ball rolling!
Björn

[1] https://lore.kernel.org/kexec/20230920115634.GG224399@kernel.org/
[2] https://github.com/riscv-collab/kexec-tools.git
[3] https://lore.kernel.org/linux-riscv/20250409193004.643839-1-bjorn@kernel.org/
[4] https://lore.kernel.org/linux-riscv/20250408072851.90275-1-alexghiti@rivosinc.com/
[5] https://lore.kernel.org/linux-riscv/20250409182129.634415-1-bjorn@kernel.org/

Li Zhengyu (1):
  RISC-V: Enable kexec_file_load syscall

Nick Kossifidis (1):
  RISC-V: Add support for riscv kexec/kdump on kexec-tools

Song Shuai (2):
  RISC-V: Separate elf_riscv_find_pbase out
  RISC-V: Support loading Image binary file

 configure.ac                            |   3 +
 include/elf.h                           |   1 +
 kexec/Makefile                          |   1 +
 kexec/arch/riscv/Makefile               |  37 ++
 kexec/arch/riscv/crashdump-riscv.c      | 140 +++++++
 kexec/arch/riscv/image-header.h         |  88 ++++
 kexec/arch/riscv/include/arch/options.h |  43 ++
 kexec/arch/riscv/iomem.h                |  10 +
 kexec/arch/riscv/kexec-elf-riscv.c      | 184 +++++++++
 kexec/arch/riscv/kexec-image-riscv.c    |  95 +++++
 kexec/arch/riscv/kexec-riscv.c          | 526 ++++++++++++++++++++++++
 kexec/arch/riscv/kexec-riscv.h          |  53 +++
 kexec/dt-ops.c                          | 442 +++++++++++++++++++-
 kexec/dt-ops.h                          |   7 +
 kexec/kexec-syscall.h                   |   7 +
 purgatory/Makefile                      |   1 +
 purgatory/arch/riscv/Makefile           |   7 +
 17 files changed, 1644 insertions(+), 1 deletion(-)
 create mode 100644 kexec/arch/riscv/Makefile
 create mode 100644 kexec/arch/riscv/crashdump-riscv.c
 create mode 100644 kexec/arch/riscv/image-header.h
 create mode 100644 kexec/arch/riscv/include/arch/options.h
 create mode 100644 kexec/arch/riscv/iomem.h
 create mode 100644 kexec/arch/riscv/kexec-elf-riscv.c
 create mode 100644 kexec/arch/riscv/kexec-image-riscv.c
 create mode 100644 kexec/arch/riscv/kexec-riscv.c
 create mode 100644 kexec/arch/riscv/kexec-riscv.h
 create mode 100644 purgatory/arch/riscv/Makefile


base-commit: a7fcd424c4c80dea5a2fd5ffa274ffeb8129c790
-- 
2.45.2


