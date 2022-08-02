Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397A6C19F2B
	for <kexec@archiver.kernel.org>; Tue,  2 Aug 2022 12:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=xqih1PxKEg20JSwJc1ryDwtQYrU/UXLKCwu1N0DI7Is=; b=icNl6pRr2MoadY
	8jPuMGKVLtqtezVcoVuzTluk97ktjCnxk49lF4sT6wzWk4KclwlJUCz4D4pROpBHzAjGTAdL1vZdD
	9ApInQtK0DhJKqmcZ+u+Lgz42QHnqSzoSkzjgiIX2PbzYTFFLf9gNC+Z360QHzLg+8JLW/ucG/vW5
	oBXucqLvjtU26Ym5YeyNdrV+Qv1kP55qt3cOsbMxqC3WhQr/gZEXxF+knLcAQ8SrBNXHdVNC4DJc3
	WcaiP7IvhB2FeCVyjtI3armUJsnhvRjrc5raFbfFiF3cJIXJggWJr6j/nKauXh0p8HCXu8VJQkoyM
	E9sh95jqPPHcF/kpJEng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIqr8-00Ds9Z-Rn; Tue, 02 Aug 2022 12:18:38 +0000
Received: from out199-17.us.a.mail.aliyun.com ([47.90.199.17])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIqr1-00Drxh-5n; Tue, 02 Aug 2022 12:18:34 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0VLBiqD2_1659442701;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VLBiqD2_1659442701)
          by smtp.aliyun-inc.com;
          Tue, 02 Aug 2022 20:18:22 +0800
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
	huanyi.xj@alibaba-inc.com,
	heinrich.schuchardt@canonical.com,
	k-hagio-ab@nec.com,
	hschauhan@nulltrace.org,
	yixun.lan@gmail.com,
	Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH V5 0/6] RISC-V fixups to work with crash tool
Date: Tue,  2 Aug 2022 20:18:12 +0800
Message-Id: <20220802121818.2201268-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220802_051831_543511_3055A6FA 
X-CRM114-Status: GOOD (  10.60  )
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
and improvements for vmcoreinfo, memory layout dump and fixup chedule out issue
in machine_crash_shutdown().

The main changes in the six patchs as below,
Patch 1: use __smp_processor_id() instead of smp_processor_id() to cleanup
         the console prints.
Patch 2: Add VM layout, va bits, ram base to vmcoreinfo, which can simplify
         the development of crash tool as ARM64 already did
         (arch/arm64/kernel/crash_core.c).
Patch 3: Add modules to virtual kernel memory layout dump.
Patch 4: Fixup to get correct kernel mode PC for vmcore.
Patch 5: Updates vmcoreinfo.rst.
Patch 6: Fixup schedule out issue in machine_crash_shutdown()

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

Xianting Tian (6):
  RISC-V: use __smp_processor_id() instead of smp_processor_id()
  RISC-V: Add arch_crash_save_vmcoreinfo support
  riscv: Add modules to virtual kernel memory layout dump
  RISC-V: Fixup getting correct current pc
  riscv: crash_core: Export kernel vm layout, phys_ram_base
  RISC-V: Fixup schedule out issue in machine_crash_shutdown()

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
