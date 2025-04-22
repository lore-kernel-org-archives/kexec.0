Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF02C369C2
	for <kexec@archiver.kernel.org>; Tue, 22 Apr 2025 19:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TFHH+AXI0H86T6bNTW6D4x3PwenT8a165qyV0Wm8vrk=; b=TXA/2hd4i/WN2FE5/s/cypSWnS
	ZSYRj8vd4uMbOsOMJOhzewghoY60cn6Bq//p8zCAbilfuSyyYVnxdFkH3WgxWuxajEDnvtIRl+ttk
	EXjKBhsV2PyT14HMxpwqb/HnUCaCoBBvCynEHoCfm7P2cWw7S/SghxNWDH3HhP91ICxHRbhk8MdY5
	oaSsK7eMVnyqsxLKn1YeQuT2hmCJ9ZyU7HJA8sFDqniMrcxwRlV8dQTzESvnnK139z5SMS0Su/7Hd
	VINZ6ZUtNhogSS4ppEqdQvP5lL/HR27ZAJA/EUk3P/tL3Womzn1tvYRKvb2qc5R7msH5FyUenhhLc
	bmGn/G0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7JaR-00000008LY5-3MbY;
	Tue, 22 Apr 2025 19:47:19 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7GOu-00000007tGT-3nEI;
	Tue, 22 Apr 2025 16:23:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 708AB449D7;
	Tue, 22 Apr 2025 16:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B96EC4CEE9;
	Tue, 22 Apr 2025 16:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745338990;
	bh=fmnPWHGmKfXb00sNiQ5Y3m9QDZ/IuALsEZL1zqyPKn8=;
	h=From:To:Cc:Subject:Date:From;
	b=d2rhna5EWqs8jeOiXQQ61AEfwkmfbRbmTx6Q5bNAoxDlHzK611elp7bwLHzjxxbc3
	 QRxpLp/lRWVqvyXr3aWJ5pfr88cFbmd7P5vu2wh6oIjsAnx20B8IXO1UdymVP0kITe
	 HMf2NBI6HU5/PCY+pmO8Jd5noJcFQEAxfbcSyhI3xE4BIPM8Y6n605ydv4yHGIAm/T
	 7H4+sqVaUpJKgrPHn95IHt/8OA8UgbXLu6akCZz9nGYfjLlPccm7Tb9yG0o51m2nNl
	 PvLFbSoWJSObSP0sks944BEb4mDgZJIOlLL9UwWbL9F7B2wmRgLRZ4df1xYLzOf7r5
	 9jgFG2osKXHkA==
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
Subject: [PATCH v2 0/4] kexec-tools RISC-V port
Date: Tue, 22 Apr 2025 18:22:56 +0200
Message-ID: <20250422162304.169431-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_092312_985218_01BBF271 
X-CRM114-Status: GOOD (  22.54  )
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

*Patch history*

v1: https://lore.kernel.org/kexec/20250409201428.648717-1-bjorn@kernel.org/
v2: Added Github Actions support for riscv64 (Simon)
    Sorted filenames in Makefile (Simon)
    Added missing dist files (Simon)
    Fixed mips build (Simon)

Here's a passed CI run with this series on master:
https://github.com/bjoto/kexec-tools/actions/runs/14597988952/job/40948715214


*Cover*

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

 .github/workflows/build.yml             |   1 +
 configure.ac                            |   3 +
 include/elf.h                           |   1 +
 kexec/Makefile                          |   1 +
 kexec/arch/mips/Makefile                |   2 +
 kexec/arch/riscv/Makefile               |  38 ++
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
 19 files changed, 1648 insertions(+), 1 deletion(-)
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


base-commit: 14f48ea80e510e5af79ca6c46fa28e99a3695d1c
-- 
2.48.1


