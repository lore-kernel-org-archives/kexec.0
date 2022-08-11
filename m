Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0156AC25B0C
	for <kexec@archiver.kernel.org>; Thu, 11 Aug 2022 07:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=LSvdmI/KunnoXRzDH3wSW7z9EQXY518uSss4ayxaLMM=; b=R3HZrdrk7eP1/X
	lNDQpaOBzG8h25ywGLu6PNO3TzzjbhEYf85bpcfwTAhzys5zunIBcGFZki2g2nwG8vJN4VZ0OLo37
	VkpwWCaAkunXJe3K07JEbEac19wRchh7YNTXxVbSmtGMbUjlxm06p11O69TeBJIfW6MSDgGxZyFv1
	SlwUI10PitmEjYAgeJ7c6Mc47BM23pvsGpgYTt6OReC6HeY5aaCHJFDxyQAxgKxLmiL9Tu5KX8NpW
	xHaHyLRh/ovkONQ/tQ5HB1fqgYMlRJFVjch2dcnl2OR5flI8LHwrGPh8iBdof/qrbT3tNAWEsNRhC
	iTaLZbFzHa1uL/KGf11w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oM2pc-009lzz-Tj; Thu, 11 Aug 2022 07:42:17 +0000
Received: from out199-9.us.a.mail.aliyun.com ([47.90.199.9])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oM2pN-009lb7-AP; Thu, 11 Aug 2022 07:42:03 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0VLyDAKe_1660203712;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VLyDAKe_1660203712)
          by smtp.aliyun-inc.com;
          Thu, 11 Aug 2022 15:41:53 +0800
From: Xianting Tian <xianting.tian@linux.alibaba.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	anup@brainfault.org,
	heiko@sntech.de,
	guoren@kernel.org,
	mick@ics.forth.gr,
	alexandre.ghiti@canonical.com,
	bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com,
	corbet@lwn.net,
	Conor.Dooley@microchip.com
Cc: kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	crash-utility@redhat.com,
	heinrich.schuchardt@canonical.com,
	k-hagio-ab@nec.com,
	hschauhan@nulltrace.org,
	yixun.lan@gmail.com,
	Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH V6 0/6] RISC-V fixups to work with crash tool
Date: Thu, 11 Aug 2022 15:41:44 +0800
Message-Id: <20220811074150.3020189-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220811_004201_654530_F4D5212B 
X-CRM114-Status: GOOD (  12.68  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

I ever sent the patch 1 in the link:
https://patchwork.kernel.org/project/linux-riscv/patch/20220708073150.352830-3-xianting.tian@linux.alibaba.com/
And patch 2,3 in the link:
https://patchwork.kernel.org/project/linux-riscv/patch/20220714113300.367854-2-xianting.tian@linux.alibaba.com/
https://patchwork.kernel.org/project/linux-riscv/patch/20220714113300.367854-3-xianting.tian@linux.alibaba.com/

This patch set just put these patches together, and with three new patch 4, 5, 6.
these six patches are the fixups for machine_kexec, kernel mode PC for vmcore
and improvements for vmcoreinfo, memory layout dump and fixup schedule out issue
in machine_crash_shutdown().

The main changes in the six patchs as below,
Patch 1: Fixup use of smp_processor_id() in preemptible context, to cleanup
         the console prints.
Patch 2: Fixup to get correct kernel mode PC for kernel mode regs for vmcore.
Patch 3: Fixup schedule out issue in machine_crash_shutdown()
Patch 4: Add modules to virtual kernel memory layout dump.
Patch 5: Add VM layout, va bits, ram base to vmcoreinfo, which can simplify
         the development of crash tool as ARM64 already did
         (arch/arm64/kernel/crash_core.c).
Patch 6: Updates vmcoreinfo.rst for vmcoreinfo export for RISCV64.

With these six patches(patch 2 is must), crash tool can work well to analyze
a vmcore. The patches for crash tool for RISCV64 is in the link:
https://lore.kernel.org/linux-riscv/20220801043040.2003264-1-xianting.tian@linux.alibaba.com/

------
Changes v1 -> v2:
  1, remove the patch "Add a fast call path of crash_kexec()" from this series
     of patches, as it already applied to riscv git.
     https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/commit/?h=for-next&id=3f1901110a89b0e2e13adb2ac8d1a7102879ea98
  2, add 'Reviewed-by' based on the comments of v1.
Changes v2 -> v3:
  use "riscv" instead of "riscv64" in patch 5 subject line.
Changes v3 -> v4:
  use "riscv" instead of "riscv64" in the summary of patch 5 subject line.
Changes v4 -> v5:
  add a new patch "RISC-V: Fixup schedule out issue in machine_crash_shutdown()" 
Changes v5 -> v6:
  1, move "fixup" patches to the start of the patch set.
  2, change patch 1, 2, 6's subject to make it tell more what it's about. 
  3, add Fixes for patch 3.
  4, adjuest the changes format for patch 6.


Xianting Tian (6):
  RISC-V: kexec: Fixup use of smp_processor_id() in preemptible context
  RISC-V: Fixup get incorrect user mode PC for kernel mode regs
  RISC-V: Fixup schedule out issue in machine_crash_shutdown()
  RISC-V: Add modules to virtual kernel memory layout dump
  RISC-V: Add arch_crash_save_vmcoreinfo support
  Documentation: kdump: describe VMCOREINFO export for RISCV64

 .../admin-guide/kdump/vmcoreinfo.rst          | 31 +++++++++++++++++++
 arch/riscv/kernel/Makefile                    |  1 +
 arch/riscv/kernel/crash_core.c                | 29 +++++++++++++++++
 arch/riscv/kernel/crash_save_regs.S           |  2 +-
 arch/riscv/kernel/machine_kexec.c             | 28 ++++++++++++++---
 arch/riscv/mm/init.c                          |  4 +++
 6 files changed, 89 insertions(+), 6 deletions(-)
 create mode 100644 arch/riscv/kernel/crash_core.c

-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
