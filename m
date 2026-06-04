Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D724CD6E7B
	for <kexec@archiver.kernel.org>; Thu,  4 Jun 2026 13:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=z8aT4Za5Qhsy8uIIRwj+ts//dCl77c8YOPDnJ67EKYk=; b=JrsdwcvgLww0w3zYLbjACjBNIz
	sZD1ulHdsTZi43BR+ClpfXshFA4hEZEsyajMhW8lWoA0HlTHIkUukqZ1a/MYmpjXOOiTYwKsRIGF1
	/36KLD9Q7naNN9omaE6R8Dc6r0aTw4efk/iGQ1LHE85aLTZ5MrIR7GwbASWxG1LUviJrid4wiNpzj
	uSsQ/v1baTZi/zjZrOI8iw55Mly4K7SW7N5mAfSTamFuGu+mSCgPDGA29Dy6de+Q4PKAiTKWZMUT1
	CbhJ4XjNpOI0sPBWtGuYZd79WoJtVSy8iexohEJ8a268JX6OCe+ea7ChCHMi6w0+1gTRs9ayuA7K0
	AfmkpH7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV83w-0000000GmIw-3WtA;
	Thu, 04 Jun 2026 13:24:44 +0000
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV83p-0000000GmAX-07Wx;
	Thu, 04 Jun 2026 13:24:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780579465; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=z8aT4Za5Qhsy8uIIRwj+ts//dCl77c8YOPDnJ67EKYk=;
	b=OA00UcI2Mb5YO2RKZw7DI2O8hY/Mb+Q2tTKQt+oRgCh73qLmb0pU8WKBXgbqGVUoC76QICB7OXWEoBg4bLK+hztdAhRNsWv22+uea5ffdS/oitg/UlzzdwEPnSfcD3SwnEer5LpJXGVb+8jzmfI00BUgevDODLcB+q3I3bV6V/0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X4AKnWJ_1780579461;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X4AKnWJ_1780579461 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Jun 2026 21:24:23 +0800
From: fangyu.yu@linux.alibaba.com
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Nick Kossifidis <mick@ics.forth.gr>
Cc: Song Shuai <songshuaishuai@tinylab.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Richard Lyu <richard.lyu@suse.com>,
	Nam Cao <namcao@linutronix.de>,
	Jisheng Zhang <jszhang@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	guoren@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH v3 0/9] riscv: kexec: Make kexec/kdump robust under VS-mode
Date: Thu,  4 Jun 2026 21:24:09 +0800
Message-Id: <20260604132418.15725-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260604_062437_999638_B66BF0AD 
X-CRM114-Status: GOOD (  12.40  )
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

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

In a RISC-V kernel, both kexec and crashdump need to hand off execution
to the next kernel after tearing down the current kernel address space.
However, under virtualization the guest uses two-stage address
translation, and pc does not jump to stvec after setting satp to zero,
so the legacy single-step "csrw satp,0 + stvec redirect" sequence
traps with "kvm run failed Operation not supported" and the VCPU dies.

This patch set introduces a dedicated kexec trampoline text section and
builds a minimal trampoline page table for it. Both handoffs are then
reworked into a two-pass trampoline:

    1. First enter via the kernel VA, install the trampoline page table,
       and jump to the trampoline VA(=PA) of the entry stub;
    2. Continue execution with PC already on a PA, drop SATP with
       csrw satp,0 (now safe because PC re-anchoring is moot), and
       jump directly to the target -- either the crash kernel entry
       (crash path) or the per-image control_code_buffer that runs
       the relocate body with SATP=0 throughout (normal path).

With this, both kexec and crashdump in RISC-V guests become robust
against the two-stage translation.

Tested on QEMU virt under two configurations:

  * HS-mode bare (QEMU TCG) -- regression check
      - normal kexec: kexec -l/-e succeeds, second kernel boots and
                      prints the userspace SECOND BOOT marker.
      - crash kdump: panic triggers crash kernel boot, /proc/vmcore
                     opens cleanly in crash(1) and shows the panic
                     backtrace.

  * VS-mode (L0 x86 + QEMU TCG -> L1 riscv64 + KVM -> L2)
      Before this series, both paths die with
          kvm run failed Operation not supported
      and an all-zero M-mode register dump on the SATP transition.
      After this series, both paths succeed end-to-end and the
      vmcore opens cleanly in crash.

---
Changes in v3 (Sashiko AI review):
    - Add two new Fixes: patches at the start of the series:
      #1: machine_kexec_cleanup() was empty, so the set_memory_x()
          call in prepare() leaked an executable direct-map page back
          to the buddy allocator on kexec -u (W^X bypass). Fix: add
          set_memory_nx() in cleanup.
      #2: machine_kexec_prepare() FDT search checked
          memsz <= sizeof(fdt) but read sizeof(fdt) bytes from
          segment[i].buf, which can be smaller than memsz. Fix: check
          bufsz instead.
    - Inline the .kexec.tramp.text section definition directly into
      vmlinux.lds.S instead of using a macro in image-vars.h.
    - Rewrite map_tramp_page() to share a single set of lower-level
      page tables between the VA and PA mappings (5 BSS pages instead
      of 9), with a collision-safe walker that only populates entries
      still zero. Add Sv32 support.
    - Link to v2:
      https://lore.kernel.org/linux-riscv/20260526125009.2404-1-fangyu.yu@linux.alibaba.com/
    - Link to v1:
      https://lore.kernel.org/linux-riscv/20260324114527.91494-1-fangyu.yu@linux.alibaba.com/


Fangyu Yu (9):
  riscv: kexec: Reset executable bit on the control code page in cleanup
  riscv: kexec: Bound FDT search by source buffer size, not destination
  riscv: Add kexec trampoline text section to vmlinux.lds.S
  riscv: kexec: Place norelocate trampoline into .kexec.tramp.text
  riscv: kexec: Build trampoline page tables for crash kernel entry
  riscv: kexec: Switch to trampoline page table before norelocate
  riscv: kexec: Always build the trampoline page table
  riscv: kexec: Add the relocate-trampoline wrapper
  riscv: kexec: Route normal kexec through the trampoline page table

 arch/riscv/include/asm/kexec.h     |   5 +
 arch/riscv/kernel/kexec_relocate.S |  92 +++++++++++-----
 arch/riscv/kernel/machine_kexec.c  | 171 +++++++++++++++++++++++++++--
 arch/riscv/kernel/vmlinux.lds.S    |  10 ++
 4 files changed, 241 insertions(+), 37 deletions(-)

-- 
2.50.1


