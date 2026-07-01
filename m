Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0729C43602
	for <kexec@archiver.kernel.org>; Wed,  1 Jul 2026 16:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=k3HcLqq2aTerbmtBhhltkPQXOZSuVLdnfZzN0/Swmac=; b=hRTZa/ze135t+bUnqEQFv2lgtz
	SOemxN8vl2hXSVSqNq844z1qi7YXrXwtQyAhHQNP06Q1VM20lIBlfak03bFRR6Ih2BgZ83xIwurWV
	VhNWSYFaptg/PaxC+drb1EWAaDlTm+RK9opve5iQEqQq60+KgfOhu0AnPFmtMa7K2zqS/m53fkIac
	VqVogbBFqJIRCf+2tBInB9Os2Bd3X9gPop+6Bflsg3RJxzrg0VfcPV9cvkamDVMr+pZ4ktAFZzBTN
	0YBXVjnbf2LBq+kGT+wgeuHJ/tz7oTgkrrsRp/mfDMqKLVwngTdjIMQjgO3sn5K8XlOeN/NGgsuMi
	FvKtMWjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wexMb-00000002SYb-3r2p;
	Wed, 01 Jul 2026 16:00:37 +0000
Received: from out-170.mta1.migadu.com ([95.215.58.170])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wexMT-00000002SX5-2EHz
	for kexec@lists.infradead.org;
	Wed, 01 Jul 2026 16:00:36 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782921624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k3HcLqq2aTerbmtBhhltkPQXOZSuVLdnfZzN0/Swmac=;
	b=VXcYUQcWxR0y+9Fhk7vxWusk8DYMv804l+P0F3guxSUGgwYyCYXk90jaQdzFPXWuqmEJ8b
	jwZTRWBz8FwbBa7G0pM1QK3W3Ehax1VeR8kItjFnAXO0Y92AcG0IMtk+NTc17tI8X0QdVz
	IXB7myJuRqYmv/1QZjM6h+9htXRbv9I=
From: George Guo <dongtai.guo@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: maobibo@loongson.cn,
	loongarch@lists.linux.dev,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH v4 0/2] LoongArch: kexec: avoid clobbering the QEMU FDT
Date: Wed,  1 Jul 2026 23:59:55 +0800
Message-Id: <20260701155957.534779-1-dongtai.guo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260701_090029_923049_212FE4F5 
X-CRM114-Status: GOOD (  13.06  )
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

This series fixes two ways the LoongArch kexec path can clobber the
firmware-provided FDT that QEMU places at physical 0x100000, which made the
second kernel boot silently (earlycon auto-detection reads a corrupted FDT).

Patch 1 moves the relocation trampoline off the hardcoded 0x100000 onto the
kexec core's control_code_page (as arm64/riscv do), so machine_kexec_prepare()
no longer overwrites the FDT.

Patch 2 removes the remaining fixed command-line address (KEXEC_CMDLINE_ADDR,
0x108000).  QEMU's machine FDT declares fdt_totalsize = 1MB and thus claims the
whole [0x100000, 0x200000) upper half of the reserved 2MB, so 0x108000 lives
inside the FDT and only survives because the FDT's real content is small
(~3.6KB) and 0x108000 falls in the trailing slack.  The command line is passed
to the second kernel in register a1, not at a fixed address, so it is loaded
into its own kexec segment instead, removing the overlap regardless of FDT
size.

This addresses the two questions raised on the v3 trampoline patch [1]:
 - "how to avoid the cmdline overlapping FDT" -> patch 2.
 - "how to avoid the control page being corrupted by the new kernel" -> the
   trampoline is executed only by the current kernel and is dead once the new
   kernel starts, so being overwritten afterwards is harmless; the kexec core
   also keeps the control page outside every relocation destination, so it
   cannot be corrupted during relocation.  The command line is different (it is
   read by the new kernel), which is why only the trampoline uses the core page.

Tested with tools/testing/selftests/kho/vmtest.sh on LoongArch (QEMU,
kexec_file_load): the second kernel boots with the full command line and
earlycon, and KHO restore succeeds.

This series depends on [2] ("LoongArch: kexec: Fix address space mismatch in
command line lookup"), whose char head[] change patch 2 builds on.

[1] https://lore.kernel.org/all/20260604114106.391502-1-dongtai.guo@linux.dev/
[2] https://lore.kernel.org/all/20260701023747.56221-1-dongtai.guo@linux.dev/

Changes in v4:
 - Add patch 2: load the command line in its own kexec segment, dropping the
   fixed KEXEC_CMDLINE_ADDR that overlaps the QEMU FDT (addresses the command
   line concern from the v3 review).
 - Patch 1 (relocation trampoline): drop the KEXEC_CMDLINE_ADDR comment added
   in v3 that claimed 0x108000 does not overlap the FDT (it does; patch 2
   removes the fixed address entirely).  No functional change otherwise.

v3: https://lore.kernel.org/all/20260604114106.391502-1-dongtai.guo@linux.dev/
v2: https://lore.kernel.org/all/20260601033820.38805-1-dongtai.guo@linux.dev/
v1: https://lore.kernel.org/all/20260528135828.196953-1-dongtai.guo@linux.dev/

George Guo (2):
  LoongArch: kexec: use core control page for relocation trampoline to
    avoid QEMU FDT conflict
  LoongArch: kexec: load the command line in its own segment

 arch/loongarch/include/asm/kexec.h         |  1 +
 arch/loongarch/kernel/machine_kexec.c      | 38 ++++++++++------------
 arch/loongarch/kernel/machine_kexec_file.c | 33 +++++++++++++++++--
 3 files changed, 49 insertions(+), 23 deletions(-)

-- 
2.25.1


